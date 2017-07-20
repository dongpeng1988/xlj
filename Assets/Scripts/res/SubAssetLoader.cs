



using System.Collections.Generic;
using System.IO;
#if UNITY_EDITOR
using UnityEditor;
#endif
using UnityEngine;
using sw.util;
namespace sw.res
{

    internal class SubAssetLoader
    {
        const string kAssetBundlesPath = "/AssetBundles/";
        
        string pkgResBase;//resource base in package
        string localResBase;//local download dir
        string localFileBase;//local download dir
        public AssetBundleManifest m_Manifest = null;
#if UNITY_EDITOR
        //static bool m_SimulateAssetBundleInEditor;
       
        const string kSimulateAssetBundles = "SimulateAssetBundles";
      
#endif
        Dictionary<string, LoadedAssetBundle> m_LoadedAssetBundles = new Dictionary<string, LoadedAssetBundle>();
        Dictionary<string, WWW> m_DownloadingWWWs = new Dictionary<string, WWW>();
        Dictionary<string, string> m_DownloadingErrors = new Dictionary<string, string>();
        List<AssetBundleLoadOperation> m_InProgressOperations = new List<AssetBundleLoadOperation>();
        Dictionary<string, string[]> m_Dependencies = new Dictionary<string, string[]>();
        List<string> pendingLoad;
        string[] m_Variants = { };
        //sub dir name
        public string SubName;
        public void Initialize()
        {
#if UNITY_EDITOR
            LoggerHelper.Debug("We are " + (AssetLoader2.m_SimulateAssetBundleInEditor ? "in Editor simulation mode" : "in normal mode"));
#endif
             
            
#if UNITY_EDITOR
            // If we're in Editor simulation mode, we don't need the manifest assetBundle.
            if (AssetLoader2.m_SimulateAssetBundleInEditor)
                return;
#endif
            preparePath();
            LoadAssetBundle(SubName, true);
            var operation = new AssetBundleLoadAssetOperationFull(SubName, "AssetBundleManifest", typeof(AssetBundleManifest), OnLoadManifest, null);
            operation.loader = this;
            m_InProgressOperations.Add(operation);
        }
        void preparePath()
        {

            //if (Application.isEditor && m_SimulateAssetBundleInEditor)
            //{
            //    pkgResBase = "file://" + System.Environment.CurrentDirectory.Replace("\\", "/"); // Use the build output folder directly.
            //    localResBase = pkgResBase;
            //    localFileBase = System.Environment.CurrentDirectory.Replace("\\", "/"); // Use the build output folder directly.
            //}
            //else// if (Application.isMobilePlatform || Application.isConsolePlatform)
            {
                pkgResBase = Application.streamingAssetsPath;
                if (!pkgResBase.Contains("file://"))
                    pkgResBase = "file://" + pkgResBase;
                localResBase = "file://" + Application.persistentDataPath + "/res";
                localFileBase = Application.persistentDataPath + "/res";  
            }
            string platformFolderForAssetBundles =
#if UNITY_EDITOR
 GetPlatformFolderForAssetBundles(EditorUserBuildSettings.activeBuildTarget);
#else
			GetPlatformFolderForAssetBundles(Application.platform);
#endif
            pkgResBase =pkgResBase + kAssetBundlesPath + platformFolderForAssetBundles + "/" + SubName + "/";
            localResBase = localResBase + kAssetBundlesPath + platformFolderForAssetBundles + "/" + SubName + "/";
            localFileBase = localFileBase + kAssetBundlesPath + platformFolderForAssetBundles + "/" + SubName + "/";
            LoggerHelper.Debug("pkgResBase:"+pkgResBase+",localResBase:"+localResBase+",localFileBase:"+localFileBase);

        }
        void OnLoadManifest(Object obj, object[] param)
        {
            m_Manifest = obj as AssetBundleManifest;
            if(m_Manifest == null)
            {
                Debug.LogError("load manifest error");
            }
            else
            {
              foreach(string n in   m_Manifest.GetAllAssetBundles())
                {
                    Debug.LogFormat("1st -> [Name:{0} <--> Hash:{1}]", n, m_Manifest.GetAssetBundleHash(n));
                    Debug.LogFormat("2nd -> [Name:{0} <--> Hash:{1}]", n, m_Manifest.GetAssetBundleHash(n));
                } ;

                if(pendingLoad != null)
                {
                    foreach (string assetBundleName in pendingLoad)
                        LoadAssetBundle(assetBundleName);
                }
            }
        }
        protected void LoadAssetBundle(string assetBundleName,  bool isLoadingAssetBundleManifest = false)
        {
#if UNITY_EDITOR
            // If we're in Editor simulation mode, we don't have to really load the assetBundle and its dependencies.
            if (AssetLoader2.m_SimulateAssetBundleInEditor)
                return;
#endif

            if (!isLoadingAssetBundleManifest)
                assetBundleName = RemapVariantName(assetBundleName);

            // Check if the assetBundle has already been processed.
            bool isAlreadyProcessed = LoadAssetBundleInternal(assetBundleName,  isLoadingAssetBundleManifest);

            // Load dependencies.
            if (!isAlreadyProcessed && !isLoadingAssetBundleManifest)
                LoadDependencies(assetBundleName);
        }
        string GetAssetUrl(string assetBundleName)
        {
            
          

            string url = localFileBase + assetBundleName;
            if(File.Exists(url))
            {
                return localResBase + assetBundleName;
            }
            else
                return pkgResBase + assetBundleName;
        }
        // Where we actuall call WWW to download the assetBundle.
        protected bool LoadAssetBundleInternal(string assetBundleName,  bool isLoadingAssetBundleManifest)
        {
            // Already loaded.
            LoadedAssetBundle bundle = null;
            m_LoadedAssetBundles.TryGetValue(assetBundleName, out bundle);
            if (bundle != null)
            {
                bundle.m_ReferencedCount++;
                return true;
            }

            // @TODO: Do we need to consider the referenced count of WWWs?
            // In the demo, we never have duplicate WWWs as we wait LoadAssetAsync()/LoadLevelAsync() to be finished before calling another LoadAssetAsync()/LoadLevelAsync().
            // But in the real case, users can call LoadAssetAsync()/LoadLevelAsync() several times then wait them to be finished which might have duplicate WWWs.
            if (m_DownloadingWWWs.ContainsKey(assetBundleName) || m_DownloadingErrors.ContainsKey(assetBundleName))
                return true;

            WWW download = null;
            string url =GetAssetUrl( assetBundleName);
             LoggerHelper.Debug("url:" + url + ",isLoadingAssetBundleManifest:" + isLoadingAssetBundleManifest);
            // For manifest assetbundle, always download it as we don't have hash for it.
             if (isLoadingAssetBundleManifest)
                 download = new WWW(url);
             else
             {
                 download = WWW.LoadFromCacheOrDownload(url, m_Manifest.GetAssetBundleHash(assetBundleName), 0);
                 LoggerHelper.Debug("start download :" + url + ",at frame:" + Time.frameCount + ",hash:" + m_Manifest.GetAssetBundleHash(assetBundleName));
             }
            m_DownloadingWWWs.Add(assetBundleName, download);

            return false;
        }

