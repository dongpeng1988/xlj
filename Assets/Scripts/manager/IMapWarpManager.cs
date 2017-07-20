

using sw.scene.ctrl;
using sw.scene.model;
using UnityEngine;
namespace sw.manager
{
    public interface IMapWarpManager
    {
        void ShowSkillFx(RoleCtrlDemo target, string roleName, Vector3 pos);
        void Preload(string fxname, Vector3 pos, string uniqueId);
    }
}
