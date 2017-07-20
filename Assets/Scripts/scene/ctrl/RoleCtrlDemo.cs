

using sw.game.model;
using sw.manager;
using sw.scene.model;
using sw.util;
using System.Collections.Generic;
using UnityEngine;
namespace sw.scene.ctrl
{
    public class RoleCtrlDemo:MonoBehaviour
    {
        RoleData roleData;

        Animator anim;
        Animator horseAnim;
        Animator wingAnim;
        public IFxManager fxMan;
        public ITerrainManager terrainMan;
        public IjueseManager jueseMan;
  
        Transform trans;
        Transform renwuTrans;
        Transform horseTrans;
        Transform wingTrans;
        public float moveSpeed = 7f;
        void Awake()
        {
            renwuTrans = base.transform.FindChild("z_men1_5");
            
            anim = renwuTrans.gameObject.GetComponent<Animator>();
            roleData = renwuTrans.gameObject.GetComponent<RoleData>();
            trans = base.gameObject.transform;
            horseTrans = trans.FindChild("q_huoqilin");
            //wingTrans = roleData.wingBind.GetChild(0);
            horseAnim = horseTrans.gameObject.GetComponent<Animator>();
            //wingAnim = wingTrans.gameObject.GetComponent<Animator>();
            UpdateRolePosition();

            RoleData mainData = renwuTrans.gameObject.GetComponent<RoleData>();
            mainData.onPlayFx = onPlayFx;
        }
        public void PlaySkill(int idx)
        {
            anim.SetInteger("attack", idx);
            anim.SetTrigger("attackState");
            //if(roleData != null && fxMan != null)
            //{
            //    string fx = roleData.GetFx(idx); 
            //    fxMan.Preload(fx);
            //}
        }
        private float preTime = 0f;
        public void onPlayFx(string stringParameter)
        {

            if (fxMan == null || roleData == null)
                return;
            string[] xxx = stringParameter.Split(',');
            stringParameter = xxx[0];
            int idx = int.Parse(stringParameter);
            preTime = Time.time;
            //idx = idx % 10;
            for(int i=0;i<roleData.skills.Length;i++)
            {
                if(roleData.skills[i].index == idx)
                {
                    fxMan.ShowSkillFx(this,roleData.skills[i]);
                    break;
                }
            }
        }
        public void ShowHurt()
        {
            anim.SetTrigger("injure");
        }
        public void ShowDie()
        {
            anim.SetBool("death", true);
        }
        private bool onZuoqi = false;
        public void zuoqi(bool on)
        {
            anim.SetBool("zuoqi", on);
            onZuoqi = on;
            UpdateRolePosition();
        }
        private void UpdateRolePosition()
        {
            if (onZuoqi)//显示坐骑
            {
                horseTrans.gameObject.SetActive(true);
                riderHorse();
                //renwuTrans.position = trans.position + new Vector3(0f, 9f, 0f);
            }
            else
            {
                getOff();
                horseTrans.gameObject.SetActive(false);
                //renwuTrans.position = trans.position;
            }
        }
        private void riderHorse()
        {
            Transform t = horseTrans.GetComponent<RiderData>().rider;
            renwuTrans.SetParent(t);
            renwuTrans.localPosition = Vector3.zero;
            renwuTrans.localRotation = Quaternion.identity;
            renwuTrans.localScale = Vector3.one;
            moveSpeed = 10f;
        }
        private void getOff()
        {
            renwuTrans.SetParent(base.transform);
            renwuTrans.localPosition = Vector3.zero;
            renwuTrans.localRotation = Quaternion.identity;
            renwuTrans.localScale = Vector3.one;
            moveSpeed = 7f;
        }
        List<WalkStep> curSteps;
        WalkStep curStep;
     
        Vector3 startPos, destPos;
        float startTm,stepTm;
        private WalkStep DequeueStep()
        {
            if (curSteps == null || curSteps.Count <= 0)
                return null;
            WalkStep step = curSteps[curSteps.Count - 1];
            curSteps.RemoveAt(curSteps.Count - 1);
            return step;
        }
        public void DoWalk(List<WalkStep> steps)
        {
            curSteps = steps;
            DequeueStep();
            curStep = DequeueStep();

            startPos = trans.position;
            destPos = PathUtilEdit.LogicCenter2Real(curStep.pt);
            destPos.y = startPos.y;
            stepTm = (destPos - startPos).magnitude / moveSpeed;
            startTm = Time.realtimeSinceStartup;
           Quaternion rot =   Quaternion.LookRotation(destPos - startPos);
           Vector3 rotv = rot.eulerAngles;
           rotv.x = 0;
           rotv.z = 0;
          // LoggerHelper.Debug("rot:" + rotv + ",stepTm:" + stepTm + ",curpos:" + startPos + ",destPos:" + destPos);
           trans.rotation = Quaternion.Euler(rotv);
            OnWalkStart();
        }
        void Start()
        {
            foreach(SkillState ss in anim.GetBehaviours<SkillState>())
            {
                ss.onEnter = onEnterSkill;
            }

        }
        void onEnterSkill(int index)
        {
            //Debug.Log("on enter skill:" + index+",frame:"+Time.frameCount);
        }
        void Update()
        {
            UpdateWalk();
        }
        void OnWalkEnd()
        {
            anim.SetBool("run", false);
            anim.SetBool("zuoqi",onZuoqi);
            //wingAnim.SetBool("run",false);
            if (onZuoqi)
            {
                horseAnim.SetBool("run", false);
            }
        }
        void OnWalkStart()
        {
            anim.SetBool("run", true);
            anim.SetBool("zuoqi",onZuoqi);
            //wingAnim.SetBool("run", true);
            if (onZuoqi)
            {
                horseAnim.SetBool("run", true);
            }
        }
        void UpdateWalk()
        {
            if (curStep  == null)
                return;
            float tm = Time.realtimeSinceStartup;
            float ratio = (tm - startTm) / stepTm;
            //LoggerHelper.Debug("lerp ratio:" + ratio);
            Vector3 pos = destPos;
            if(ratio>=1)
            {
                curStep = DequeueStep();

                if (curStep == null)
                {
                    
                    OnWalkEnd();
                }
                else
                {
                    startPos = destPos;
                    destPos = PathUtilEdit.LogicCenter2Real(curStep.pt);
                    stepTm = (destPos - startPos).sqrMagnitude / moveSpeed;
                    startTm = Time.realtimeSinceStartup;
                }
            }
            else
            {
                pos = Vector3.Lerp(startPos, destPos, ratio);
            }
           pos.y = terrainMan.GetHeight(pos.x,pos.z);
           // LoggerHelper.Debug("pos:" + pos);
            trans.position = pos;
            LODLoader.rolePos = pos;
        }
        public void onHuanjue(string curRole)
        {
            if (jueseMan != null)
            {
                //jueseMan.Preload(curRole);
            }
            jueseMan.disposeCallBack(renwuTrans.gameObject);
            //GameObject.Destroy(renwuTrans.gameObject);
            jueseMan.ShowModel(this, curRole);
            renwuTrans = base.transform.FindChild(curRole);
            anim = renwuTrans.gameObject.GetComponent<Animator>();
            roleData = renwuTrans.gameObject.GetComponent<RoleData>();
            zuoqi(onZuoqi);
            RoleData mainData = renwuTrans.gameObject.GetComponent<RoleData>();
            mainData.onPlayFx = onPlayFx;
        }
    }
}
