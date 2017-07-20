using UnityEngine;
using System.Collections;
public class ShakeCamera : MonoBehaviour
{
    public float value_shakeTime = 1.0f;
    public float value_fps = 20.0f;
    public float value_frameTime = 0.03f;
    public float value_shakeDelta = 0.005f;

    private float shakeTime = 0.0f;
    private float fps = 20.0f;
    private float frameTime = 0.0f;
    private float shakeDelta = 0.005f;
    public Camera cam;
    public bool isshakeCamera = false;
    // Use this for initialization
    void Start()
    {
        shakeTime = value_shakeTime;
        fps = value_fps;
        frameTime = value_frameTime;
        shakeDelta = value_shakeDelta;
        //shakeCamera();
    }


    // Update is called once per frame
    void Update()
    {
        if (isshakeCamera)
        {
            if (shakeTime > 0)
            {
                shakeTime -= Time.deltaTime;
                if (shakeTime <= 0)
                {
                    cam.rect = new Rect(0.0f, 0.0f, 1.0f, 1.0f);
                    isshakeCamera = false;
                    shakeTime = value_shakeTime;
                    fps = value_fps;
                    frameTime = value_frameTime;
                    shakeDelta = value_shakeDelta;
                }
                else
                {
                    frameTime += Time.deltaTime;

                    if (frameTime > 1.0 / fps)
                    {
                        frameTime = 0;
                        cam.rect = new Rect(shakeDelta * (-1.0f + 2.0f * Random.value), shakeDelta * (-1.0f + 2.0f * Random.value), 1.0f, 1.0f);
                    }
                }
            }
        }
    }

    public void shakeCamera()
    {
        isshakeCamera = true;
    }
}