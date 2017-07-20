using UnityEngine;

using System.Linq;

public class LightMapSwitcher : MonoBehaviour
{
    [System.Serializable]
    public struct LightmapsArr
    {
        public Texture2D[] mapFar;
        public string index;
    }
    public LightmapsArr[] lightmapsArr;
    //public Texture2D[] DayNear;
    //private Texture2D[] DayFar;
    //public Texture2D[] NightNear;
    //private Texture2D[] NightFar;

    //private LightmapData[] dayLightMaps;
    //private LightmapData[] nightLightMaps;

    void Start()
    {
        //if ((DayNear.Length != DayFar.Length) || (NightNear.Length != NightFar.Length))
        //{
        //    Debug.Log("In order for LightMapSwitcher to work, the Near and Far LightMap lists must be of equal length");
        //    return;
        //}

        // Sort the Day and Night arrays in numerical order, so you can just blindly drag and drop them into the inspector
        //DayNear = DayNear.OrderBy(t2d => t2d.name, new NaturalSortComparer<string>()).ToArray();
        //DayFar = DayFar.OrderBy(t2d => t2d.name, new NaturalSortComparer<string>()).ToArray();
        //NightNear = NightNear.OrderBy(t2d => t2d.name, new NaturalSortComparer<string>()).ToArray();
        //NightFar = NightFar.OrderBy(t2d => t2d.name, new NaturalSortComparer<string>()).ToArray();

        // Put them in a LightMapData structure
        //dayLightMaps = new LightmapData[DayFar.Length];
        //for (int i = 0; i < DayFar.Length; i++)
        //{
            //dayLightMaps[i] = new LightmapData();
            //dayLightMaps[i].lightmapNear = DayNear[i];
        //    dayLightMaps[i].lightmapFar = DayFar[i];
        //}

        //nightLightMaps = new LightmapData[NightFar.Length];
        //for (int i = 0; i < NightFar.Length; i++)
        //{
            //nightLightMaps[i] = new LightmapData();
            //nightLightMaps[i].lightmapNear = NightNear[i];
        //    nightLightMaps[i].lightmapFar = NightFar[i];
        //}
        int lightmapCnt = lightmapsArr.Length;
        for (int i = 0; i < lightmapCnt; i++)
        {
            LightmapsArr tempData = lightmapsArr[i];
            Texture2D[] mapFar = tempData.mapFar;
            mapFar = mapFar.OrderBy(t2d => t2d.name, new NaturalSortComparer<string>()).ToArray();
        }
    }

    #region Publics
    //public void SetToDay()
    //{
    //    LightmapSettings.lightmaps = dayLightMaps;
    //}

    //public void SetToNight()
    //{
    //    LightmapSettings.lightmaps = nightLightMaps;
    //}
    public void setToIndex(int idx=0)
    {
        Texture2D[] idxLightmapData=lightmapsArr[idx].mapFar;
        int curCount = idxLightmapData.Length;
        LightmapData[] curLightmapData = new LightmapData[curCount];
        for (int i = 0; i < curCount;i++ )
        {
            curLightmapData[i] = new LightmapData();
            curLightmapData[i].lightmapFar = idxLightmapData[i];
        }
        LightmapSettings.lightmaps = curLightmapData;
    }
    #endregion

    #region Debug
    [ContextMenu("Set to Night")]
    void Debug00()
    {
        setToIndex(0);
    }

    [ContextMenu("Set to Day")]
    void Debug01()
    {
        setToIndex(1);
    }
    #endregion
}
