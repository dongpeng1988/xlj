using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using UnityEngine;
using sw.ui.model;
using System.IO;
using sw.game.model;
using sw.manager;
using sw.scene.model;
using sw.util;
using Config;
using sw.ctrl;
 public class EditMapManager
{
    public ITerrainManager terrainMan;

    public Dictionary<int, MapZone> zoneCollection = new Dictionary<int,MapZone>();
    public Dictionary<string, MapNpc> npcCollection = new Dictionary<string, MapNpc>();
    public Dictionary<int, MapWarp> warpCollection = new Dictionary<int, MapWarp>();

    public IjueseManager jueseMan;
    public const int OPERATE_ADD = 1;//add node to zone
    public const int OPERATE_DELETE = -1;//delete node from zone
    public bool EDIT_ZONE = false;
    public MapZone editing_zone_param;

    public const int ZONE_SAFE = 1 << 0;
    public const int ZONE_RELIVE = 1 << 2;
    public const int ZONE_NEWBIE = 1 << 3;
    public const int ZONE_SIT = 1 << 4;
    public const int ZONE_FIGHT_BOSS = 1 << 5;
    public const int ZONE_TOGGLE = 1 << 7;

    public IMapNpcManager mapNpcMgr = new MapNpcManager();
    public IMapWarpManager mapWarpMgr = new MapWarpManager();

    public Camera editMapCamera;
    private  string mapResId;
    private string mapTileId;
    private int mapXmlId;


        
        
    public void createBossLayer()
    {
        GameObject bossLayer = new GameObject("bossLayer");
        GameObject.DontDestroyOnLoad(bossLayer);
    }
    public void editZoneNode(MapNode node, int addOrDelete)
    {
        if (zoneCollection.ContainsKey(node.zoneId) == false && addOrDelete == OPERATE_DELETE)
        {
            return;
        }
        //Dictionary<MapNode, int> zoneDict;
        MapZone mapZone;
        if ((zoneCollection.ContainsKey(node.zoneId)) == false && addOrDelete == OPERATE_ADD)
        {
            mapZone = new MapZone();
            //zoneDict = new Dictionary<MapNode, int>();
            mapZone.id = node.zoneId;
            zoneCollection[node.zoneId] = mapZone;
            //zoneCollection[node.zoneId] = zoneDict;
        }
        else
        {
            //zoneDict = zoneCollection[node.zoneId];
            mapZone = zoneCollection[node.zoneId];
        }

        if (addOrDelete == OPERATE_ADD)
        {
            if (mapZone.nodeDict.ContainsKey(node) == true)
                return;
            else
                mapZone.nodeDict[node] = 1;

        }
        else if (addOrDelete == OPERATE_DELETE)
        {
            if (mapZone.nodeDict.ContainsKey(node))
            {
                mapZone.nodeDict.Remove(node);
            }
            else
                return;
        }
    }

    public void editMapNpc(MapNpc node,int addOrDelete)
    {
        if (npcCollection.ContainsValue(node) && addOrDelete == OPERATE_ADD)
        {
            Debug.Log("这个npc（boss）已经被添加过了");
        }
        else if(npcCollection.ContainsValue(node) && addOrDelete ==  OPERATE_DELETE)
        {
            npcCollection.Remove(node.uniqueId);
        }
        else if (!npcCollection.ContainsValue(node) && addOrDelete == OPERATE_ADD)
        {
            npcCollection[node.uniqueId] = node;
        }
    }

    public void addMapWarp(MapWarp warp,int addOrDelete = OPERATE_ADD)
    {
        if (warpCollection.ContainsValue(warp) && addOrDelete == OPERATE_ADD)
        {
            Debug.Log("这个npc（boss）已经被添加过了");
        }
        else if (warpCollection.ContainsValue(warp) && addOrDelete == OPERATE_DELETE)
        {
            warpCollection.Remove(warp.id);
        }
        else if (!warpCollection.ContainsValue(warp) && addOrDelete == OPERATE_ADD)
        {
            warpCollection[warp.id] = warp;
        }

        float h1 = terrainMan.GetHeight(warp.warpX, warp.warpY);
        Vector3 npcPos = new Vector3(warp.warpX, h1, warp.warpY);
        mapWarpMgr.Preload("scene_portal_e", npcPos, warp.id.ToString());
        // mapNpcMgr.ShowSkillFx((GameObject.Find(RoleCtrl) as RoleCtrl), "n_fujiaertongnv");
        mapWarpMgr.ShowSkillFx(null, "scene_portal_e", npcPos);
    }


