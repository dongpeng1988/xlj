

using UnityEngine;
using UnityEngine.Events;
namespace sw.res
{
    public class PoolGameObject:MonoBehaviour
    {
        //bool true is destroyed
        public UnityAction<PoolGameObject,bool> disposeHandler;
        public void Dispose()
        {
            if (disposeHandler != null)
                disposeHandler(this, false);
        }
        void OnDestroy()
        {
            if (disposeHandler != null)
                disposeHandler(this, true);
         
        }
    }
}
