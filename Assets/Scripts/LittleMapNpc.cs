using UnityEngine;
using System.Collections;
public enum NPCTYPE
{
    Npc,
    Monster,
    TransferPoint
}
public class LittleMapNpc : MonoBehaviour {


    public NPCTYPE m_Type;
    public string m_NpcName;
}