    public void editWholeZone(MapZone node, int addOrDelete)
    {
        if (zoneCollection.ContainsKey(node.id) && addOrDelete == OPERATE_ADD)
        {
            Debug.Log("这个区域（"+node.id+"）已经被添加过了");
        }
        else if (zoneCollection.ContainsKey(node.id) && addOrDelete == OPERATE_DELETE)
        {
            zoneCollection.Remove(node.id);
        }
        else if (!zoneCollection.ContainsKey(node.id) && addOrDelete == OPERATE_ADD)
        {
            zoneCollection[node.id] = node;
        }
    }



    public string ZoneName(int zoneType)
    {
        string s = "";
        if ((zoneType & ZONE_SAFE) > 0)
            s += "（安全区）";
        if ((zoneType & ZONE_RELIVE) > 0)
            s += "（死亡重生区）";
        if ((zoneType & ZONE_NEWBIE) > 0)
            s += "（新手出生区）";
        if ((zoneType & ZONE_SIT) > 0)
            s += "（打坐区）";
        if ((zoneType & ZONE_FIGHT_BOSS) > 0)
            s += "（刷怪区）";
        if ((zoneType & ZONE_TOGGLE) > 0)
            s += "（触发区）";

        return s;
    }

    public void readMapXML(int param_mapXmlId)
    {
        mapXmlId = param_mapXmlId;
        XmlDocument xmlDocs = new XmlDocument();
        string xmlPath = Application.streamingAssetsPath.Substring(0, Application.streamingAssetsPath.Length - 15) + "map/" + param_mapXmlId + ".xml";
        if (File.Exists(xmlPath))
        {
            XmlReaderSettings set = new XmlReaderSettings();
            set.IgnoreComments = true;
            xmlDocs.Load(XmlReader.Create(xmlPath, set));
            XmlElement root = (XmlElement)xmlDocs.GetElementsByTagName("HLMapConfig")[0];

            XmlNodeList npcXmlNodes = xmlDocs.GetElementsByTagName("npc");
            for(int i = 0 ;i < npcXmlNodes.Count ;i ++)
            {
                XmlElement npcXml = (XmlElement)npcXmlNodes[i];
                MapNpc npc_node = new MapNpc(int.Parse(npcXml.GetAttribute("id")));
                npc_node.ai = int.Parse(npcXml.GetAttribute("ai"));
                try 
                {
                    npc_node.chase = int.Parse(npcXml.GetAttribute("chase"));
                }
                catch { 
                    npc_node.chase = 0;
                }
                npc_node.direction = int.Parse(npcXml.GetAttribute("direction"));
                npc_node.enemyType = int.Parse(npcXml.GetAttribute("enemyType"));
                try { npc_node.height = int.Parse(npcXml.GetAttribute("height")); }
                catch { npc_node.height = 0; }
                try { npc_node.interval = int.Parse(npcXml.GetAttribute("interval")); }
                catch { npc_node.interval = 0; }
                npc_node.level = int.Parse(npcXml.GetAttribute("level"));
                npc_node.modelId = npcXml.GetAttribute("modelId");
                try { npc_node.nkind = int.Parse(npcXml.GetAttribute("nkind")); }
                catch { npc_node.nkind = 0; }
                try { npc_node.ntype = int.Parse(npcXml.GetAttribute("ntype")); }
                catch { npc_node.ntype = 0; }
                try { npc_node.num = int.Parse(npcXml.GetAttribute("num")); }
                catch { npc_node.num = 0; }
                npc_node.scope = int.Parse(npcXml.GetAttribute("scope"));
                try { npc_node.speed = int.Parse(npcXml.GetAttribute("speed")); }
                catch { npc_node.speed = 0; }
                npc_node.type = int.Parse(npcXml.GetAttribute("type"));
                 npc_node.uniqueId = npcXml.GetAttribute("uniqueId") ;  
         
                try { npc_node.walklen = int.Parse(npcXml.GetAttribute("walklen")); }
                catch { npc_node.walklen = 0; }
                try { npc_node.width = int.Parse(npcXml.GetAttribute("width")); }
                catch { npc_node.width = 0; }
                npc_node.x = int.Parse(npcXml.GetAttribute("x"));
                npc_node.y = int.Parse(npcXml.GetAttribute("y"));

                editMapNpc(npc_node,OPERATE_ADD);
            }

            XmlNodeList zoneXmlNodes = xmlDocs.GetElementsByTagName("zonedef");
            for (int i = 0; i < zoneXmlNodes.Count; i++)
            {
                XmlElement zoneXml = (XmlElement)zoneXmlNodes[i];
                MapZone zone_node = new MapZone();
                zone_node.id = int.Parse(zoneXml.GetAttribute("id"));
                try { zone_node.regiontype = int.Parse(zoneXml.GetAttribute("regiontype")); }
                catch { zone_node.type = 0; }
                zone_node.height = int.Parse(zoneXml.GetAttribute("height"));
                zone_node.type = int.Parse(zoneXml.GetAttribute("type"));
                zone_node.width = int.Parse(zoneXml.GetAttribute("width"));
                zone_node.x = int.Parse(zoneXml.GetAttribute("x"));
                zone_node.y = int.Parse(zoneXml.GetAttribute("y"));

                foreach(XmlElement region_item in zoneXml.ChildNodes)
                {
                    string[] col_list = region_item.GetAttribute("points").Split(',');
                    for(int j = 0;j< col_list.Length ;j++)
                    {
                        //id ,x ,y ,add
                        MapNode region_node = new MapNode(zone_node.id, int.Parse(col_list[j]), int.Parse(region_item.GetAttribute("row")), OPERATE_ADD);
                        zone_node.nodeDict[region_node] = 1;
                    }
                }
                editWholeZone(zone_node, OPERATE_ADD);
            }

            XmlNodeList warpXmlNodes = xmlDocs.GetElementsByTagName("waypoint");
            for (int i = 0; i < warpXmlNodes.Count; i++)
            {
                XmlElement warpXml = (XmlElement)warpXmlNodes[i];
                MapWarp warp_node = new MapWarp();
                warp_node.warpX = int.Parse(warpXml.GetAttribute("x"));
                warp_node.warpY = int.Parse(warpXml.GetAttribute("y"));
                //try { warp_node.regiontype = int.Parse(warpXml.GetAttribute("regiontype")); }
                //catch { warp_node.type = 0; }
                warp_node.warpName = warpXml.GetAttribute("name");
                warp_node.type = int.Parse(warpXml.GetAttribute("type"));
                warp_node.state = int.Parse(warpXml.GetAttribute("state"));
                warp_node.destMapId = int.Parse(warpXml.GetAttribute("destMapId1"));
                warp_node.destMapX = int.Parse(warpXml.GetAttribute("destPosX1"));
                warp_node.destMapY = int.Parse(warpXml.GetAttribute("destPosY1"));


                addMapWarp(warp_node, OPERATE_ADD);
            }

        }
        else
        {
            //XmlDeclaration dec = xmlDocs.CreateXmlDeclaration("1.0", "UTF-8", null);
            //xmlDocs.AppendChild(dec);
            //XmlElement root = xmlDocs.CreateElement("Hoolai");
            //xmlDocs.AppendChild(root);
            //xmlDocs.Save(xmlPath);
        }

        initMapNpc();
        initMapWarp();
    }

