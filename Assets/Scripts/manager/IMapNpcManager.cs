

using sw.scene.ctrl;
using sw.scene.model;
using sw.ui.model;
using UnityEngine;
namespace sw.manager
{
    public interface IMapNpcManager
    {
        void ShowSkillFx(RoleCtrlDemo target, string roleName, Vector3 pos);
        void Preload(string fxname,Vector3 pos,string uniqueId);
#if UNITY_EDITOR
        void Preload2(MapNpc npc, Vector3 pos);
#endif
    }
}
