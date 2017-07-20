

using UnityEngine;
using UnityEngine.Events;
namespace sw.scene.ctrl
{
    public class SkillState:StateMachineBehaviour
    {
        public int skillIndex;
        public UnityAction<int> onEnter;
        public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
        {
            if (onEnter != null)
            {
                onEnter(skillIndex);
            }
        }
    }
}
