

using sw.scene.ctrl;
using sw.scene.model;
namespace sw.manager
{
    public interface IFxManager
    {
        void ShowSkillFx(RoleCtrlDemo target, SkillInfo info);
        void Preload(string fxname);
    }
}
