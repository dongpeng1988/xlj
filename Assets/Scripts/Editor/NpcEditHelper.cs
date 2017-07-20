

using NetUtilityLib;
using sw.game.model;
using sw.manager;
using sw.ui.model;
using sw.util;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Xml;
using UnityEditor;
using UnityEngine;
public class NpcEditHelper
{
     

    public Dictionary<int, MapZone> zoneCollection = new Dictionary<int, MapZone>();
    public Dictionary<string, MapNpc> npcCollection = new Dictionary<string, MapNpc>();
    public Dictionary<int, MapWarp> warpCollection = new Dictionary<int, MapWarp>();
    public Dictionary<int, MapLine> lineCollection = new Dictionary<int, MapLine>();
    public Dictionary<int, MapDoor> doorCollection = new Dictionary<int, MapDoor>();
    public Dictionary<int, MapTrigger> triggerCollection = new Dictionary<int, MapTrigger>();
    public Dictionary<int, MapEffectPoint> effectPointCollection = new Dictionary<int, MapEffectPoint>();

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

    //public IMapNpcManager mapNpcMgr = new MapNpcManager();
    public IMapWarpManager mapWarpMgr = new MapWarpManager();
    MapNpcHelper npcHelper = new MapNpcHelper();
    public Camera editMapCamera;
    private string mapResId;
    private string mapTileId;
    private string mapXmlId;




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
    public void AddNpc(DataRow data,MapNpc node)
    {
        //int id = int.Parse(data["id"].ToString());
        //MapNpc node = new MapNpc(id);
        node.type = int.Parse(data["type"].ToString()); 
        if(node.type == 1)
            node.ai = 1;
        else
            node.ai = 4;
        node.npcName = data["name"].ToString();
        node.modelId = data["modelId"].ToString();
        editMapNpc(node, OPERATE_ADD);
        Vector3 npcPos = new Vector3(0, 0, 0);
        GameObject obj = npcHelper.LoadNpc(node, npcPos);
        EditorTool.CenterObj(obj);
        if(EditorData.terrainMan != null)
        {
            Vector3 pos = obj.transform.localPosition;
            pos.y = EditorData.terrainMan.GetHeight(pos.x, pos.z);
            obj.transform.localPosition = pos;
            IntPoint pt = PathUtilEdit.Real2Logic(pos);
            node.x = pt.x;
            node.y = pt.y;
            
            //EditorTool.LookObj(obj);
        }
    }


    public void AddZone( MapZone node)
    {
        editWholeZone(node, OPERATE_ADD);
        //Vector3 posPt = new Vector3(node.x, EditorData.terrainMan.GetHeight(node.x, node.y), node.y);
        //Vector3 npcPos = posPt;
        Vector3 npcPos = new Vector3(0,0,0);

        GameObject obj = npcHelper.AddMapZone(node, npcPos);
        if (obj == null)
            return;
        EditorTool.CenterObj(obj);
        if (EditorData.terrainMan != null)
        {
            Vector3 pos = obj.transform.localPosition;
            pos.y = EditorData.terrainMan.GetHeight(pos.x, pos.z);
            obj.transform.localPosition = pos;
            IntPoint pt = PathUtilEdit.Real2Logic(pos);
            node.x = pt.x;
            node.y = pt.y;

            //EditorTool.LookObj(obj);
        }
        node.target = obj;
    }
    public void AddWarp(MapWarp node)
    {
        int id = 1;
        while (warpCollection.ContainsKey(id))
            id++;
        node.id = id;
        addMapWarp(node, OPERATE_ADD);
        Vector3 npcPos = new Vector3(0, 0, 0);

        GameObject obj = npcHelper.AddWarp(node, npcPos);
        if (obj == null)
            return;
        EditorTool.CenterObj(obj);
        if (EditorData.terrainMan != null)
        {
            Vector3 pos = obj.transform.localPosition;
            pos.y = EditorData.terrainMan.GetHeight(pos.x, pos.z);
            obj.transform.localPosition = pos;
            IntPoint pt = PathUtilEdit.Real2Logic(pos);
            node.warpX = pt.x;
            node.warpY = pt.y;
           
            //EditorTool.LookObj(obj);
        }
        node.target = obj;
    }