    public void saveMapXML()
    {
        XmlDocument xmlDocs = new XmlDocument();
        string xmlPath = Application.streamingAssetsPath.Substring(0, Application.streamingAssetsPath.Length - 15) + "map/" + mapXmlId + ".xml";
        XmlDeclaration dec = xmlDocs.CreateXmlDeclaration("1.0", "UTF-8", null);
        XmlElement root = xmlDocs.CreateElement("HLMapConfig");
        xmlDocs.AppendChild(root);
        Dictionary<int, string> row_region = new Dictionary<int,string>();

        foreach (KeyValuePair<string, MapNpc> kp_npc in npcCollection)
        {
            MapNpc npcNode = kp_npc.Value;
            XmlElement ele_npc = xmlDocs.CreateElement("npc");
            ele_npc.SetAttribute("id", npcNode.id.ToString());
            ele_npc.SetAttribute("type", npcNode.ntype.ToString());
            ele_npc.SetAttribute("x", npcNode.x.ToString());
            ele_npc.SetAttribute("y", npcNode.y.ToString());
            ele_npc.SetAttribute("direction", npcNode.direction.ToString());
            ele_npc.SetAttribute("level", npcNode.level.ToString());
            ele_npc.SetAttribute("scope", npcNode.scope.ToString());
            ele_npc.SetAttribute("ai", npcNode.ai.ToString());
            ele_npc.SetAttribute("modelId", npcNode.modelId);
            //ele_npc.SetAttribute("name", npcNode.name.ToString());
            ele_npc.SetAttribute("enemyType", npcNode.enemyType.ToString());
            ele_npc.SetAttribute("num", npcNode.num.ToString());
            ele_npc.SetAttribute("interval", npcNode.interval.ToString());
            ele_npc.SetAttribute("height", npcNode.height.ToString());
            ele_npc.SetAttribute("width", npcNode.width.ToString());
            ele_npc.SetAttribute("chase", npcNode.chase.ToString());
            ele_npc.SetAttribute("uniqueId", npcNode.uniqueId.ToString());
            root.AppendChild(ele_npc);
        }

        foreach(KeyValuePair<int,MapZone> kp_zone in zoneCollection)
        {
            MapZone zoneNode = kp_zone.Value;
            XmlElement ele_zone = xmlDocs.CreateElement("zonedef");
            ele_zone.SetAttribute("id", zoneNode.id.ToString());
            ele_zone.SetAttribute("type", zoneNode.type.ToString());
            ele_zone.SetAttribute("regintype", zoneNode.regiontype.ToString());
            ele_zone.SetAttribute("countryflag", zoneNode.countryflag.ToString());
            ele_zone.SetAttribute("x", zoneNode.x.ToString());
            ele_zone.SetAttribute("y", zoneNode.y.ToString());
            ele_zone.SetAttribute("width", zoneNode.width.ToString());
            ele_zone.SetAttribute("height", zoneNode.height.ToString());

            root.AppendChild(ele_zone);

            row_region.Clear();
            //fill nodes to dict by row num
            foreach(KeyValuePair<MapNode,int> kp_node in kp_zone.Value.nodeDict)
            {
                if(row_region.ContainsKey(kp_node.Key.y))
                    row_region[kp_node.Key.y] += kp_node.Key.x + ",";
                else
                    row_region[kp_node.Key.y] = kp_node.Key.x + ",";
            }
            //append each row
            foreach(KeyValuePair<int,string> kp_region in row_region)
            {
                XmlElement ele_region = xmlDocs.CreateElement("region");
                ele_region.SetAttribute("row",kp_region.Key.ToString());
                ele_region.SetAttribute("points", kp_region.Value.Substring(0, kp_region.Value.Length - 1));
                ele_zone.AppendChild(ele_region);
            }
        }

        foreach (KeyValuePair<int, MapWarp> kp_warp in warpCollection)
        {
            MapWarp warpNode = kp_warp.Value;
            XmlElement ele_warp = xmlDocs.CreateElement("waypoint");
            ele_warp.SetAttribute("id", warpNode.id.ToString());
            ele_warp.SetAttribute("type", warpNode.type.ToString());
            ele_warp.SetAttribute("x", warpNode.warpX.ToString());
            ele_warp.SetAttribute("y", warpNode.warpY.ToString());
            ele_warp.SetAttribute("state", warpNode.state.ToString());
            ele_warp.SetAttribute("name", warpNode.warpName);

            ele_warp.SetAttribute("destMapId1", warpNode.destMapId.ToString());
            ele_warp.SetAttribute("destPosX1", warpNode.destMapX.ToString());
            ele_warp.SetAttribute("destPosY1", warpNode.destMapY.ToString());
            ele_warp.SetAttribute("destMapId2", warpNode.destMapId.ToString());
            ele_warp.SetAttribute("destPosX2", warpNode.destMapX.ToString());
            ele_warp.SetAttribute("destPosY2", warpNode.destMapY.ToString());
            ele_warp.SetAttribute("destMapId3", warpNode.destMapId.ToString());
            ele_warp.SetAttribute("destPosX3", warpNode.destMapX.ToString());
            ele_warp.SetAttribute("destPosY3", warpNode.destMapY.ToString());
            root.AppendChild(ele_warp);
        }

        xmlDocs.Save(xmlPath);
    }
    Transform temp_boss_trans;
    public void addBoss()
    {
        if (jueseMan != null)
        {
            jueseMan.Preload("n_shenmishaonv");
        }
        GameObject.Destroy(temp_boss_trans);
        //jueseMan.ShowSkillFx(this, "n_shenmishaonv");
        //renwuTrans = base.transform.FindChild(curRole);
        //anim = renwuTrans.gameObject.GetComponent<Animator>();
        //roleData = renwuTrans.gameObject.GetComponent<RoleData>();
        //zuoqi(onZuoqi);
    }

