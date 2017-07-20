using UnityEngine;

namespace sw.scene.ctrl
{
    public class AnimCullingModeCtrl : StateMachineBehaviour
    {
        public AnimatorCullingMode mode = AnimatorCullingMode.CullUpdateTransforms;
        AnimatorCullingMode mOldMode = AnimatorCullingMode.CullUpdateTransforms;
        public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
        {
            mOldMode = animator.cullingMode;
            animator.cullingMode = mode;
        }
        public override void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
        {
            animator.cullingMode = mOldMode;
        }
    }
}
