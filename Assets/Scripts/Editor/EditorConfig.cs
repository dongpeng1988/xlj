 

 
    using System.IO;
using UnityEngine;
public class EditorConfig
    {
        static bool loaded = false;
        static void LoadConfig()
        {
            string fn = Application.dataPath+"/../config.ini";
            if(!File.Exists(fn))
            {
                Debug.LogError("config file not exists:"+fn);
            loaded = true;
            return;
            }
            using(StreamReader reader = new StreamReader(fn))
            {
                while(!reader.EndOfStream)
                {
                    string line =   reader.ReadLine();
                    string[] lines = line.Trim().Split('=');
                    if (lines.Length != 2)
                        continue;
                    string k = lines[0].Trim();
                    string val = lines[1].Trim();

                    if (k == "docbase")
                    {
                        _excelDataDir = lines[1];
                        if (!_excelDataDir.EndsWith("\\"))
                            _excelDataDir += "\\";
                    }
                     
                }
                  loaded = true;
            }
        }
        static string _excelDataDir;
        public static string ExcelDataDir{
            get{
                if (!loaded)
                    LoadConfig();
                Debug.Log("return path:" + _excelDataDir);
                return _excelDataDir;
            }
 
        }
    }
 
