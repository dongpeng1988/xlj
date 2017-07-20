using UnityEngine;
using System.Collections;

public class RoleSelect3D : MonoBehaviour
{
    [System.Serializable]
    public class Root
    {
        public string text;
        public Transform root;
    }

    public Camera mMainCamera;
    public ShakeCamera mShakeCamera;
    public GameObject mBackground;
    public Root[] mRoots;
    public Transform[] mEffectRoots;
}
