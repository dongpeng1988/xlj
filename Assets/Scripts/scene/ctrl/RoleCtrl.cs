
using UnityEngine;
using UnityEngine.Events;
namespace sw.scene.ctrl
{
    public  class RoleCtrl:MonoBehaviour
    {
        public UnityAction<int> onPlayFx;
        public UnityAction onStartJump2;
        public UnityAction skillEnd;
        public UnityAction onStartAssault;
        public UnityAction<int> onShake;
        void OnPlayFx(int skillId)
        {
            if (onPlayFx != null)
                onPlayFx(skillId);
        }
        void OnStartJump2()
        {
            if (onStartJump2 != null)
                onStartJump2();
        }
        void SkillEnd()
        {
            if (skillEnd != null)
                skillEnd();
        }
        void OnStartAssault()
        {
            if (onStartAssault != null)
                onStartAssault();
        }
        void OnShake(int type)
        {
            if (onShake != null)
                onShake(type);
        }
    }
}
