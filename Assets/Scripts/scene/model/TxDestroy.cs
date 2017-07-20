
using sw.util;
using System;
using System.Collections;
using UnityEngine;
using UnityEngine.Events;
namespace sw.scene.model
{
    public class TxDestroy:MonoBehaviour
    {
        public float destroytm;
        public UnityAction<GameObject> disposeCallback;
        IEnumerator Start()
        {
            yield return new WaitForSeconds(destroytm);
            if (disposeCallback != null)
                disposeCallback(this.gameObject);
            else
                GameObject.Destroy(this.gameObject);
        }
    }
}