    private void initMapNpc()
    {
        foreach (KeyValuePair<string, MapNpc> kp in npcCollection)
        {
            MapNpc npc = kp.Value;
            NpcConfig npcCfg = ConfigAsset.Instance.getNpcConfigs(npc.id);
            try
            {
                kp.Value.modelId = int.Parse(npcCfg.modelId).ToString();
                kp.Value.modelId = "n_fujiaertongnv";
            }
            catch
            {
                kp.Value.modelId = npcCfg.modelId;
            }
            int x = (int)sw.util.PathUtil.Logic2RealX(npc.x);
            int y = (int)sw.util.PathUtil.Logic2RealZ(npc.y);
            float h1 = terrainMan.GetHeight(x, y);
            Vector3 npcPos = new Vector3(x, h1,y);
            mapNpcMgr.Preload(kp.Value.modelId, npcPos,kp.Value.uniqueId.ToString());
            // mapNpcMgr.ShowSkillFx((GameObject.Find(RoleCtrl) as RoleCtrl), "n_fujiaertongnv");
            mapNpcMgr.ShowSkillFx(null, kp.Value.modelId, npcPos);
        }
            
    }

    private void initMapWarp()
    {
        foreach (KeyValuePair<int, MapWarp> kp in warpCollection)
        {
            MapWarp warp = kp.Value;
            int x = (int)sw.util.PathUtil.Logic2RealX(warp.warpX);
            int y = (int)sw.util.PathUtil.Logic2RealZ(warp.warpY);
            float h1 = terrainMan.GetHeight(x, y);
            Vector3 npcPos = new Vector3(x, h1, y);
            mapWarpMgr.Preload("scene_portal_e", npcPos, warp.id.ToString());
            // mapNpcMgr.ShowSkillFx((GameObject.Find(RoleCtrl) as RoleCtrl), "n_fujiaertongnv");
            mapWarpMgr.ShowSkillFx(null, "scene_portal_e", npcPos);
        }
    }

       

    private static EditMapManager _instance;
    public static EditMapManager Instance
    {
        get
        {
            if (_instance == null)
            {
                _instance = new EditMapManager();
            }
            return _instance;
        }

    }
}


    

