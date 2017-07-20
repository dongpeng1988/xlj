using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class MZ_ChildsDelayPlay : MonoBehaviour
{
    [System.Serializable]
    public struct DelayObj
    {
        public GameObject obj;
        public float delayTime;
    }

    public DelayObj[] delayObjs;

    void OnEnable()
    {
        for (int i = 0; i < delayObjs.Length; i++)
        {
            StartCoroutine(DelayPlay(delayObjs[i]));
        }
    }

    IEnumerator DelayPlay(DelayObj delayObj)
    {
        delayObj.obj.SetActive(false);
        yield return new WaitForSeconds(delayObj.delayTime);
        delayObj.obj.SetActive(true);
    }
}
