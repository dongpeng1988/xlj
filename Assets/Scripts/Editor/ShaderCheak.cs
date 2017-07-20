using UnityEngine;
using System.Collections.Generic;
using UnityEditor;
using System.IO;

public class ShaderCheak : MonoBehaviour
{

    [MenuItem("LZTools/CheakShader(不要点)")]
    public static void CheakShader()
    {
        CheakAllShader();
    }

    private static List<Shader> AllShader = new List<Shader>();
    private static List<string> Allassetpath = new List<string>();
    private static void CheakAllShader()
    {
        string dirpath = Application.dataPath;
        int prefixlen = Application.dataPath.Length - "Assets".Length;
        StreamWriter sw = File.CreateText(Application.dataPath + @"\" + System.DateTime.Now.Ticks + ".txt");
        foreach (string fn in Directory.GetFiles(dirpath, "*.shader", SearchOption.AllDirectories))
        {
            string assetpath = fn.Substring(prefixlen);
            Shader shader = AssetDatabase.LoadAssetAtPath(assetpath, typeof(Shader)) as Shader;
            AllShader.Add(shader);
            Allassetpath.Add(assetpath);
        }
        FindScriptReference(sw);
    }
    static int si = 0;
    static int pi = 0;
    static public void FindScriptReference(StreamWriter sw)
    {
        string curPathName = AssetDatabase.GetAssetPath(AllShader[si].GetInstanceID());
        sw.WriteLine("ShaderName:" + AllShader[si].name);
        string[] allGuids = AssetDatabase.FindAssets("t:Prefab t:Scene", new string[] { "Assets/CheakF" });
        int num = 0;
        foreach (string guid in allGuids)
        {
            string assetPath = AssetDatabase.GUIDToAssetPath(guid);
            string[] names = AssetDatabase.GetDependencies(new string[] { assetPath });  //依赖的东东
            foreach (string name in names)
            {
                if (name.Equals(curPathName))
                {
                    num++;
                    sw.WriteLine("引用" + num + assetPath);
                }
            }
          
            ShowProgress((float)pi /((float)allGuids.Length * (float)AllShader.Count), allGuids.Length * AllShader.Count, pi, AllShader[si].name);
            pi++;
        }
            sw.WriteLine("共" + num + "个");
           if(num ==0)
           {
               FileUtil.DeleteFileOrDirectory(Allassetpath[si]);
           }

        si++;
        if (si == AllShader.Count)
        {
            EditorUtility.ClearProgressBar();
            pi = 0;
            si = 0;
            sw.Close();
            return;
        }
        else
        {
            FindScriptReference(sw);
        }

    }

    public static void ShowProgress(float val, int total, int cur, string ShaderName)
    {
        EditorUtility.DisplayProgressBar("我还在等待……", string.Format(ShaderName + "is Finding ({0}/{1}), please 等一下...", cur, total), val);
    }
}
