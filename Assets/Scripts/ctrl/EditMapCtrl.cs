using UnityEngine;
using System.Collections.Generic;
using sw.ui.model;
using System;
using sw.manager;
using sw.scene.ctrl;
using Config;
using sw.util;
#if UNITY_EDITOR
using UnityEditor;
#endif

namespace sw.ctrl
{
    public class EditMapCtrl : MonoBehaviour
    {

        public UIButton startEditBtn;
        public UIButton endEditBtn;
        public UIButton createXML;
        public UIButton openZonePanel;
        public UIButton openNpcPanel;

        public UILabel input_zoneId;
        public UILabel input_zone_pos;
        public UILabel input_zone_country;
        public UILabel input_zone_type;
        public UILabel input_zone_reliveHp;
        public UILabel input_zone_region;
        public UILabel input_zone_width;
        public UILabel input_zone_height;


        public UIButton addNpc;
        public UIButton removeNpc;
        public UILabel input_npcId;
        public UILabel input_npcModel;
        public UILabel input_npcX;
        public UILabel input_npcY;
        public UILabel input_npcType;
        public UILabel input_npcAI;
        public UILabel input_npcNum;
        public UILabel input_npcInterval;
        public UILabel input_npcScope;
        public UILabel input_npcChase;
        public UILabel input_npcEnemyType;
        public UILabel input_npcLevel;

        public GameObject zonePanel;
        public GameObject npcPanel;
        public UIGrid zoneListGrid;


        
        private Dictionary<MapNode, int> testDict;
        private ITerrainManager terrain;
        
        // Use this for initialization
        void Start()
        {
            EventDelegate.Add(startEditBtn.onClick, onStartEdit);
            EventDelegate.Add(endEditBtn.onClick, onEndEdit);
            EventDelegate.Add(createXML.onClick,onCreateXML);
            EventDelegate.Add(openZonePanel.onClick,onOpenZonePanel);
            EventDelegate.Add(openNpcPanel.onClick,onOpenNpcPanel);
            EventDelegate.Add(addNpc.onClick,onAddNpc);
            EventDelegate.Add(removeNpc.onClick, onRemoveNpc);
            refreshEditPanel();
            //terrain = 
        }

        // Update is called once per frame
        void Update()
        {

        }

        private void onStartEdit()
        {
            EditMapManager.Instance.EDIT_ZONE = true;
            MapZone editing_zone = new MapZone();
            try { editing_zone.id = int.Parse(input_zoneId.text); }
            catch { editing_zone.id = 0; }
            editing_zone.countryflag = int.Parse(input_zone_country.text);
            editing_zone.type = int.Parse(input_zone_type.text);
            editing_zone.width = int.Parse(input_zone_width.text);
            editing_zone.height = int.Parse(input_zone_height.text);
            editing_zone.regiontype = int.Parse(input_zone_region.text);
            editing_zone.reliveHp = int.Parse(input_zone_reliveHp.text);
            string[] posList = input_zone_pos.text.Split(',');
            editing_zone.x = (int)PathUtil.Logic2RealX(int.Parse(posList[0]));
            editing_zone.y = (int)PathUtil.Logic2RealZ(int.Parse(posList[0]));
            EditMapManager.Instance.editing_zone_param = editing_zone;

            
           

        }

        private void onEndEdit()
        {
            EditMapManager.Instance.EDIT_ZONE = false;
            refreshEditPanel();
            
        }

        private void onCreateXML()
        {
            EditMapManager.Instance.saveMapXML();
        }
       
        private bool _show_panel_zone = false;
        private void onOpenZonePanel()
        {
            _show_panel_zone = !_show_panel_zone;
            zonePanel.gameObject.SetActive(_show_panel_zone);
        }

        private bool _show_panel_npc = false;
        private void onOpenNpcPanel()
        {
            _show_panel_npc = !_show_panel_npc;
            npcPanel.gameObject.SetActive(_show_panel_npc);
        }

