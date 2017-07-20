using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Xml;
public class NpcInfo
{
	public string strName;
	public string strCaption;
	public int mID;
	public int mLevel;
	public string mType;
	public string _filename;
	public string strFileName
	{
		get 
		{
			if(Application.isEditor)
			{
				return "Assets/"  + _filename + ".prefab";
			}
			else{
				return "../data/" + _filename ;
			}
		}
		set 
		{
			_filename = value;
		}
	}
}

public class NpcManager : MonoBehaviour {
	
	public List<NpcInfo> npclist= new List<NpcInfo>();
	public string npclistname
    {
        get
        {
            if (Application.platform == RuntimePlatform.WindowsWebPlayer || Application.platform == RuntimePlatform.OSXWebPlayer)
                return Application.dataPath+"/data/xml/npclist.xml";
            else
                return "file://" + Application.dataPath + "/../data/xml/npclist.xml";
        }
    }
	static private NpcManager g_npcmgr;
	static public NpcManager GetInstance()
	{
		if(g_npcmgr==null)
		{
			g_npcmgr = GameObject.Find("Logic").GetComponent<NpcManager>();
		}
		return g_npcmgr;
	}
	public NpcInfo GetNpcInfo(int id)
	{
		for(int i = 0;i<npclist.Count;i++)
		{
			if(npclist[i].mID==id)
			{
				return npclist[i];
			}
		}
		return null;
	}
	
 
	public IEnumerator loaddata() 
	{ 
		string url = npclistname; 
		WWW www = new WWW(url); 
		yield return www; 
		if (www.error == null) 
		{ 
			//Debug.LogError("loading npclist");
			//no error occured 
			string xml = www.data; 
			//	Debug.Log(xml);
			XmlDocument xmlDoc = new XmlDocument(); 
			
			xmlDoc.LoadXml(xml); 
			
			System.Xml.XmlNodeList NpcListNodes = xmlDoc.GetElementsByTagName("Npcs");
			if(NpcListNodes.Count>0)
			{
				XmlElement coun =  (XmlElement)NpcListNodes.Item(0);
				ReadNpcList(coun);
			}
		}
		www.Dispose(); 
		www = null;
	}
	
	void ReadNpcList(XmlElement npclistkele)
	{
		npclist.Clear();
		XmlNode infonode = npclistkele.FirstChild;
		while(infonode!=null)
		{
			XmlElement pinfoele =(XmlElement)infonode;
			NpcInfo pinfo = new NpcInfo();
			pinfo.mID = int.Parse(pinfoele.GetAttribute("id"));
			pinfo.strName = pinfoele.GetAttribute("name");
			pinfo.mType = pinfoele.GetAttribute("type");
			pinfo.strCaption = pinfoele.GetAttribute("caption");
			string levle =pinfoele.GetAttribute("level");
			if(levle.Length>0)
			{
				pinfo.mLevel = int.Parse(levle);
			}
			pinfo._filename = pinfoele.GetAttribute("file");
			npclist.Add(pinfo);
			infonode = infonode.NextSibling;
		}
	}
	// Use this for initialization
	bool bLoaded = false;
	
	void Start () {

	}
	void Awake()
	{
		if(bLoaded==false)
		{
			StartCoroutine(loaddata());
		}
	}

	// Update is called once per frame
	void Update () {
	
	}
}