        // Where we get all the dependencies and load them all.
        protected void LoadDependencies(string assetBundleName)
        {
            if (m_Manifest == null)
            {
                Debug.LogError("Please initialize AssetBundleManifest by calling AssetBundleManager.Initialize()");
                return;
            }

            // Get dependecies from the AssetBundleManifest object..
            string[] dependencies = m_Manifest.GetAllDependencies(assetBundleName);
            if (dependencies.Length == 0)
                return;

            for (int i = 0; i < dependencies.Length; i++)
                dependencies[i] = RemapVariantName(dependencies[i]);

            // Record and load all dependencies.
            m_Dependencies.Add(assetBundleName, dependencies);
            for (int i = 0; i < dependencies.Length; i++)
                LoadAssetBundleInternal(dependencies[i], false);
        }
        protected string RemapVariantName(string assetBundleName)
        {
            string[] bundlesWithVariant = m_Manifest.GetAllAssetBundlesWithVariant();

            // If the asset bundle doesn't have variant, simply return.
            if (System.Array.IndexOf(bundlesWithVariant, assetBundleName) < 0)
                return assetBundleName;

            string[] split = assetBundleName.Split('.');

            int bestFit = int.MaxValue;
            int bestFitIndex = -1;
            // Loop all the assetBundles with variant to find the best fit variant assetBundle.
            for (int i = 0; i < bundlesWithVariant.Length; i++)
            {
                string[] curSplit = bundlesWithVariant[i].Split('.');
                if (curSplit[0] != split[0])
                    continue;

                int found = System.Array.IndexOf(m_Variants, curSplit[1]);
                if (found != -1 && found < bestFit)
                {
                    bestFit = found;
                    bestFitIndex = i;
                }
            }

            if (bestFitIndex != -1)
                return bundlesWithVariant[bestFitIndex];
            else
                return assetBundleName;
        }
        protected void UnloadDependencies(string assetBundleName)
        {
            string[] dependencies = null;
            if (!m_Dependencies.TryGetValue(assetBundleName, out dependencies))
                return;

            // Loop dependencies.
            foreach (var dependency in dependencies)
            {
                UnloadAssetBundleInternal(dependency);
            }

            m_Dependencies.Remove(assetBundleName);
        }

