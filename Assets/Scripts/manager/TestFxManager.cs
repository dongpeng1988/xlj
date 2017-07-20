

using sw.res;
using sw.scene.ctrl;
using sw.scene.model;
using System.Collections.Generic;
using UnityEngine;
namespace sw.manager
{
    public class TestFxManager:IFxManager
    {
        Dictionary<string, GameObject> fxCache = new Dictionary<string, GameObject>();
        Dictionary<string, List<ShowItem>> toShowItems = new Dictionary<string, List<ShowItem>>();
        CommonObjectPool fxPool = new CommonObjectPool("skillPool");
        GameObjectPool goPool;
        public  TestFxManager()
        {
            goPool = new GameObjectPool();
        }
        public void ShowSkillFx(RoleCtrlDemo target, SkillInfo info)
        {
           GameObject obj =   fxPool.Spawn(info.fx);
            if(obj == null)
            {
                List<ShowItem> items;
                if (!toShowItems.TryGetValue(info.fx, out items))
                {
                    items = new List<ShowItem>();
                    toShowItems[info.fx] = items;
                }
                items.Add(new ShowItem() { info = info,target = target });
                goPool.Spawn("fx/" + info.fx.ToLower() , info.fx, onLoadFx, info.fx);
            }
            BindFx(obj,target, info); 
        }
        void BindFx(GameObject obj, RoleCtrlDemo target, SkillInfo info)
        {
            //Transform root = info.bind;
            //if (root == null)
            Transform root = target.gameObject.transform;
            if (root == null)
                return;
            if (obj == null)
                return;
            Transform objtran = obj.transform;
            objtran.parent = root;
            objtran.localPosition = info.offset;
            objtran.localScale = Vector3.one;
            objtran.localRotation = Quaternion.identity;
            settingCallBack(obj);
        }
        private void settingCallBack(GameObject obj)
        {
            settingCallBack(obj, 3);
        }
        private void settingCallBack(GameObject obj, float time)
        {
            if (obj == null)
                return;
            FxDestroy fxDestroy = obj.GetComponent<FxDestroy>();
            if (fxDestroy == null)
            {
                fxDestroy = obj.AddComponent<FxDestroy>();
                fxDestroy.destroytm = time;
            }
            fxDestroy.disposeCallback = disposeCallBack;
            fxDestroy.startCount();
        }
        private void disposeCallBack(GameObject obj)
        {
            fxPool.Despawn(obj);
        }
        public void Preload(string fxname)
        {
            return;
            GameObject obj = fxPool.Spawn(fxname);
            if (obj == null)
                goPool.Spawn("fx/" + fxname , fxname, onLoadFx, fxname);
        }
        void onLoadFx(object obj,object[] param)
        {
            GameObject gobj = obj as GameObject;
            if(gobj == null)
                return;
            string fxname = param[0] as string;
            fxPool.AddPrefab(fxname, gobj);
             List<ShowItem> items;
             if (toShowItems.TryGetValue(fxname, out items))
             {
                 for(int i=0;i<items.Count;i++)
                 {
                     ShowItem item = items[i];
                     GameObject fx = fxPool.Spawn(fxname);
                     BindFx(fx, item.target,item.info);
                 }
                 toShowItems.Remove(fxname);
             }

        }
        struct ShowItem
        {
            public SkillInfo info;
            public RoleCtrlDemo target;
        }
    }
}