        private void onAddNpc()
        {
            NpcConfig npcCfg = ConfigAsset.Instance.getNpcConfigs(int.Parse(input_npcId.text));
            if (npcCfg == null)
            {
                Debug.Log("该NPC不在npc表中  " + int.Parse(input_npcId.text));
                return;
            }
            else
            {
                try
                {
                    input_npcModel.text = int.Parse(npcCfg.modelId).ToString();
                    input_npcModel.text = "n_fujiaertongnv";
                }
                catch
                {
                    input_npcModel.text = npcCfg.modelId;
                }
            }
            MapNpc npcNode = new MapNpc(int.Parse(input_npcId.text));
            npcNode.ntype = npcCfg.type;
            npcNode.x = int.Parse(input_npcX.text);
            npcNode.y = int.Parse(input_npcY.text);
            npcNode.ai = int.Parse(input_npcAI.text);
            npcNode.num = int.Parse(input_npcNum.text);
            npcNode.interval = int.Parse(input_npcInterval.text);
            npcNode.scope = int.Parse(input_npcScope.text);
            npcNode.chase = int.Parse(input_npcChase.text);
            npcNode.enemyType = int.Parse(input_npcEnemyType.text);
            npcNode.level = int.Parse(input_npcLevel.text);
            
            EditMapManager.Instance.editMapNpc(npcNode,EditMapManager.OPERATE_ADD);

            float h1 = EditMapManager.Instance.terrainMan.GetHeight(int.Parse(input_npcX.text),int.Parse(input_npcY.text));
            Vector3 npcPos = new Vector3(int.Parse(input_npcX.text),h1, int.Parse(input_npcY.text));
            
            npcNode.modelId = input_npcModel.text;
            EditMapManager.Instance.mapNpcMgr.Preload(input_npcModel.text, npcPos, npcNode.uniqueId.ToString());
            // mapNpcMgr.ShowSkillFx((GameObject.Find(RoleCtrl) as RoleCtrl), "n_fujiaertongnv");
            EditMapManager.Instance.mapNpcMgr.ShowSkillFx(null, input_npcModel.text, npcPos);

            
        }

        private void onRemoveNpc()
        {
            string npcId = input_npcId.text;
            MapNpc targetNpc = null;
            foreach (KeyValuePair<string, MapNpc> kp in EditMapManager.Instance.npcCollection)
            {
                if(kp.Value.id == int.Parse(npcId))
                {
                    targetNpc = kp.Value;
                    break;
                }
            }
            if (targetNpc == null)
                Debug.Log("************未找到该NPC********************");
            else
            {
                //GameObject bossLayer = GameObject.Find("bossLayer");
                //Transform oTrans = bossLayer.transform.Find(targetNpc.modelId);
                //GameObject o = oTrans.gameObject;
                GameObject o = GameObject.Find(targetNpc.modelId);
                GameObject.Destroy(o);
                EditMapManager.Instance.editMapNpc(targetNpc,EditMapManager.OPERATE_DELETE);
                
            }

        }
        private void refreshEditPanel()
        {

            if (zoneListGrid != null)
            {
                foreach (Transform trans in zoneListGrid.transform)
                {
                    GameObject.Destroy(trans.gameObject);
                }
            }
            for (int i = 0; i < EditMapManager.Instance.zoneCollection.Count; i++)
            {
                foreach(KeyValuePair<int,MapZone> kp_zone  in EditMapManager.Instance.zoneCollection)
                {
                    //KeyValuePair<int, Dictionary<MapNode, int>> kp = mapZone.nodeDict;
                    GameObject o = (GameObject)GameObject.Instantiate(Resources.Load("Prefabs/zoneListItem"));
                    o.GetComponent<zoneListItem>().zoneId.text = kp_zone.Key.ToString();
                    Dictionary<MapNode, int> temp_dict = kp_zone.Value.nodeDict;
                    int tempNodeType = 0;
                    foreach (MapNode temp_node in kp_zone.Value.nodeDict.Keys)
                    {
                        tempNodeType = temp_node.type;
                        break;
                    }
                    o.GetComponent<zoneListItem>().zoneInfo.text = EditMapManager.Instance.ZoneName(tempNodeType);
                    o.transform.parent = zoneListGrid.transform;
                    o.transform.position = Vector3.zero;
                    o.transform.localScale = new Vector3(1, 1, 1);
                    Debug.Log("Add List Item " + i);
                }
               
            }
            zoneListGrid.Reposition();
        }

    }
}