    public void AddDoor(MapDoor node)
    {
        int id = 1;
        while (doorCollection.ContainsKey(id))
            id++;
        node.id = id;
        addMapDoor(node, OPERATE_ADD);
        Vector3 npcPos = new Vector3(0, 0, 0);

        GameObject obj = npcHelper.AddDoor(node, npcPos);
        if (obj == null)
            return;
        EditorTool.CenterObj(obj);
        if (EditorData.terrainMan != null)
        {
            Vector3 pos = obj.transform.localPosition;
            pos.y = EditorData.terrainMan.GetHeight(pos.x, pos.z);
            obj.transform.localPosition = pos;
            IntPoint pt = PathUtilEdit.Real2Logic(pos);
            node.x = pt.x;
            node.y = pt.y;

            //EditorTool.LookObj(obj);
        }
        node.target = obj;
    }

    public void AddTrigger(MapTrigger node)
    {
        int id = 1;
        while (triggerCollection.ContainsKey(id))
            id++;
        node.id = id;
        addMapTrigger(node, OPERATE_ADD);
        Vector3 npcPos = new Vector3(0, 0, 0);

        GameObject obj = npcHelper.AddTrigger(node, npcPos);
        if (obj == null)
            return;
        EditorTool.CenterObj(obj);
        if (EditorData.terrainMan != null)
        {
            Vector3 pos = obj.transform.localPosition;
            pos.y = EditorData.terrainMan.GetHeight(pos.x, pos.z);
            obj.transform.localPosition = pos;
            IntPoint pt = PathUtilEdit.Real2Logic(pos);
            node.x = pt.x;
            node.y = pt.y;

            //EditorTool.LookObj(obj);
        }
        node.target = obj;
    }

    public void AddEffectPoint(MapEffectPoint node)
    {
        int id = 1;
        while (effectPointCollection.ContainsKey(id))
            id++;
        node.id = id;
        addMapEffectPoint(node, OPERATE_ADD);
        Vector3 npcPos = new Vector3(0, 0, 0);

        GameObject obj = npcHelper.AddEffectPoint(node, npcPos);
        if (obj == null)
            return;
        EditorTool.CenterObj(obj);
        if (EditorData.terrainMan != null)
        {
            Vector3 pos = obj.transform.localPosition;
            pos.y = EditorData.terrainMan.GetHeight(pos.x, pos.z);
            obj.transform.localPosition = pos;
            IntPoint pt = PathUtilEdit.Real2Logic(pos);
            node.x = pt.x;
            node.y = pt.y;

            //EditorTool.LookObj(obj);
        }
        node.target = obj;
    }

    public void addLine(MapLine node)
    {
        addMapLine(node, OPERATE_ADD);
        Vector3 npcPos = new Vector3(0, 0, 0);

        GameObject obj = npcHelper.AddLine(node);
        if (obj == null)
            return;
        //EditorTool.CenterObj(obj);
        for (int i = 0; i < node.linepts.Count;i ++ )
        {
            if (EditorData.terrainMan != null)
            {
                Transform trans = obj.transform.FindChild("points" + (i + 1));
                if (trans == null)
                    continue;
                EditorTool.CenterObj(trans.gameObject);
                Vector3 pos = trans.localPosition;
                pos.y = EditorData.terrainMan.GetHeight(pos.x, pos.z);
                obj.transform.localPosition = pos;
                IntPoint pt = PathUtilEdit.Real2Logic(pos);
                MapLinePoint tempPos = node.linepts[i];
                //node.linepts[i].x= pt.x;
                //node.linepts[i].y = pt.y;

                //EditorTool.LookObj(obj);
            }
        }
            
        node.target = obj;
    }
    public void editMapNpc(MapNpc node, int addOrDelete)
    {
        if (npcCollection.ContainsKey(node.uniqueId) && addOrDelete == OPERATE_ADD)
        {
            Debug.Log("这个npc（boss）已经被添加过了");
        }
        else if (npcCollection.ContainsKey(node.uniqueId) && addOrDelete == OPERATE_DELETE)
        {
            npcCollection.Remove(node.uniqueId);
        }
        else if (!npcCollection.ContainsKey(node.uniqueId) && addOrDelete == OPERATE_ADD)
        {
            npcCollection[node.uniqueId] = node;
        }
    }

