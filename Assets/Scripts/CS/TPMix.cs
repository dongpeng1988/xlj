using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using TextAndPic;

/**
 * 关键字说明
 * /P 图片文件 <0> 尖括号内代表图片编号。
 * /L 超链接   <title,linkinfo> 尖括号内代表文本和超链接内容
 * /I 物品栏   <0> 尖括号内代表物品编号。
 */
namespace TextAndPic
{
    public class BaseObj
    {
        BaseGroup pfather;
        public Rect pr = new Rect();
    }

    public class BaseChar : BaseObj
    {
        public string txt;
    }

    public class BasePicture : BaseObj
    {
        public Texture2D ico;
    }

    public enum ENUM_TPMIX_GROUPTYPE
    {
        GROUP_TEXT = 0,
        GROUP_PIC = 1,
        GROUP_LINK = 2,
        GROUP_ITEM = 3,
    }
    public class BaseGroup
    {
        public List<BaseObj> objlist = new List<BaseObj>();
        public int type;
        public string txt_info;
        public virtual void Split()
        {
            objlist.Clear();
        }
    }

    public class GroupStr : BaseGroup
    {
        public GroupStr()
        {
            type = (int)ENUM_TPMIX_GROUPTYPE.GROUP_TEXT;
        }
        public override void Split()
        {
            base.Split();
        }
    }
    public class GroupIco : BaseGroup
    {
        public GroupIco()
        {
            type = (int)ENUM_TPMIX_GROUPTYPE.GROUP_PIC;
        }
    }

    public class GroupLink : BaseGroup
    {
        public string link;
        public GroupLink()
        {
            type = (int)ENUM_TPMIX_GROUPTYPE.GROUP_LINK;
        }
    }
}


public class TPMix : MonoBehaviour
{

    public Texture2D[] image;
    public string txt;
    public List<BaseGroup> grplist = new List<BaseGroup>();// = new List<TextAndPic.BaseGroup>();
    public string keyword = "/";
    public int row = 1;
    public int col = 0;
    public int linehei = 16;
    public Rect winrect = new Rect(0, 0, 300, 300);
    public GUIText guitxt;
    // Use this for initialization
    void Start()
    {
        txt = "天神互动，你好/P<0>/，欢迎访问欢迎访问欢迎访问欢迎访问欢迎访问欢迎访问欢迎访问欢迎访问欢迎访问欢迎访问欢迎访问欢迎访问欢迎访问/L<傲剑,www.aojian.net>/。谢谢！";
        SplitGroup();
        SplitSingle();
    }

    void SplitGroup()
    {
        grplist.Clear();
        bool oneshoot = false;
        string strleft = txt;
        string savedstring = "";
        string wtype = "";
        for (int i = 0; i < strleft.Length; i++)
        {
            if (oneshoot == false)
            {
                if (strleft.Substring(i, 1) == keyword)
                {
                    //
                    GroupStr grp_str = new GroupStr();
                    grp_str.txt_info = savedstring;
                    grplist.Add(grp_str);
                    savedstring = "";
                    oneshoot = true;

                    //检查下一个字符，判断下一组是啥类型
                    i++;
                    wtype = strleft.Substring(i, 1);
                }
                else
                {
                    savedstring += strleft.Substring(i, 1);
                }
            }
            else
            {
                //等待结束符
                if (strleft.Substring(i, 1) == keyword)
                {
                    //
                    if (wtype == "P")
                    {
                        GroupIco grp_ico = new GroupIco();
                        grp_ico.txt_info = savedstring;
                        grplist.Add(grp_ico);
                    }
                    else if (wtype == "L")
                    {
                        //wtype = (int)ENUM_TPMIX_GROUPTYPE.GROUP_LINK;
                        GroupLink grp_ico = new GroupLink();
                        grplist.Add(grp_ico);
                    }
                    savedstring = "";
                    oneshoot = false;
                }
                else
                {
                    savedstring += strleft.Substring(i, 1);
                }
            }
        }
    }

    void SplitSingle()
    {
        int refx = 0;// (int) winrect.x;
        int refz = 30;
        foreach (BaseGroup gb in grplist)
        {
            gb.Split();
            if (gb.type == (int)ENUM_TPMIX_GROUPTYPE.GROUP_TEXT)
            {
                GroupStr gptxt = (GroupStr)gb;
                for (int i = 0; i < gptxt.txt_info.Length; i++)
                {
                    BaseChar p = new BaseChar();
                    p.txt = gptxt.txt_info.Substring(i, 1);
                    guitxt.text = p.txt;
                    int fw = (int)guitxt.GetScreenRect().width;
                    int fz = (int)guitxt.GetScreenRect().height + row * 2;
                    //refz += fz;
                    p.pr = new Rect(refx, refz, fw, fz);
                    gptxt.objlist.Add(p);

                    if (refx + fw >= winrect.x + winrect.width - 5)
                    {
                        refx = 0;
                        refz += Mathf.Max(fz, linehei);
                    }
                    else
                    {
                        refx += fw;
                    }
                }
            }
            else if (gb.type == (int)ENUM_TPMIX_GROUPTYPE.GROUP_PIC)
            {
                GroupIco gico = (GroupIco)gb;
                BasePicture p = new BasePicture();
                gb.objlist.Add(p);
                string imgidx = gico.txt_info.Substring(1, gico.txt_info.Length - 2);
                p.ico = image[int.Parse(imgidx) % image.Length];
                int fw = p.ico.width;
                int fz = p.ico.height;
                p.pr = new Rect(refx, refz, fw, fz);
                if (refx + fw >= winrect.x + winrect.width - 5)
                {
                    refx = 0;
                    refz += Mathf.Max(fz, linehei);
                }
                else
                {
                    refx += fw;
                }
            }
        }
    }
    // Update is called once per frame
    void Update()
    {

    }

    void OnGUI()
    {
        winrect = GUI.Window(0, winrect, DoMyWindow, "My Window");
        // Make the contents of the window
    }

    void DoMyWindow(int wid)
    {
        foreach (BaseGroup gb in grplist)
        {
            if (gb.type == (int)ENUM_TPMIX_GROUPTYPE.GROUP_TEXT)
            {
                GroupStr gptxt = (GroupStr)gb;
                for (int i = 0; i < gptxt.objlist.Count; i++)
                {
                    PrintChar((BaseChar)gptxt.objlist[i]);
                }
            }
            if (gb.type == (int)ENUM_TPMIX_GROUPTYPE.GROUP_PIC)
            {
                GroupIco gpico = (GroupIco)gb;
                for (int i = 0; i < gpico.objlist.Count; i++)
                {
                    PrintPicture((BasePicture)gpico.objlist[i]);
                }
            }
        }
    }

    void PrintChar(BaseChar bc)
    {
        GUI.Label(bc.pr, bc.txt);
    }
    void PrintPicture(BasePicture pic)
    {
        GUI.DrawTexture(pic.pr, pic.ico);
    }
}