        protected void UnloadAssetBundleInternal(string assetBundleName)
        {
            string error;
            LoadedAssetBundle bundle = GetLoadedAssetBundle(assetBundleName, out error);
            if (bundle == null)
                return;

            if (--bundle.m_ReferencedCount == 0)
            {
                bundle.m_AssetBundle.Unload(false);
                m_LoadedAssetBundles.Remove(assetBundleName);
                 LoggerHelper.Debug("AssetBundle " + assetBundleName + " has been unloaded successfully");
            }
        }
        public LoadedAssetBundle GetLoadedAssetBundle(string assetBundleName, out string error)
        {
            if (m_DownloadingErrors.TryGetValue(assetBundleName, out error))
                return null;

            LoadedAssetBundle bundle = null;
            m_LoadedAssetBundles.TryGetValue(assetBundleName, out bundle);
            if (bundle == null)
                return null;

            // No dependencies are recorded, only the bundle itself is required.
            string[] dependencies = null;
            if (!m_Dependencies.TryGetValue(assetBundleName, out dependencies))
                return bundle;

            // Make sure all dependencies are loaded
            foreach (var dependency in dependencies)
            {
                if (m_DownloadingErrors.TryGetValue(assetBundleName, out error))
                    return bundle;

                // Wait all the dependent assetBundles being loaded.
                LoadedAssetBundle dependentBundle;
                m_LoadedAssetBundles.TryGetValue(dependency, out dependentBundle);
                if (dependentBundle == null)
                    return null;
            }

            return bundle;
        }
#if UNITY_EDITOR
        public static string GetPlatformFolderForAssetBundles(BuildTarget target)
        {
            switch (target)
            {
                case BuildTarget.Android:
                    return "Android";
                case BuildTarget.iOS:
                    return "iOS";
                case BuildTarget.WebPlayer:
                    return "WebPlayer";
                case BuildTarget.StandaloneWindows:
                case BuildTarget.StandaloneWindows64:
                    return "Windows";
                case BuildTarget.StandaloneOSXIntel:
                case BuildTarget.StandaloneOSXIntel64:
                case BuildTarget.StandaloneOSXUniversal:
                    return "OSX";
                // Add more build targets for your own.
                // If you add more targets, don't forget to add the same platforms to GetPlatformFolderForAssetBundles(RuntimePlatform) function.
                default:
                    return null;
            }
        }
#endif

