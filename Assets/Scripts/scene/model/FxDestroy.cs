using sw.util;
using System;
using System.Collections;
using UnityEngine;
using UnityEngine.Events;
namespace sw.scene.model
{
    public class FxDestroy : MonoBehaviour
    {
        public float destroytm;
        public UnityAction<GameObject> disposeCallback;
        public void startCount()
        {
            TimerManager2.AddTimer((uint)destroytm * 1000, 0, destoryNow);
        }
        public void destoryNow()
        {
            TimerManager2.DelTimer(destoryNow);
            if (this == null)
                return;
            if (disposeCallback != null)
                disposeCallback(this.gameObject);
            else
                GameObject.Destroy(this.gameObject);
        }
        //void OnEnable()
        //{
        //    if (destroytm == 0)
        //        destroytm = 3f;
        //    startTm = TimerManager2.getCurrentTime();
        //    StartCoroutine(DelayCallBack());
        //}
        //IEnumerator DelayCallBack()
        //{
        //    yield return new WaitForSeconds(destroytm);
        //    LoggerHelper.Error("timeSpace:"+(TimerManager2.getCurrentTime()-startTm));
        //    if (disposeCallback != null)
        //        disposeCallback(this.gameObject);
        //    else
        //        GameObject.Destroy(this.gameObject);
        //}
    }
}
