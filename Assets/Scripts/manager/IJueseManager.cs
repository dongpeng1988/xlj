

using sw.scene.ctrl;
using sw.scene.model;
using UnityEngine;
namespace sw.manager
{
    public interface IjueseManager
    {
        void ShowModel(RoleCtrlDemo target, string roleName);
        void Preload(string fxname);
        void preloadPrepare(string name);
        void disposeCallBack(GameObject obj);
    }
}
