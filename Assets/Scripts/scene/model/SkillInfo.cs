

using UnityEngine;
namespace sw.scene.model
{
    [System.Serializable]
    public class SkillInfo
    {
        public int index;
        public Transform bind;
        public string fx;
        public Vector3 offset =Vector3.zero;
        public Vector3 rot = Vector3.one;
        public bool detach;
        public uint skillId;
        // public float delay;
    }
}