    public void addMapWarp(MapWarp warp, int addOrDelete = OPERATE_ADD)
    {
     
        if (warpCollection.ContainsKey(warp.id) && addOrDelete == OPERATE_ADD)
        {
            Debug.Log("这个npc（boss）已经被添加过了");
        }
        else if (warpCollection.ContainsKey(warp.id) && addOrDelete == OPERATE_DELETE)
        {
            warpCollection.Remove(warp.id);
        }
        else if (!warpCollection.ContainsKey(warp.id) && addOrDelete == OPERATE_ADD)
        {
            warpCollection[warp.id] = warp;
        }

        //float h1 = EditorData.terrainMan.GetHeight(warp.warpX, warp.warpY);
        //Vector3 npcPos = new Vector3(warp.warpX, h1, warp.warpY);
        //mapWarpMgr.Preload("scene_portal_e", npcPos, warp.id.ToString());
        // mapNpcMgr.ShowSkillFx((GameObject.Find(RoleCtrl) as RoleCtrl), "n_fujiaertongnv");
        //mapWarpMgr.ShowSkillFx(null, "scene_portal_e", npcPos);
    }

    public void addMapDoor(MapDoor door, int addOrDelete = OPERATE_ADD)
    {

        if (doorCollection.ContainsKey(door.id) && addOrDelete == OPERATE_ADD)
        {
            Debug.Log("这个阻挡门已经被添加过了");
        }
        else if (doorCollection.ContainsKey(door.id) && addOrDelete == OPERATE_DELETE)
        {
            doorCollection.Remove(door.id);
        }
        else if (!doorCollection.ContainsKey(door.id) && addOrDelete == OPERATE_ADD)
        {
            doorCollection[door.id] = door;
        }
    }

    public void addMapTrigger(MapTrigger trigger, int addOrDelete = OPERATE_ADD)
    {

        if (triggerCollection.ContainsKey(trigger.id) && addOrDelete == OPERATE_ADD)
        {
            Debug.Log("这个npc（boss）已经被添加过了");
        }
        else if (triggerCollection.ContainsKey(trigger.id) && addOrDelete == OPERATE_DELETE)
        {
            triggerCollection.Remove(trigger.id);
        }
        else if (!triggerCollection.ContainsKey(trigger.id) && addOrDelete == OPERATE_ADD)
        {
            triggerCollection[trigger.id] = trigger;
        }
    }

