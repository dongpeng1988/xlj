using sw.util;
using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine;

public class AssetBundleManager
{
    private Dictionary<string, AssetBundleRef> assetBundleMaps_ = new Dictionary<string, AssetBundleRef>();
    private static Dictionary<string, AssetBundleRef> NoDoneAssetBundleDic = new Dictionary<string, AssetBundleRef>();
    private static byte[] rawUnityBytes_ = new byte[10];
    private static readonly string rawUnityPack_ = "UnityRaw";

    public void Clear(UnloadInstances unloadInstances)
    {
        if (unloadInstances == UnloadInstances.Yes)
        {
            LoggerHelper.Debug("Unloading bundle with true flag, object instances will also be removed, very dangerous, only allowed on application quit!");
        }
        Dictionary<string, AssetBundleRef> dictionary = new Dictionary<string, AssetBundleRef>();
        foreach (KeyValuePair<string, AssetBundleRef> pair in this.assetBundleMaps_)
        {
            if (unloadInstances == UnloadInstances.No)
            {
                if (pair.Value.ClearOnSceneSwitch == ClearOnSceneSwitch.No)
                {
                    dictionary.Add(pair.Key, pair.Value);
                    continue;
                }
                if (pair.Value.RefCount > 1)
                {
                    LoggerHelper.Error("Bundle ref not 1" + pair.Key, false);
                    dictionary.Add(pair.Key, pair.Value);
                    continue;
                }
            }
            pair.Value.Unload(unloadInstances);
        }
        this.assetBundleMaps_.Clear();
        this.assetBundleMaps_ = null;
        this.assetBundleMaps_ = dictionary;
        Dictionary<string, AssetBundleRef> dictionary2 = new Dictionary<string, AssetBundleRef>();
        foreach (AssetBundleRef ref2 in NoDoneAssetBundleDic.Values)
        {
            if (ref2.CheckIsDone())
            {
                ref2.Release();
            }
            else
            {
                dictionary2.Add(ref2.Path, ref2);
            }
        }
        NoDoneAssetBundleDic = dictionary2;
    }

    public AssetBundleData createAssetBundle(string path, ProgressFunc func, ClearOnSceneSwitch clearOnSceneSwitch)
    {
        LoggerHelper.Debug("createAssetBundle:"+path);
        AssetBundleRef ref2 = null;
        if (this.assetBundleMaps_.TryGetValue(path, out ref2))
        {
            ref2.AddRef();
            return ref2.CreateData();
        }
        if (NoDoneAssetBundleDic.TryGetValue(path, out ref2))
        {
            NoDoneAssetBundleDic.Remove(path);
            ref2.AddRef();
            this.assetBundleMaps_[path] = ref2;
            return ref2.CreateData();
        }
        ref2 = AssetBundleRef.Create(path, func, clearOnSceneSwitch);
        this.assetBundleMaps_[path] = ref2;
        ref2.AddRef();
        return ref2.CreateData();
    }

    public AssetBundleData CreateAssetBundle(string path)
    {
        return this.CreateAssetBundle(path, null);
    }

    public AssetBundleData CreateAssetBundle(string path, ProgressFunc func)
    {
        return this.createAssetBundle(path, func, ClearOnSceneSwitch.Yes);
    }

    public AssetBundleData CreateAssetBundleThatDoNotClearOnSceneSwitch(string path, ProgressFunc func)
    {
        return this.createAssetBundle(path, func, ClearOnSceneSwitch.No);
    }

    public void DestoryAssetBundle(string path)
    {
        AssetBundleRef ref2 = null;
        if (this.assetBundleMaps_.TryGetValue(path, out ref2) && ref2.Release())
        {
            this.assetBundleMaps_.Remove(path);
        }
    }

    private static void loadAssetBundle(string path, out AssetBundleCreateRequest c, out AssetBundle ab)
    {
        c = null;
        ab = null;
        
        //try
        //{
        //    byte[] binary = Encrypt.AssetDecode(path);
        //    if (path.IndexOf("Materials") > 0)
        //        Debug.Log("ss");
        //    //Debug.Log("binary len:" + binary.Length);
        //    Debug.Log("load asset:" + path);
        //    c = AssetBundle.CreateFromMemory(binary);
        //    //Debug.Log("result:" + c.isDone);
        //}
        //catch (Exception exception)
        //{
        //    LoggerHelper.Error(exception.ToString(), false);
        //}
    }
    private static void loadAssetBundle(byte[] data, string path, out AssetBundleCreateRequest c, out AssetBundle ab)
    {
        c = null;
        ab = null;
        //try
        //{
        //    byte[] binary = Encrypt.AssetDecode(data, path);
        //    LoggerHelper.Debug("decode end:" + binary.Length); 
        //    c = AssetBundle.CreateFromMemory(binary);
        //    //Debug.Log("result:" + c.isDone);
        //}
        //catch (Exception exception)
        //{
        //    LoggerHelper.Error("path:"+path+exception.ToString(), false);
        //}
    }
    public class AssetBundleData
    {
        //private AssetBundle bundle_;
        //private string path_;
        //private AssetBundleCreateRequest req_;
        private AssetBundleRef bundleRef;

