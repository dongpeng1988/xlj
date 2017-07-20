

using UnityEngine;
using UnityEngine.Events;
namespace sw.scene.model
{
    public class RoleData:MonoBehaviour
    {
        [SerializeField]
        public SkillInfo[] skills;
        public Transform fabaoBind;
        public Transform weapon1Bind;
        public Transform weapon2Bind;
        public Transform wingBind;
        public Transform hitBind;
        public Transform xpBind;
        public Transform TitleBind;
        public UnityAction<string> onPlayFx;
        public string GetFx(int idx)
        {
            if (skills == null)
                return null;
            for (int i = 0; i < skills.Length; i++)
            {
                if (skills[i].index == idx)
                {
                    return skills[i].fx;
                }
            }
            return null;
        }
        void SkillEnd()
        {

        }
        void OnShake()
        {

        }
        public void OnPlayFx(string stringParameter)
        {
            if (onPlayFx != null)
                onPlayFx(stringParameter);
        }
    }
}
