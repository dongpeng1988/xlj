using UnityEngine;
using UnityEditor;
using System.IO;
using System.Collections.Generic;

public class InputAnim : EditorWindow {

    public GameObject camera;
    public bool _isHaveData = false;
    public List<string> datas = new List<string>();
    public string alldatas = "";
    static void Init()
    {
        InputAnim window = (InputAnim)EditorWindow.GetWindow(typeof(InputAnim));
       

    }

    void OnEnable()
    {
        camera = Camera.main.gameObject;
        alldatas = File.OpenText(Application.dataPath + "/ShakeData.txt").ReadToEnd();
        alldatas.Trim();
        string[] temps = alldatas.Split('\n');
        for (int i = 1; i < temps.Length; i++)
        {
            datas.Add(temps[i]);     
        }
        

        if(datas.Count!=0)
        {
            _isHaveData = true;
        }
    }
    void OnGUI()
    {

       
        if (_isHaveData)
        {
            camera = EditorGUILayout.ObjectField(camera, typeof(GameObject)) as GameObject;

            if (camera == null)
            {
                GUILayout.Label("把相机拖进去~");
            }
            else
            {
                foreach (string item in datas)
                {
                    if(GUILayout.Button(item.Split(',')[0]))
                    {
                        string[] strs = item.Split('@');
                        List<Keyframe> kfs = new List<Keyframe>();
                        string[] tem = strs[0].Split(',');
                        if (!string.IsNullOrEmpty(tem[2]))
                        {
                            Keyframe kf = new Keyframe(float.Parse(tem[2]), float.Parse(tem[3]), float.Parse(tem[4]), float.Parse(tem[5]));
                            kfs.Add(kf);
                        }
                        int i = 1;
                        while(true)
                        {
                            if(string.IsNullOrEmpty(strs[i]))
                            {
                                break;
                            }
                            tem = strs[i].Split(',');
                            if (!string.IsNullOrEmpty(tem[1]))
                            {
                                Keyframe kf = new Keyframe(float.Parse(tem[1]), float.Parse(tem[2]), float.Parse(tem[3]), float.Parse(tem[4]));
                                kfs.Add(kf);
                            }
                            i++;
                        }
                        Keyframe[] kfarr = kfs.ToArray();

                        AnimationCurve ac = new AnimationCurve(kfarr);
                        camera.GetComponent<CameraShake>().anim = ac;
                    }
                }

            }
        }
        else
        {
            GUILayout.Label("还没有数据~");
        }
    }
}
