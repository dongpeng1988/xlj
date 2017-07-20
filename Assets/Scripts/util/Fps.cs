using UnityEngine;
using System.Collections;

public class Fps : MonoBehaviour
{
    float updateInterval = 0.5f;
    private float accum = 0.0f;
    private float frames = 0;
    private float timeleft;
    private float f_Fps;
    // Use this for initialization
    void Start()
    {
        timeleft = updateInterval;
    }
    void OnGUI()
    {
        GUI.Label(new Rect(0, 150, 200, 200), "FPS:" + f_Fps.ToString("f2"));
    }
    // Update is called once per frame
    void Update()
    {
        timeleft -= Time.deltaTime;
        accum += Time.timeScale / Time.deltaTime;
        ++frames;

        if (timeleft <= 0.0)
        {
            f_Fps = accum / frames;
            timeleft = updateInterval;
            accum = 0.0f;
            frames = 0;
        }
    }
}