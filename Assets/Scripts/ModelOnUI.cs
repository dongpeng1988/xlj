

using UnityEngine;
namespace sw.view
{
    public class ModelOnUI:MonoBehaviour
    {
        public enum RenderType
        {
            FRONT,
            BACK
        }
        public RenderType m_type = RenderType.FRONT;
        Renderer[] _renderers;
        Renderer _self;
        public UIWidget target;
        public UIWidget target2;
        public int RenderQ;
   
        int last;
        void Start()
        {

            Init();
        }
        void Init()
        {
             _renderers = GetComponentsInChildren<Renderer>();
             _self = GetComponent<Renderer>();
        }
        public void OnChildrenChange()
        {
            Init();
        }
        void Update()
        {
           
            if(target != null && target.drawCall != null)
            {
                int queue = target.drawCall.renderQueue + (m_type == RenderType.FRONT ? 1 : -1);
                Renderer rtarget = target.gameObject.GetComponent<Renderer>();
                int sortOrder = 0;
                if (rtarget != null)
                    sortOrder = rtarget.sortingOrder;
                
                if (last != queue)
                {
                    foreach (Renderer r in _renderers)
                    {
                        r.material.renderQueue = queue;
                        r.sortingOrder = sortOrder;
                    }
                    if (_self != null)
                        _self.material.renderQueue = queue;
                    last = queue;
                }

            }
            else if(RenderQ>0)
            {
                if(last  != RenderQ)
                {
                    foreach (Renderer r in _renderers)
                    {
                        r.material.renderQueue = RenderQ;
                    }
                    if (_self != null)
                        _self.material.renderQueue = RenderQ;
                    last = RenderQ;
                }
            }
        }
    }
}
