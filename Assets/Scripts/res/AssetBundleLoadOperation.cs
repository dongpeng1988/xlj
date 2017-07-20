using UnityEngine;
using System.Collections;
namespace sw.res
{
   
    internal abstract class AssetBundleLoadOperation
    {
        public SubAssetLoader loader;
       
        public object[] param;


        abstract public bool Update();

    }


    public delegate void LoadSceneCallback(bool success, object[] param);
    internal class AssetBundleLoadLevelOperation : AssetBundleLoadOperation
    {
        protected string m_AssetBundleName;
        protected string m_LevelName;
        protected bool m_IsAdditive;
        protected string m_DownloadingError;
        protected AsyncOperation m_Request;
        public LoadSceneCallback callback;

        public AssetBundleLoadLevelOperation(string assetbundleName, string levelName, bool isAdditive,LoadSceneCallback callback,object[] param)
        {
            m_AssetBundleName = assetbundleName;
            m_LevelName = levelName;
            m_IsAdditive = isAdditive;
            this.callback = callback;
            this.param = param;
        }

        public override bool Update()
        {
            if (m_Request != null)
            {
                if (m_Request.isDone)
                {
                    callback(true,param);
                    loader.UnloadAssetBundle(m_AssetBundleName);
                    return false;
                }
                else
                    return true;
            } 

            LoadedAssetBundle bundle = loader.GetLoadedAssetBundle(m_AssetBundleName, out m_DownloadingError);
            if (bundle != null)
            {
                bundle.m_AssetBundle.LoadAllAssets();
                if (m_IsAdditive)
                    m_Request = Application.LoadLevelAdditiveAsync(m_LevelName);
                else
                    m_Request = Application.LoadLevelAsync(m_LevelName);
                return true;
            }
            else
                return true;
        }

       
    }

    internal abstract class AssetBundleLoadAssetOperation : AssetBundleLoadOperation
    {
        public abstract T GetAsset<T>() where T : UnityEngine.Object;
    }

    public delegate void LoadAssetCallback(Object obj, object[] param);

    internal class AssetBundleLoadAssetOperationFull : AssetBundleLoadAssetOperation
    {
        protected string m_AssetBundleName;
        protected string m_AssetName;
        protected string m_DownloadingError;
        protected System.Type m_Type;
        protected AssetBundleRequest m_Request = null;
        public LoadAssetCallback callback;
        public AssetBundleLoadAssetOperationFull(string bundleName, string assetName, System.Type type, LoadAssetCallback callback, object[] param)
        {
            m_AssetBundleName = bundleName;
            m_AssetName = assetName;
            m_Type = type;
            this.callback = callback;
            this.param = param;
        }

        public override T GetAsset<T>()
        {
            if (m_Request != null && m_Request.isDone)
                return m_Request.asset as T;
            else
                return null;
        }

        // Returns true if more Update calls are required.
        public override bool Update()
        {
            if (m_Request != null)
            {
                if (m_Request.isDone)
                {
                    callback(m_Request.asset, param);
                    loader.UnloadAssetBundle(m_AssetBundleName);
                    return false;
                }
            }
            else
            {
                LoadedAssetBundle bundle = loader.GetLoadedAssetBundle(m_AssetBundleName, out m_DownloadingError);
                if (bundle != null)
                {
                    m_Request = bundle.m_AssetBundle.LoadAssetAsync(m_AssetName, m_Type);

                }

            }
            return true;


        }


    }

    

}