        //public AssetBundleData(string tmpPath, AssetBundleCreateRequest tmpReq, AssetBundle bundle)
        //{
        //    this.path_ = tmpPath;
        //    this.req_ = tmpReq;
        //    this.bundle_ = bundle;
        //}
        internal AssetBundleData(AssetBundleRef bundle)
        {
            this.bundleRef = bundle;
        }
        public AssetBundle Bundle
        {
            get
            {
                return bundleRef.Bundle;
                //if (this.bundle_ != null)
                //{
                //    return this.bundle_;
                //}
                //if ((this.req_ != null) && this.req_.isDone)
                //{
                //    return this.req_.assetBundle;
                //}
                //return null;
            }
        }

        public bool IsDone
        {
            get
            {
                return bundleRef.CheckIsDone();
                //return ((this.bundle_ != null) || ((this.req_ != null) && this.req_.isDone));
            }
        }

        public bool IsValid
        {
            get
            {
                return bundleRef.CheckIsDone();
                //return ((this.bundle_ != null) || (this.req_ != null));
            }
        }

        public string Path
        {
            get
            {
                return bundleRef.Path;// this.path_;
            }
        }
    }

    internal class AssetBundleRef
    {
        private AssetBundle assetBundle_;
        private AssetBundleCreateRequest assetBundleReq_;
        private AssetBundleManager.ClearOnSceneSwitch clearOnSceneSwitch_ = AssetBundleManager.ClearOnSceneSwitch.Yes;
        private string path_;
        private int refCount_;
        private WWW w;
        private bool wwwIsDone;
        private AssetBundleRef()
        {
        }

        public void AddRef()
        {
            this.refCount_++;
        }
        public AssetBundle Bundle
        {
            get {
                if (this.assetBundle_ != null)
                {
                    return this.assetBundle_;
                }
                if ((this.assetBundleReq_ != null) && this.assetBundleReq_.isDone)
                {
                    return this.assetBundleReq_.assetBundle;
                }
                return null;
            }
        }
        public bool CheckIsDone()
        {
            if (wwwIsDone)
                return ((this.assetBundleReq_ == null) || this.assetBundleReq_.isDone);
            else if (w.isDone)
            {
                LoggerHelper.Debug("www load is down:" + path_ + ",cnt:" + w.bytesDownloaded+",bundle:"+w.assetBundle+",error:"+w.error);
                assetBundle_ = w.assetBundle;
                wwwIsDone = true;
                //AssetBundleManager.loadAssetBundle(w.bytes, path_, out assetBundleReq_, out assetBundle_);
                return true;
            }
            else
                return false;
        }

        public static AssetBundleManager.AssetBundleRef Create(string path, AssetBundleManager.ProgressFunc progressFunc, AssetBundleManager.ClearOnSceneSwitch clearOnSceneSwitch)
        {
            LoggerHelper.Debug("AssetBundleRef create:" + path);
            AssetBundleManager.AssetBundleRef ref2 = new AssetBundleManager.AssetBundleRef {
                path_ = path
            };
            //if(!SConfig.UseWWW())
            //{
            //    AssetBundleManager.loadAssetBundle(path, out ref2.assetBundleReq_, out ref2.assetBundle_);
            //    ref2.wwwIsDone = true;
            //}
            //else
            {
                if (path.IndexOf("://") < 0)
                    path = "file:///" + path;
                ref2.w = new WWW(path);
                ref2.wwwIsDone = false;
            }
            
            
            ref2.refCount_ = 1;
            ref2.clearOnSceneSwitch_ = clearOnSceneSwitch;
            if (progressFunc != null)
            {
                string name = path.Substring(path.LastIndexOf("/") + 1);
                progressFunc(name);
            }
            return ref2;
        }

        public AssetBundleManager.AssetBundleData CreateData()
        {
            //return new AssetBundleManager.AssetBundleData(this.path_, this.assetBundleReq_, this.assetBundle_);
            return new AssetBundleManager.AssetBundleData(this);
        }

        public bool Release()
        {
            this.refCount_--;
            if (this.RefCount <= 1)
            {
                this.Unload(AssetBundleManager.UnloadInstances.No);
                return true;
            }
            return false;
        }

        public void Unload(AssetBundleManager.UnloadInstances unloadInstances)
        {
            bool unloadAllLoadedObjects = unloadInstances == AssetBundleManager.UnloadInstances.Yes;
            if ((this.assetBundleReq_ != null) && (this.assetBundleReq_.assetBundle != null))
            {
                this.assetBundleReq_.assetBundle.Unload(unloadAllLoadedObjects);
            }
            if ((this.assetBundleReq_ != null) && !this.assetBundleReq_.isDone)
            {
                if (!AssetBundleManager.NoDoneAssetBundleDic.ContainsKey(this.path_))
                {
                    AssetBundleManager.NoDoneAssetBundleDic.Add(this.path_, this);
                }
            }
            else
            {
                if (this.assetBundle_ != null)
                {
                    this.assetBundle_.Unload(unloadAllLoadedObjects);
                }
                this.assetBundleReq_ = null;
                this.assetBundle_ = null;
            }
        }

        public AssetBundleManager.ClearOnSceneSwitch ClearOnSceneSwitch
        {
            get
            {
                return this.clearOnSceneSwitch_;
            }
        }

        public string Path
        {
            get
            {
                return this.path_;
            }
        }

        public int RefCount
        {
            get
            {
                return this.refCount_;
            }
        }
    }

    public enum ClearOnSceneSwitch
    {
        No,
        Yes
    }

    public delegate void ProgressFunc(string name);

    public enum UnloadInstances
    {
        No,
        Yes
    }
}

