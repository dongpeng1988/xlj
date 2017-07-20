

using sw.res;
using sw.scene.ctrl;
using sw.scene.model;
using System.Collections.Generic;
using UnityEngine;
namespace sw.manager
{
    /// <summary>
    /// 一个简单的技能控制管理
    /// </summary>
    public class jueseFxManager:IjueseManager
    {
        Dictionary<string, GameObject> fxCache = new Dictionary<string, GameObject>();
        Dictionary<string, List<ShowItem>> toShowItems = new Dictionary<string, List<ShowItem>>();
        CommonObjectPool fxPool = new CommonObjectPool("modelPool");
        GameObjectPool goPool;
        private string curRoleName;
        public jueseFxManager()
        {
            goPool = new GameObjectPool();
        }
        public void ShowModel(RoleCtrlDemo target, string roleName)
        {
            curRoleName = roleName;
            GameObject obj = fxPool.Spawn(roleName);
            if(obj == null)
            {
                List<ShowItem> items;
                if (!toShowItems.TryGetValue(roleName, out items))
                {
                    items = new List<ShowItem>();
                    toShowItems[roleName] = items;
                }
                items.Add(new ShowItem() { roleName = roleName, target = target });
                goPool.Spawn("model/" + roleName.ToLower(), roleName, onLoadModel, roleName);
                //AssetLoader2.Instance.LoadAsset("model/" + roleName.ToLower() , roleName, typeof(GameObject), onLoadModel, roleName);
            }
            BindTarget(obj, target); 
        }
        Dictionary<string, string> alreadyLoad = new Dictionary<string, string>();
        void BindTarget(GameObject obj, RoleCtrlDemo target)
        {
            Transform root = target.gameObject.transform;
            if (root == null)
                return;
            if (obj == null)
                return;
            Transform objtran = obj.transform;
            objtran.parent = root;
            objtran.position = root.position;

            wingBindTrans = obj.GetComponent<RoleData>().wingBind;
            weapon1BindTrans = obj.GetComponent<RoleData>().weapon1Bind;
            weapon2BindTrans = obj.GetComponent<RoleData>().weapon2Bind;
            string xxx=string.Empty;
            if (alreadyLoad.TryGetValue(curRoleName,out xxx))
                return;
            string weaponName = "";
            string wingName = "";
            switch (curRoleName)
            {
                case "z_men1_5":
                    weaponName = "wuqi_jian5_skin";
                    wingName = "y_10";
                    break;
                case "z_women1_0":
                    weaponName = "wuqi_nu5_a_skin";
                    wingName = "y_5";
                    break;
                case "z_women2_5":
                    weaponName = "wuqi_fazhang5_skin";
                    wingName = "y_3";
                    break;
            }
            onLoadWeapon(weaponName);
            onLoadWing(wingName);
            alreadyLoad[curRoleName] = curRoleName;
        }
        public void disposeCallBack(GameObject obj)
        {
            fxPool.Despawn(obj);
        }
        public void preloadPrepare(string modelName)
        {
            GameObject obj = fxPool.Spawn(modelName);
            if (obj == null)
            {
                goPool.Spawn("model/" + modelName.ToLower() , modelName, onPrepareModel, modelName);
            }
        }
        void onPrepareModel(object obj,object[] param)
        {
            if (obj == null)
                return;
            string fxname = param[0] as string;
            GameObject gobj = obj as GameObject;
            fxPool.AddPrefab(fxname, gobj);
            GameObject fx = fxPool.Spawn(fxname);
            disposeCallBack(fx);
        }
        public void Preload(string modelName)
        {
            curRoleName = modelName;
            AssetLoader2.Instance.LoadAsset("model/" + modelName.ToLower() , modelName, typeof(GameObject), onLoadModel, modelName);
        }
        Transform wingBindTrans, weapon1BindTrans, weapon2BindTrans, xpBindTrans;
        void onLoadModel(object obj,object[] param)
        {
            if (obj == null)
                return;
            GameObject gobj = GameObject.Instantiate(obj as GameObject);
            string fxname = param[0] as string;
            fxPool.AddPrefab(fxname, gobj);
             List<ShowItem> items;
             if (toShowItems.TryGetValue(fxname, out items))
             {
                 for(int i=0;i<items.Count;i++)
                 {
                     ShowItem item = items[i];
                     GameObject fx = fxPool.Spawn(fxname);
                     BindTarget(fx, item.target);
                 }
                 toShowItems.Remove(fxname);
             }
        }
        void onLoadWeapon(string weaponName)
        {
            GameObject obj = fxPool.Spawn(weaponName);
            if (obj == null)
            {
                goPool.Spawn("model/" + weaponName.ToLower() , weaponName, onBindWeapon, weaponName);
            }
            else
                poolBindWeapon(obj);
        }
        void onBindWeapon(object obj, object[] param)
        {
            if (obj == null)
                return;
            GameObject gobj = GameObject.Instantiate(obj as GameObject);
            poolBindWeapon(gobj);
        }
        void poolBindWeapon(GameObject gobj)
        {
            Transform objtran = gobj.transform;
            objtran.SetParent(weapon1BindTrans);
            objtran.localPosition = Vector3.zero;
            objtran.localRotation = Quaternion.identity;
            objtran.localScale = Vector3.one;
            if (curRoleName == "z_women1_5")
            {
                string weaponName = "wuqi_nu5_a_skin";
                onLoadWeapon2("wuqi_nu5_a_skin");
            }
        }
        void onLoadWeapon2(string weaponName)
        {
            GameObject obj = fxPool.Spawn(weaponName);
            if (obj == null)
            {
                goPool.Spawn("model/" + weaponName.ToLower() , weaponName, onBindWeapon1, weaponName);
            }
            else
                poolBindWeapon1(obj);
        }
        void onBindWeapon1(object obj, object[] param)
        {
            if (obj == null)
                return;
            GameObject gobj2 = GameObject.Instantiate(obj as GameObject);
            poolBindWeapon1(gobj2);
        }
        void poolBindWeapon1(GameObject gobj)
        {
            Transform objtran2 = gobj.transform;
            objtran2.SetParent(weapon2BindTrans);
            objtran2.localPosition = Vector3.zero;
            objtran2.localRotation = Quaternion.identity;
            objtran2.localScale = Vector3.one;
        }
        void onLoadWing(string wingName)
        {
            GameObject obj = fxPool.Spawn(wingName);
            if (obj == null)
            {
                goPool.Spawn("model/" + wingName.ToLower() , wingName, onBindWing, wingName);
            }
            else
                poolBindWing(obj);
            //AssetLoader2.Instance.LoadAsset("model/" + wingName.ToLower() , wingName, typeof(GameObject), onBindWing, wingName);
        }
        void onBindWing(object obj,object[] param)
        {
            if (obj == null)
                return;
            GameObject gobj = GameObject.Instantiate(obj as GameObject);
            poolBindWing(gobj);
        }
        void poolBindWing(GameObject gobj)
        {
            Transform objtran = gobj.transform;
            objtran.SetParent(wingBindTrans);
            objtran.localPosition = Vector3.zero;
            objtran.localRotation = Quaternion.identity;
            objtran.localScale = Vector3.one; 
        }
    }

    struct ShowItem
    {
        public string roleName;
        public RoleCtrlDemo target;
    }
}