    public void addMapEffectPoint(MapEffectPoint effectPoint, int addOrDelete = OPERATE_ADD)
    {

        if (effectPointCollection.ContainsKey(effectPoint.id) && addOrDelete == OPERATE_ADD)
        {
            Debug.Log("这个npc（boss）已经被添加过了");
        }
        else if (effectPointCollection.ContainsKey(effectPoint.id) && addOrDelete == OPERATE_DELETE)
        {
            effectPointCollection.Remove(effectPoint.id);
        }
        else if (!effectPointCollection.ContainsKey(effectPoint.id) && addOrDelete == OPERATE_ADD)
        {
            effectPointCollection[effectPoint.id] = effectPoint;
        }
    }
    public void editWholeZone(MapZone node, int addOrDelete)
    {
        if(zoneCollection.ContainsKey(node.id))
        {
            MapZone tempZone = zoneCollection[node.id];
            if (tempZone.target == null)
                zoneCollection.Remove(node.id);
        }
        if (zoneCollection.ContainsKey(node.id) && addOrDelete == OPERATE_ADD)
        {
            Debug.Log("这个区域（" + node.id + "）已经被添加过了");
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
    public void addMapLine(MapLine line, int addOrDelete)
    {
        if (lineCollection.ContainsKey(line.id) && addOrDelete == OPERATE_ADD)
        {
            Debug.Log("这条路线（" + line.id + "）已经被添加过了");
        }
        else if (lineCollection.ContainsKey(line.id) && addOrDelete == OPERATE_DELETE)
        {
            lineCollection.Remove(line.id);
        }
        else if (!zoneCollection.ContainsKey(line.id) && addOrDelete == OPERATE_ADD)
        {
            lineCollection[line.id] = line;
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
    int readIntAttribute(XmlElement el,string fieldname)
    {
        int ret = 0;
        if (el.HasAttribute(fieldname))
        {

            int.TryParse(el.GetAttribute(fieldname), out ret);
        }
        return ret;
    }
    public void readMapXML(string param_mapXmlId)
    {
        npcHelper.Reset();
        mapXmlId = param_mapXmlId;
        XmlDocument xmlDocs = new XmlDocument();
        string xmlPath = EditorConfig.ExcelDataDir + "../地图数据文件/xianwang/map/" + param_mapXmlId + ".xml";
        if (File.Exists(xmlPath))
        {
            XmlReaderSettings set = new XmlReaderSettings();
            set.IgnoreComments = true;
            XmlReader reader = XmlReader.Create(xmlPath, set);

            xmlDocs.Load(reader);
            reader.Close();
            XmlElement root = (XmlElement)xmlDocs.GetElementsByTagName("HLMapConfig")[0];

            XmlNodeList npcXmlNodes = xmlDocs.GetElementsByTagName("npc");
            for (int i = 0; i < npcXmlNodes.Count; i++)
            {
                XmlElement npcXml = (XmlElement)npcXmlNodes[i];
                MapNpc npc_node = new MapNpc(int.Parse(npcXml.GetAttribute("id")));
                npc_node.ai = int.Parse(npcXml.GetAttribute("ai"));
                if(npcXml.HasAttribute("chase"))
                {
                    int.TryParse(npcXml.GetAttribute("chase"), out npc_node.chase);
                }
              
                npc_node.direction = int.Parse(npcXml.GetAttribute("direction"));
                npc_node.enemyType = int.Parse(npcXml.GetAttribute("enemyType"));
                npc_node.height =readIntAttribute(npcXml,"height");
                npc_node.interval = readIntAttribute(npcXml, "interval");
                npc_node.level = readIntAttribute(npcXml, "level");
                npc_node.nkind = readIntAttribute(npcXml, "nkind");
                npc_node.npcName = npcXml.GetAttribute("name").ToString();
                npc_node.modelId = npcXml.GetAttribute("modelId");
                npc_node.ntype = readIntAttribute(npcXml, "ntype");
                npc_node.num = readIntAttribute(npcXml, "num");
                npc_node.speed = readIntAttribute(npcXml, "speed");
                npc_node.scope = readIntAttribute(npcXml, "scope");
                npc_node.type = readIntAttribute(npcXml, "type");
                npc_node.walklen = readIntAttribute(npcXml, "walklen");
                npc_node.width = readIntAttribute(npcXml, "width");
                npc_node.x = readIntAttribute(npcXml, "x");
                npc_node.y = readIntAttribute(npcXml, "y");

                npc_node.uniqueId = npcXml.GetAttribute("uniqueId");
                
       

                editMapNpc(npc_node, OPERATE_ADD);
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
                try { zone_node.countryflag = int.Parse(zoneXml.GetAttribute("contryflag")); }
                catch { zone_node.countryflag = 7; }
                try { zone_node.zoneindex = int.Parse(zoneXml.GetAttribute("zoneindex")); }
                catch { zone_node.zoneindex = 1; }
                try { zone_node.eulerangles = zoneXml.GetAttribute("eulerangles"); }
                catch { zone_node.eulerangles = ""; }
                foreach (XmlElement region_item in zoneXml.ChildNodes)
                {
                    string[] col_list = region_item.GetAttribute("points").Split(',');
                    for (int j = 0; j < col_list.Length; j++)
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
                warp_node.id =  readIntAttribute(warpXml, "id");
                warp_node.warpType = readIntAttribute(warpXml, "warpType");
                try { warp_node.openCondition = int.Parse(warpXml.GetAttribute("openCondition")); }
                catch { warp_node.openCondition = 0; }
                addMapWarp(warp_node, OPERATE_ADD);
            }

            XmlNodeList doorXmlNodes = xmlDocs.GetElementsByTagName("mapDoor");
            for (int i = 0; i < doorXmlNodes.Count; i++)
            {
                XmlElement doorXml = (XmlElement)doorXmlNodes[i];
                MapDoor door_node = new MapDoor();
                door_node.id = readIntAttribute(doorXml, "id");
                door_node.type = int.Parse(doorXml.GetAttribute("type"));
                door_node.x = int.Parse(doorXml.GetAttribute("x"));
                door_node.y = int.Parse(doorXml.GetAttribute("y"));
                //try { warp_node.regiontype = int.Parse(warpXml.GetAttribute("regiontype")); }
                //catch { warp_node.type = 0; }
                door_node.width = int.Parse(doorXml.GetAttribute("width"));
                door_node.height = int.Parse(doorXml.GetAttribute("height"));
                door_node.state = int.Parse(doorXml.GetAttribute("state"));
                door_node.res = doorXml.GetAttribute("res");
                door_node.eulerangles = doorXml.GetAttribute("eulerangles");


                addMapDoor(door_node, OPERATE_ADD);
            }

            XmlNodeList triggerXmlNodes = xmlDocs.GetElementsByTagName("mapTrigger");
            for (int i = 0; i < triggerXmlNodes.Count; i++)
            {
                XmlElement triggerXml = (XmlElement)triggerXmlNodes[i];
                MapTrigger trigger_node = new MapTrigger();
                trigger_node.id = readIntAttribute(triggerXml, "id");
                trigger_node.type = int.Parse(triggerXml.GetAttribute("type"));
                trigger_node.x = int.Parse(triggerXml.GetAttribute("x"));
                trigger_node.y = int.Parse(triggerXml.GetAttribute("y"));
                trigger_node.width = int.Parse(triggerXml.GetAttribute("width"));
                trigger_node.height = int.Parse(triggerXml.GetAttribute("height"));
                //try { warp_node.regiontype = int.Parse(warpXml.GetAttribute("regiontype")); }
                //catch { warp_node.type = 0; }
                try { trigger_node.triggerType = int.Parse(triggerXml.GetAttribute("triggerType")); }
                catch { trigger_node.triggerType = 0; }
                try { trigger_node.triggerParam = triggerXml.GetAttribute("triggerParam"); }
                catch { trigger_node.triggerParam = ""; }
                trigger_node.targetType = int.Parse(triggerXml.GetAttribute("targetType"));
                trigger_node.targetParam = triggerXml.GetAttribute("targetParam");
                trigger_node.eulerangles = triggerXml.GetAttribute("eulerangles");

                addMapTrigger(trigger_node, OPERATE_ADD);
            }

            XmlNodeList effectPointXmlNodes = xmlDocs.GetElementsByTagName("mapEffectPoint");
            for (int i = 0; i < effectPointXmlNodes.Count; i++)
            {
                XmlElement effectPointXml = (XmlElement)effectPointXmlNodes[i];
                MapEffectPoint effectpoint_node = new MapEffectPoint();
                effectpoint_node.id = int.Parse(effectPointXml.GetAttribute("id"));
                effectpoint_node.type = int.Parse(effectPointXml.GetAttribute("type"));
                effectpoint_node.x = int.Parse(effectPointXml.GetAttribute("x"));
                effectpoint_node.y = int.Parse(effectPointXml.GetAttribute("y"));
                effectpoint_node.width = int.Parse(effectPointXml.GetAttribute("width"));
                effectpoint_node.height = int.Parse(effectPointXml.GetAttribute("height"));
                effectpoint_node.res = effectPointXml.GetAttribute("res");
                effectpoint_node.eulerangles = effectPointXml.GetAttribute("eulerangles");

                addMapEffectPoint(effectpoint_node, OPERATE_ADD);
            }
            
            XmlNodeList lineXmlNodes = xmlDocs.GetElementsByTagName("linedef");
            for (int i = 0; i < lineXmlNodes.Count; i++)
            {
                XmlElement lineXML = (XmlElement)lineXmlNodes[i];
                MapLine line_node = new MapLine(int.Parse(lineXML.GetAttribute("startobjid")));
                line_node.x = int.Parse(lineXML.GetAttribute("x"));
                line_node.y = int.Parse(lineXML.GetAttribute("y"));
                //try { warp_node.regiontype = int.Parse(warpXml.GetAttribute("regiontype")); }
                //catch { warp_node.type = 0; }
                line_node.id = int.Parse(lineXML.GetAttribute("id"));
                string ptStr = lineXML.GetAttribute("points");
                line_node.type = int.Parse(lineXML.GetAttribute("type"));
                //line_node.pointsStr = ptStr;
                line_node.linepts = new List<MapLinePoint>();
                string[] ptArr = ptStr.Split(';');
                for (int j = 0; j < ptArr.Length;j++ )
                {
                    line_node.linepts.Add(new MapLinePoint(int.Parse(ptArr[j].Split(' ')[0]), int.Parse(ptArr[j].Split(' ')[1])));
                }
                
                addMapLine(line_node, OPERATE_ADD);
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
        initZone();
        initLine();
        initMapDoor();
        initMapTrigger();
        initMapEffectPoint();
    }

    public void saveMapXML()
    {
        XmlDocument xmlDocs = new XmlDocument();
        string xmlPath = EditorConfig.ExcelDataDir + "../地图数据文件/xianwang/map/" + mapXmlId + ".xml";
        XmlDeclaration dec = xmlDocs.CreateXmlDeclaration("1.0", "UTF-8", null);
        XmlElement root = xmlDocs.CreateElement("HLMapConfig");
        xmlDocs.AppendChild(root);
        root.SetAttribute("resourceid", EditorData.mapTileId);
        root.SetAttribute("mapid", EditorData.mapId);
        Dictionary<int, string> row_region = new Dictionary<int, string>();

        foreach (KeyValuePair<string, MapNpc> kp_npc in npcCollection)
        {
            MapNpc npcNode = kp_npc.Value;
            if (npcNode.target == null)
                continue;
            XmlElement ele_npc = xmlDocs.CreateElement("npc");
            ele_npc.SetAttribute("id", npcNode.id.ToString());
            ele_npc.SetAttribute("type", npcNode.type.ToString());
            ele_npc.SetAttribute("x", npcNode.x.ToString());
            ele_npc.SetAttribute("y", npcNode.y.ToString());
            ele_npc.SetAttribute("direction", npcNode.direction.ToString());
            ele_npc.SetAttribute("level", npcNode.level.ToString());
            ele_npc.SetAttribute("scope", npcNode.scope.ToString());
            ele_npc.SetAttribute("ai", npcNode.ai.ToString());
            ele_npc.SetAttribute("modelId", npcNode.modelId);
            ele_npc.SetAttribute("name", npcNode.npcName.ToString());
            ele_npc.SetAttribute("enemyType", npcNode.enemyType.ToString());
            ele_npc.SetAttribute("num", npcNode.num.ToString());
            ele_npc.SetAttribute("interval", npcNode.interval.ToString());
            ele_npc.SetAttribute("height", npcNode.height.ToString());
            ele_npc.SetAttribute("width", npcNode.width.ToString());
            ele_npc.SetAttribute("chase", npcNode.chase.ToString());
            ele_npc.SetAttribute("uniqueId", npcNode.uniqueId.ToString());
            root.AppendChild(ele_npc);
        }

        foreach (KeyValuePair<int, MapZone> kp_zone in zoneCollection)
        {
            MapZone zoneNode = kp_zone.Value;
            if (zoneNode.target == null)
                continue;
            XmlElement ele_zone = xmlDocs.CreateElement("zonedef");
            ele_zone.SetAttribute("id", zoneNode.id.ToString());
            ele_zone.SetAttribute("type", zoneNode.type.ToString());
            ele_zone.SetAttribute("regiontype", zoneNode.regiontype.ToString());
            ele_zone.SetAttribute("contryflag", zoneNode.countryflag.ToString());
            ele_zone.SetAttribute("x", zoneNode.x.ToString());
            ele_zone.SetAttribute("y", zoneNode.y.ToString());
            ele_zone.SetAttribute("width", zoneNode.width.ToString());
            ele_zone.SetAttribute("height", zoneNode.height.ToString());
            ele_zone.SetAttribute("zoneindex", zoneNode.zoneindex.ToString());
            ele_zone.SetAttribute("eulerangles", zoneNode.eulerangles);
            root.AppendChild(ele_zone);

            row_region.Clear();
            //fill nodes to dict by row num
            foreach (KeyValuePair<MapNode, int> kp_node in kp_zone.Value.nodeDict)
            {
                if (row_region.ContainsKey(kp_node.Key.y))
                    row_region[kp_node.Key.y] += kp_node.Key.x + ",";
                else
                    row_region[kp_node.Key.y] = kp_node.Key.x + ",";
            }
            //append each row
            foreach (KeyValuePair<int, string> kp_region in row_region)
            {
                XmlElement ele_region = xmlDocs.CreateElement("region");
                ele_region.SetAttribute("row", kp_region.Key.ToString());
                ele_region.SetAttribute("points", kp_region.Value.Substring(0, kp_region.Value.Length - 1));
                ele_zone.AppendChild(ele_region);
            }
        }

        foreach (KeyValuePair<int, MapWarp> kp_warp in warpCollection)
        {
            MapWarp warpNode = kp_warp.Value;
            if (warpNode.target == null)
                continue;

            XmlElement ele_warp = xmlDocs.CreateElement("waypoint");
            ele_warp.SetAttribute("id", warpNode.id.ToString());
            ele_warp.SetAttribute("type", warpNode.type.ToString());
            ele_warp.SetAttribute("x", warpNode.warpX.ToString());
            ele_warp.SetAttribute("y", warpNode.warpY.ToString());
            ele_warp.SetAttribute("state", warpNode.state.ToString());
            ele_warp.SetAttribute("name", warpNode.warpName);
            ele_warp.SetAttribute("openCondition", warpNode.openCondition.ToString());
            

            ele_warp.SetAttribute("destMapId1", warpNode.destMapId.ToString());
            ele_warp.SetAttribute("destPosX1", warpNode.destMapX.ToString());
            ele_warp.SetAttribute("destPosY1", warpNode.destMapY.ToString());
            ele_warp.SetAttribute("destMapId2", warpNode.destMapId.ToString());
            ele_warp.SetAttribute("destPosX2", warpNode.destMapX.ToString());
            ele_warp.SetAttribute("destPosY2", warpNode.destMapY.ToString());
            ele_warp.SetAttribute("destMapId3", warpNode.destMapId.ToString());
            ele_warp.SetAttribute("destPosX3", warpNode.destMapX.ToString());
            ele_warp.SetAttribute("destPosY3", warpNode.destMapY.ToString());
            ele_warp.SetAttribute("warpType", warpNode.warpType.ToString());
            root.AppendChild(ele_warp);
        }

        foreach (KeyValuePair<int, MapDoor> kp_door in doorCollection)
        {
            MapDoor doorNode = kp_door.Value;
            if (doorNode.target == null)
                continue;

            XmlElement ele_door = xmlDocs.CreateElement("mapDoor");
            ele_door.SetAttribute("id", doorNode.id.ToString());
            ele_door.SetAttribute("type", doorNode.type.ToString());
            ele_door.SetAttribute("x", doorNode.x.ToString());
            ele_door.SetAttribute("y", doorNode.y.ToString());
            ele_door.SetAttribute("width", doorNode.width.ToString());
            ele_door.SetAttribute("height", doorNode.height.ToString());

            ele_door.SetAttribute("state", doorNode.state.ToString());
            ele_door.SetAttribute("res", doorNode.res);
            ele_door.SetAttribute("eulerangles", doorNode.eulerangles.ToString());
            root.AppendChild(ele_door);
        }

        foreach (KeyValuePair<int, MapTrigger> kp_trigger in triggerCollection)
        {
            MapTrigger triggerNode = kp_trigger.Value;
            if (triggerNode.target == null)
                continue;

            XmlElement ele_trigger = xmlDocs.CreateElement("mapTrigger");
            ele_trigger.SetAttribute("id", triggerNode.id.ToString());
            ele_trigger.SetAttribute("type", triggerNode.type.ToString());
            ele_trigger.SetAttribute("x", triggerNode.x.ToString());
            ele_trigger.SetAttribute("y", triggerNode.y.ToString());
            ele_trigger.SetAttribute("width", triggerNode.width.ToString());
            ele_trigger.SetAttribute("height", triggerNode.height.ToString());

            ele_trigger.SetAttribute("triggerType", triggerNode.triggerType.ToString());
            try { ele_trigger.SetAttribute("triggerParam", triggerNode.triggerParam.ToString()); }
            catch { ele_trigger.SetAttribute("triggerParam", ""); }
            ele_trigger.SetAttribute("targetType", triggerNode.targetType.ToString());
            ele_trigger.SetAttribute("targetParam", triggerNode.targetParam.ToString());
            ele_trigger.SetAttribute("eulerangles", triggerNode.eulerangles.ToString());
            root.AppendChild(ele_trigger);
        }

        foreach (KeyValuePair<int, MapEffectPoint> kp_effectpoint in effectPointCollection)
        {
            MapEffectPoint effectpointNode = kp_effectpoint.Value;
            if (effectpointNode.target == null)
                continue;

            XmlElement ele_effectpoint = xmlDocs.CreateElement("mapEffectPoint");
            ele_effectpoint.SetAttribute("id", effectpointNode.id.ToString());
            ele_effectpoint.SetAttribute("type", effectpointNode.type.ToString());
            ele_effectpoint.SetAttribute("x", effectpointNode.x.ToString());
            ele_effectpoint.SetAttribute("y", effectpointNode.y.ToString());
            ele_effectpoint.SetAttribute("width", effectpointNode.width.ToString());
            ele_effectpoint.SetAttribute("height", effectpointNode.height.ToString());
            ele_effectpoint.SetAttribute("res", effectpointNode.res);
            
            ele_effectpoint.SetAttribute("eulerangles", effectpointNode.eulerangles.ToString());
            root.AppendChild(ele_effectpoint);
        }

        foreach (KeyValuePair<int, MapLine> kp_line in lineCollection)
        {
            MapLine lineNode = kp_line.Value;
            if (lineNode.target == null)
                continue;

            XmlElement ele_line = xmlDocs.CreateElement("linedef");
            ele_line.SetAttribute("id", lineNode.id.ToString());
            ele_line.SetAttribute("type", lineNode.type.ToString());
            ele_line.SetAttribute("x", lineNode.x.ToString());
            ele_line.SetAttribute("y", lineNode.y.ToString());
            ele_line.SetAttribute("startobjid", lineNode.starobjid.ToString());

            string ptStr = "";
            for (int j = 0; j < lineNode.linepts.Count; j++)
            {
                ptStr += lineNode.linepts[j].x.ToString() + " " + lineNode.linepts[j].y.ToString() + ";";
            }
            ptStr = ptStr.Substring(0, ptStr.Length - 1);
            ele_line.SetAttribute("points", ptStr);

            root.AppendChild(ele_line);
        }

        xmlDocs.Save(xmlPath);
        Debug.Log("保存成功:" + xmlPath);
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
   
    private void initZone()
    {
        foreach (KeyValuePair<int, MapZone> kp in zoneCollection)
        {
            MapZone npc = kp.Value;
            Vector2 pos = PathUtilEdit.logicCenter2Real(npc.x,npc.y);
        
            float h1 = EditorData.terrainMan.GetHeight(pos.x, pos.y)+0.1f;
           
            Vector3 npcPos = new Vector3(pos.x, h1, pos.y);
            npcHelper.AddMapZone(npc, npcPos);
           
        }

    }

    private void initLine()
    {
        foreach (KeyValuePair<int, MapLine> kp in lineCollection)
        {
            MapLine npc = kp.Value;
     

            npcHelper.AddLine(npc);

        }
    }
    private void initMapNpc()
    {
        foreach (KeyValuePair<string, MapNpc> kp in npcCollection)
        {
            MapNpc npc = kp.Value;
            DataRow npcCfg = EditorTool.getNpc(npc.id);
            try
            {
                kp.Value.modelId =npcCfg["modelId"].ToString();
                kp.Value.modelId = "n_fujiaertongnv";
            }
            catch
            {
                kp.Value.modelId = npcCfg["modelId"].ToString();
            }

            Vector2 pos = PathUtilEdit.logicCenter2Real(npc.x, npc.y);

         
            float h1 = EditorData.terrainMan.GetHeight(pos.x, pos.y);
            if (kp.Value.id == 101001001)
                Debug.Log("x:" + pos.x + ",y:" + pos.y + ",int x:" + npc.x + "," + npc.y + ",orig:" + PathUtilEdit.origin_x + "," + PathUtilEdit.origin_z);
            Vector3 npcPos = new Vector3(pos.x, h1, pos.y);
            npcHelper.LoadNpc(kp.Value, npcPos);
            // mapNpcMgr.ShowSkillFx((GameObject.Find(RoleCtrl) as RoleCtrl), "n_fujiaertongnv");
            //mapNpcMgr.ShowSkillFx(null, kp.Value.modelId, npcPos);
        }

    }

    private void initMapWarp()
    {
        foreach (KeyValuePair<int, MapWarp> kp in warpCollection)
        {
            MapWarp warp = kp.Value;
           Vector2 pos =   PathUtilEdit.logicCenter2Real(warp.warpX, warp.warpY);


           float h1 = EditorData.terrainMan.GetHeight(pos.x, pos.y);
           Vector3 npcPos = new Vector3(pos.x, h1, pos.y);
            npcHelper.AddWarp(warp, npcPos);
        }
    }

    private void initMapDoor()
    {
        foreach (KeyValuePair<int, MapDoor> kp in doorCollection)
        {
            MapDoor door = kp.Value;
            Vector2 pos = PathUtilEdit.logicCenter2Real(door.x, door.y);


            float h1 = EditorData.terrainMan.GetHeight(pos.x, pos.y);
            Vector3 npcPos = new Vector3(pos.x, h1, pos.y);
            npcHelper.AddDoor(door, npcPos);
        }
    }

    private void initMapTrigger()
    {
        foreach (KeyValuePair<int, MapTrigger> kp in triggerCollection)
        {
            MapTrigger trigger = kp.Value;
            Vector2 pos = PathUtilEdit.logicCenter2Real(trigger.x, trigger.y);


            float h1 = EditorData.terrainMan.GetHeight(pos.x, pos.y);
            Vector3 npcPos = new Vector3(pos.x, h1, pos.y);
            npcHelper.AddTrigger(trigger, npcPos);
        }
    }
    private void initMapEffectPoint()
    {
        foreach (KeyValuePair<int, MapEffectPoint> kp in effectPointCollection)
        {
            MapEffectPoint effectPoint = kp.Value;
            Vector2 pos = PathUtilEdit.logicCenter2Real(effectPoint.x, effectPoint.y);


            float h1 = EditorData.terrainMan.GetHeight(pos.x, pos.y);
            Vector3 npcPos = new Vector3(pos.x, h1, pos.y);
            npcHelper.AddEffectPoint(effectPoint, npcPos);
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
 