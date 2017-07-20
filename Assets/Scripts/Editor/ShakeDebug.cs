using UnityEngine;
using System.Collections;
using System.IO;

public class ShakeDebug : MonoBehaviour
{
    public CameraShake cs;
    public UIButton m_Btn_Test;
    public UIButton m_Btn_Save;
    public UIButton m_Btn_Clear;
    public UIInput m_Input_Name;
    public GameObject role;
    private  Animator animator;
    private  BindBody bb;


    void Start()
    {
        animator = role.GetComponentInChildren<Animator>();
        bb = role.GetComponentInChildren<BindBody>();
        EventDelegate.Add(m_Btn_Test.onClick, BoomShakalaka);
        EventDelegate.Add(m_Btn_Save.onClick, SaveData);
        EventDelegate.Add(m_Btn_Clear.onClick, ClearBtn);
    }

    public void ClearBtn()
    {
        File.Delete(Application.dataPath + "/ShakeData.txt");
    }

    public void BoomShakalaka()
    {
        animator.Play(0);
        bb.Play();
       cs.Shake();
    }

    void Update()
    {
    }

    public void SaveData()
    {
        if (!string.IsNullOrEmpty(m_Input_Name.value))
        {
            string text = GetText();
            FileStream fs = File.Open(Application.dataPath + "/ShakeData.txt", FileMode.OpenOrCreate);
            fs.Seek(0, SeekOrigin.End);
            StreamWriter writer = new StreamWriter(fs);
            writer.Write(writer.NewLine + text);
            writer.Close();
            fs.Close();
            Debug.LogError("存储成功");
        }
        else
        {
            Debug.LogError("请输入震动对象名字");
        }

    }

    private string GetText()
    { 
        string text = "";
        text += m_Input_Name.value;
        text += ",";
        for (int i = 0; i < cs.anim.length; i++)
        {
            text += "key"+i.ToString()+",";
            if(cs.anim.keys.Length>i)
            {
                Keyframe key = cs.anim.keys[i];
                text += key.time+",";
                text += key.value + ",";
                text += key.inTangent + ",";
                text += key.outTangent;
                text += "@";
            }
            else
            {
                text += ",,,@";
            }
        }
        return text;
    }
}
