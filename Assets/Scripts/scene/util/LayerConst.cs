 

using UnityEngine;
namespace sw.scene.util
{
    public static class LayerConst
    {
        public static int LAYER_GROUND = LayerMask.NameToLayer("ground");
        public static int LAYER_TIMEMESH = 15;
        public static LayerMask MASK_GROUND = 1 << LAYER_GROUND;
        public static LayerMask MASK_TILEMESH = 1 << LAYER_TIMEMESH;

    }
}