        static string GetPlatformFolderForAssetBundles(RuntimePlatform platform)
        {
            switch (platform)
            {
                case RuntimePlatform.Android:
                    return "Android";
                case RuntimePlatform.IPhonePlayer:
                    return "iOS";
                case RuntimePlatform.WindowsWebPlayer:
                case RuntimePlatform.OSXWebPlayer:
                    return "WebPlayer";
                case RuntimePlatform.WindowsPlayer:
                    return "Windows";
                case RuntimePlatform.OSXPlayer:
                    return "OSX";
                // Add more build platform for your own.
                // If you add more platforms, don't forget to add the same targets to GetPlatformFolderForAssetBundles(BuildTarget) function.
                default:
                    return null;
            }
        }
        // Unload assetbundle and its dependencies.
        public void UnloadAssetBundle(string assetBundleName)
        {
#if UNITY_EDITOR
            // If we're in Editor simulation mode, we don't have to load the manifest assetBundle.
            if (AssetLoader2.m_SimulateAssetBundleInEditor)
                return;
#endif

            //Debug.Log(m_LoadedAssetBundles.Count + " assetbundle(s) in memory before unloading " + assetBundleName);

            UnloadAssetBundleInternal(assetBundleName);
            UnloadDependencies(assetBundleName);

            //Debug.Log(m_LoadedAssetBundles.Count + " assetbundle(s) in memory after unloading " + assetBundleName);
        }
        void AddPendingLoad(string assetBundleName)
        {
            if(pendingLoad == null)
                pendingLoad = new List<string>();
            pendingLoad.Add(assetBundleName);
        }
        public void LoadAsset(string assetBundleName, string assetName,System.Type type, LoadAssetCallback callback, params object[] param)
        {
            AssetBundleLoadAssetOperation operation = null;
#if UNITY_EDITOR
            if (AssetLoader2.m_SimulateAssetBundleInEditor)
            {
                string[] assetPaths = AssetDatabase.GetAssetPathsFromAssetBundleAndAssetName(assetBundleName, assetName);
                if (assetPaths.Length == 0)
                {
                    Debug.LogError("There is no asset with name \"" + assetName + "\" in " + assetBundleName);
                    callback(null, param);
                    return;
                }

                // @TODO: Now we only get the main object from the first asset. Should consider type also.
                Object target = AssetDatabase.LoadMainAssetAtPath(assetPaths[0]);
                //operation = new AssetBundleLoadAssetOperationSimulation(target);
                callback(target, param);
            }
            else
#endif
            {
               if(m_Manifest == null)
               {
                   AddPendingLoad(assetBundleName);
               }
               else
                    LoadAssetBundle(assetBundleName);
                operation = new AssetBundleLoadAssetOperationFull(assetBundleName, assetName, type,callback,param);
                operation.loader = this;
                m_InProgressOperations.Add(operation);
            }
        }
        public void LoadScene(string assetBundleName, string levelName, bool isAdditive, LoadSceneCallback callback, object[] param)
        {
            AssetBundleLoadLevelOperation operation = null;
#if UNITY_EDITOR
            if (AssetLoader2.m_SimulateAssetBundleInEditor)
            {
                string[] levelPaths = AssetDatabase.GetAssetPathsFromAssetBundleAndAssetName(assetBundleName, levelName);
                if (levelPaths.Length == 0)
                {
                    ///@TODO: The error needs to differentiate that an asset bundle name doesn't exist
                    //        from that there right scene does not exist in the asset bundle...

                    Debug.LogError("There is no scene with name \"" + levelName + "\" in " + assetBundleName);
                    callback(false, param);
                    return;
                }

                if (isAdditive)
                    EditorApplication.LoadLevelAdditiveInPlayMode(levelPaths[0]);
                else
                    EditorApplication.LoadLevelInPlayMode(levelPaths[0]);
                 
            }
            else
#endif
            {
                LoadAssetBundle(assetBundleName);
                operation = new AssetBundleLoadLevelOperation(assetBundleName, levelName, isAdditive,callback,param);
                operation.callback = callback;
                operation.loader = this;
                m_InProgressOperations.Add(operation);
            }
             
        }
        public void Update()
        {
            // Collect all the finished WWWs.
            var keysToRemove = new List<string>();
            foreach (var keyValue in m_DownloadingWWWs)
            {
                WWW download = keyValue.Value;

                // If downloading fails.
                if (download.error != null)
                {
                    Debug.LogError("download error:" + download.error + ",url:" + download.url);
                    m_DownloadingErrors.Add(keyValue.Key, download.error);
                    keysToRemove.Add(keyValue.Key);
                    continue;
                }

                // If downloading succeeds.
                if (download.isDone)
                {
                     LoggerHelper.Debug("Downloading " + keyValue.Key + " is done at frame " + Time.frameCount);
                    m_LoadedAssetBundles.Add(keyValue.Key, new LoadedAssetBundle(download.assetBundle));
                    keysToRemove.Add(keyValue.Key);
                }
            }

            // Remove the finished WWWs.
            foreach (var key in keysToRemove)
            {
                WWW download = m_DownloadingWWWs[key];
                m_DownloadingWWWs.Remove(key);
                download.Dispose();
            }

            // Update all in progress operations
            for (int i = 0; i < m_InProgressOperations.Count; )
            {
                if (!m_InProgressOperations[i].Update())
                {
                    m_InProgressOperations.RemoveAt(i);
                }
                else
                    i++;
            }
        }
    }


}