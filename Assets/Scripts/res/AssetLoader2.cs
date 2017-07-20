

using System.Collections.Generic;
#if UNITY_EDITOR
using UnityEditor;
#endif
using UnityEngine;
using System.Diagnostics;
using sw.util;
namespace sw.res
{
    public class AssetLoader2 : MonoBehaviour
    {
        const string kAssetBundlesPath = "/AssetBundles/";
        const string kResPath = "res";
        const string kUIPath = "ui";

        SubAssetLoader uiLoader;
        SubAssetLoader resLoader;

#if UNITY_EDITOR
        public static bool m_SimulateAssetBundleInEditor;

        const string kSimulateAssetBundles = "SimulateAssetBundles";

#endif
    


        
       
        public void Initialize()
        {
            if (uiLoader != null || resLoader != null)
                return;
            uiLoader = new SubAssetLoader();
            resLoader = new SubAssetLoader();
            uiLoader.SubName = kUIPath;
            resLoader.SubName = kResPath;
            uiLoader.Initialize();
            resLoader.Initialize();

        }
        
        
        public void LoadAsset(string assetBundleName, string assetName, System.Type type,LoadAssetCallback callback, params object[] param)
        {
            resLoader.LoadAsset(assetBundleName, assetName, type, callback, param);
            
        }

        Dictionary<string, Shader> shaders = new Dictionary<string, Shader>();
        //Stopwatch sw = new Stopwatch();
        public void ReplaceSceneShader()
        {
            Renderer[] renders = GameObject.FindObjectsOfType<Renderer>();
            UnityEngine.Debug.Log("renders num:" + renders.Length);
            for (int i = 0; i < renders.Length; i++)
            {
                foreach(Material m in  renders[i].materials)
                {
                    string shadername = m.shader.name;
                    Shader shader;
                    if (!shaders.ContainsKey(shadername))
                    {
                        shader = Shader.Find(shadername);
                        shaders[shadername] = shader;

                    }
                    else
                        shader = shaders[shadername];
                    if (shader != null)
                        m.shader = shader;
                }
              
            }

        }
        public void ReplaceShader(GameObject go)
        {
            //long tick1;
            //sw.Reset();
            //sw.Start();
            Renderer[] renders = go.GetComponentsInChildren<Renderer>();
            //tick1 = sw.ElapsedTicks;
            
            for(int i = 0;i<renders.Length;i++)
            {
                string shadername  = renders[i].material.shader.name;
                Shader shader;
                if(!shaders.ContainsKey(shadername))
                {
                    shader = Shader.Find(shadername);
                    shaders[shadername] = shader;

                }
                else
                    shader = shaders[shadername];
                if (shader != null)
                    renders[i].material.shader = shader;
            }
           // UnityEngine.Debug.Log("replace shader time:" + sw.ElapsedTicks);
           // UnityEngine.Debug.Log("replace shader time2:" + tick1 + ",Frequency :" + Stopwatch.Frequency);
        }






        public void LoadScene(string assetBundleName, string levelName, bool isAdditive, LoadSceneCallback callback, params object[] param)
        {
            LoggerHelper.Debug("begin to load scene assetBundleName:" + assetBundleName + ",level:" + levelName);
            resLoader.LoadScene(assetBundleName, levelName, isAdditive, callback, param);
        }

 

        static AssetLoader2 _instance;
        public static AssetLoader2 Instance
        {
            get
            {
                return _instance;
            }

        }
        void Awake()
        {
            _instance = this;
            Initialize();
        }


        
        void Update()
        {
            if (uiLoader != null)
                uiLoader.Update();
            if (resLoader != null)
                resLoader.Update();
        }

    }
    public class LoadedAssetBundle
    {
        public AssetBundle m_AssetBundle;
        public int m_ReferencedCount;

        public LoadedAssetBundle(AssetBundle assetBundle)
        {
            m_AssetBundle = assetBundle;
            m_ReferencedCount = 1;
        }
    }
}