using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using sw.game.evt;
using sw.util;

public class CameraCtrl:MonoBehaviour
{
    public const string CAMERA_UPDATED = "camera.updated";
    public enum RotationAxes
    {
        MouseXAndY,
        MouseX,
        MouseY
    }
    public delegate void OnEndCallback();
    public Transform taget;
    public int powtimes = 3;
    public float viewlen = 9f;
    private Vector3 defaultView;
    public float zoomRate = 2f;
    public float minDistance = 5f;
    public float maxDistance = 200f;
    //private CameraMode _mode = CameraMode.ENUM_EDITORMODE;
    public bool gamemode = true;
    public bool bLockYaw = true;
    public bool bLockPicth = true;
    public int picth_min = 3;
    public int picth_max = 720;
    public float picth = 700f;
    public float yaw = -135f;
    public bool bUseDelay = false;
    public float fFollowSpeed = 2f;
    //public CamFollow.RotationAxes axes = CamFollow.RotationAxes.MouseXAndY;
    public float sensitivityX = 15f;
    public float sensitivityY = 15f;
    public float minShakeSpeed = 20f;
    public float maxShakeSpeed = 20f;
    public float minShake = 0.01f;
    public float maxShake = 0.1f;
    public float minShakeTimes = 6f;
    public float maxShakeTimes = 7f;
    public float fMoveSpeed = 100f;
    public float maxShakeDistance = 50f;
    public float normalHei = 1.5f;
    public bool shake = false;
    public float shakeSpeed = 2f;
    public float cShakePos;
    public float shakeTimes = 8f;
    private float cShake;
    private float cShakeSpeed;
    private float cShakeTimes;
    private float targetHeight;
    //private static CamFollow g_inst = null;
    public int rotmouse = 1;
    private int savedmousex;
    private int savedmousey;
    public GameObject box_cam;
    public bool bZooming = false;
    public bool bZoomIn = false;
    //private CamFollow.OnEndCallback onend;
    public bool bPlayingAni = false;
    Camera camera;
    public void Awake()
    {
         
        Debug.Log("初始化摄影机" + this);
    }
    private void Start()
    {
        camera = base.GetComponent<Camera>();
        defaultView = new Vector3(this.viewlen, this.viewlen + 4, this.viewlen);
        //camera.transform.localRotation = Quaternion.Euler(picth, yaw, 0);
    }
    private void OnGUI()
    {
        //if (GUI.Button(new Rect(400, 40, 100, 100), "Play Ani"))
        //{
        //    StartShakeKaiChangBoss(1f, 1f);
        //}
        //if (GUI.Button(new Rect(550, 40, 100, 100), "Recover"))
        //{
        //    PlayCamRecoverAni();
        //}
    }

    //public void SetShakeInfo(float _minShake, float _maxShake, float _minTimes, float _maxTimes, float _minSpeed, float _maxSpeed, float _fMaxDistance)
    //{
    //    this.minShake = _minShake;
    //    this.maxShake = _maxShake;
    //    this.minShakeTimes = _minTimes;
    //    this.maxShakeTimes = _maxTimes;
    //    this.minShakeSpeed = _minSpeed;
    //    this.maxShakeSpeed = _maxSpeed;
    //    this.maxShakeDistance = _fMaxDistance;
    //}
    private int shakeType = 1;//1,2,4,x,y,z
    private float shakeX = 0f;
    private float shakeY = 0f;
    private float shakeZ = 0f;
    //public void StartShake(float distance,int _shakeType)
    //{
    //    shakeType = _shakeType;
    //    float num = distance / this.maxShakeDistance;
    //    if ((double)num <= 1.0)
    //    {
    //        num = Mathf.Clamp(num, 0f, 1f);
    //        num = 1f - num;
    //        this.cShakeSpeed = Mathf.Lerp(this.minShakeSpeed, this.maxShakeSpeed, num);
    //        this.shakeTimes = Mathf.Lerp(this.minShakeTimes, this.maxShakeTimes, num);
    //        this.cShakeTimes = 0f;
    //        this.cShakePos = Mathf.Lerp(this.minShake, this.maxShake, num);
    //        this.shake = true;
    //    }
    //}

    public Vector3 posRange = Vector3.one;
    public float _shakeRate = 0.008f;

    public void StartShakeKaiChangBoss(float ShakeRange, float ShakeTime)
    {
        _curShakeTime = 0f;
        StartCoroutine(KaiChangBossShake(ShakeRange, ShakeTime));
    }

    private float _curShakeTime;
    IEnumerator KaiChangBossShake(float ShakeRange, float ShakeTime)
    {
        float _shakerate = _shakeRate;
        float _shakedistance;
        Vector3 _InitPos = this.transform.localPosition;
        while (_curShakeTime < ShakeTime)
        {
            _curShakeTime += Time.deltaTime;

            _shakedistance = ShakeRange * UnityEngine.Random.Range(-1f, 1f);
            yield return new WaitForSeconds(_shakerate);
            this.transform.localPosition = new Vector3(_InitPos.x + _shakedistance * posRange.x, _InitPos.y + _shakedistance * posRange.y, _InitPos.z + _shakedistance * posRange.z);
        }
        this.transform.localPosition = _InitPos;
    }
    public AnimationCurve anim;
    private float cur_Time;
    private float ly;
    private float c_value;


    public void Shake()
    {
        Keyframe[] ks= new Keyframe[3];
        ks[0] = new Keyframe(0,0,0,0);
        ks[1] = new Keyframe(0.2f,1,0.2f,0.2f);
        ks[2] = new Keyframe(0.4f,0,0,0);
        anim = new AnimationCurve(ks);
        ly = transform.position.y;
        if (!shake)
        {
            bPlayingAni = true;
            shake = true;
        }
    }
    public void Shake(AnimationCurve _anim)
    {
        anim = _anim;
        ly = transform.position.y;
        if (!shake)
        {
            bPlayingAni = true;
            shake = true;
        }
    }

    private void HandleCameraShake()
    {

        if (shake&&anim!=null)
        {
            cur_Time += Time.deltaTime;
            c_value = anim.Evaluate(cur_Time);
            transform.position = new Vector3(transform.position.x, ly + c_value, transform.position.z);
            if (cur_Time >= anim.keys[anim.length - 1].time)
            {
                shake = false;
                bPlayingAni = false;
                cur_Time = 0;
            }
        }
        //this.targetHeight = 0f;
        //if (this.shake)
        //{
        //    this.cShake += this.cShakeSpeed * Time.deltaTime;
        //    if (Mathf.Abs(this.cShake) > this.cShakePos)
        //    {
        //        this.cShakeSpeed *= -1f;
        //        this.cShakeTimes += 1f;
        //        if (this.cShakeTimes >= this.shakeTimes)
        //        {
        //            this.shake = false;
        //        }
        //        if (this.cShake > 0f)
        //        {
        //            this.cShake = this.maxShake;
        //        }
        //        else
        //        {
        //            this.cShake = -this.maxShake;
        //        }
        //    }
        //    this.targetHeight += this.cShake;
        //}
    }

    private Vector3 curpos;
    private Quaternion curRotation;
    //public Vector3 targetPos = new Vector3(-11, 50, -150);
    //public Vector3 targetRotation = new Vector3(90, -90, 0);
    public void PlayCamAni(Vector3 targetPos, Vector3 targetRotation,float duration = 0.01f)
    {
        if (!bPlayingAni)
        {
            StopAllCoroutines();
            bPlayingAni = true;
            curpos = transform.localPosition;
            curRotation = transform.localRotation;
            //EventDelegate.Add(m_tween.onFinished, OnFinishedPlayCam, true);
        }
        TweenPosition.Begin(gameObject, duration, targetPos);
        Quaternion q = new Quaternion();
        q.eulerAngles = targetRotation;
        TweenRotation m_tween = TweenRotation.Begin(gameObject, duration, q);
    }
    //void OnFinishedPlayCam()
    //{
    //    bPlayingAni = true;
    //}
    public void PlayCamRecoverAni(float duration = 0.01f)
    {
        if (bPlayingAni)
        {
            TweenPosition.Begin(gameObject, duration, curpos);
            TweenRotation m_tween = TweenRotation.Begin(gameObject, duration, curRotation);
            EventDelegate.Add(m_tween.onFinished, OnFinishedPlayCamRecover, true);
            //bPlayingAni = false;
        }
    }
    void OnFinishedPlayCamRecover()
    {
        bPlayingAni = false;
    }

    //public bool PlayAni(string aniname, CamFollow.OnEndCallback _onend = null)
    //{
    //    this.StopAni();
    //    this.onend = _onend;
    //    bool result;
    //    if (base.GetComponent<Animation>() == null)
    //    {
    //        Debug.Log("没有动作组件");
    //        result = false;
    //    }
    //    else
    //    {
    //        result = true;
    //        //if (base.animation.get_Item(aniname) == null)
    //        //{
    //        //    Debug.Log("没有动作名称=" + aniname);
    //        //    result = false;
    //        //}
    //        //else
    //        //{
    //        //    this.bPlayingAni = true;
    //        //    base.Invoke("StopAni", base.animation.get_Item(aniname).get_length());
    //        //    base.animation.Play(aniname);
    //        //    result = true;
    //        //}
    //    }
    //    return result;
    //}
    public void StopAni()
    {
        //base.CancelInvoke("StopAni");
        //if (base.GetComponent<Animation>() != null)
        //{
        //    base.GetComponent<Animation>().Stop();
        //}
        //this.bPlayingAni = false;
        //if (this.onend != null)
        //{
        //    this.onend();
        //}
    }
    //半径的平方
    private float radius = 0;
    private Vector3 newPos;
    public void XPskillSwitch(Boolean state,Vector3 endCamPos,Quaternion endCamRot)
    {
        if(state)
        {
            curpos = base.transform.position;
            curRotation = base.transform.rotation;
            bPlayingAni = true;
            if(radius==0)
            {
                float cam2player = Vector3.Distance(taget.transform.position,this.transform.position);
                radius = Mathf.Pow(cam2player, 2) - Mathf.Pow(this.transform.position.y-taget.position.y, 2);
            }
        }
        else
        {
            //newPos.y = this.transform.position.y;
            //newPos.x = taget.position.x+ Mathf.Sqrt(radius / (1 + (Mathf.Pow((endCamPos.z-taget.position.z)/(endCamPos.x-taget.position.x), 2))));
            //newPos.z =taget.position.z+ (endCamPos.z - taget.position.z)*(newPos.x-taget.position.x)/( endCamPos.x-taget.position.x);
            //LoggerHelper.Error("pos:"+newPos);
            //defaultView = newPos - taget.position;
            //Quaternion newQua = Quaternion.LookRotation(taget.transform.position - newPos);
            //base.transform.position = endCamPos;
            //base.transform.rotation = endCamRot;
            //TweenPosition m_tween= TweenPosition.Begin(gameObject, 1, newPos);
            //TweenRotation.Begin(gameObject, 1, newQua);
            //EventDelegate.Add(m_tween.onFinished, OnFinishedPlayCamRecover, true);
            bPlayingAni = false;
        }
    }
    private void LateUpdate()
    {
        this.HandleCameraShake();
        if (!this.bPlayingAni)
        {
            if (!(this.taget == null))
            {
                //if (this.bZooming)
                //{
                //    if (this.bZoomIn)
                //    {
                //        this.viewlen -= Time.deltaTime * this.zoomRate * 10f;
                //        if (this.viewlen < this.minDistance)
                //        {
                //            this.viewlen = this.minDistance;
                //        }
                //    }
                //    else
                //    {
                //        this.viewlen += Time.deltaTime * this.zoomRate * 10f;
                //        if (this.viewlen > this.maxDistance)
                //        {
                //            this.bZooming = false;
                //            this.viewlen = this.maxDistance;
                //        }
                //    }
                //    if (this.gamemode)
                //    {
                //        this.Comp();
                //    }
                //}
                //else
                {
                    
                    if (this.gamemode)
                    {
                        if (Input.GetMouseButton(this.rotmouse))
                        {
                            //if (this.axes == CamFollow.RotationAxes.MouseXAndY)
                            //{
                            //    if (!this.bLockYaw)
                            //    {
                            //        this.yaw += Input.GetAxis("Mouse X") * this.sensitivityX;
                            //    }
                            //    if (!this.bLockPicth)
                            //    {
                            //        this.picth -= Input.GetAxis("Mouse Y") * this.sensitivityY;
                            //    }
                            //}
                        }
                        float num = Vector3.Distance(base.transform.position, this.taget.position);
                        //float axis = Input.GetAxis("Mouse ScrollWheel");
                        //if (axis != 0f)
                        //{
                        //    this.viewlen -= axis * Time.deltaTime * this.zoomRate * Mathf.Max(num, 1f) * Mathf.Sqrt(Mathf.Abs(this.viewlen));
                        //}
                        //this.viewlen = Mathf.Clamp(this.viewlen, this.minDistance, this.maxDistance);
                        this.Comp();
                    }
                }
            }
        }
    }
    public void MoveToTag()
    {
        bool flag = this.bUseDelay;
        this.bUseDelay = false;
        this.Comp();
        this.bUseDelay = flag;
    }
    public void Comp()
    {
        if (this.taget != null)
        {
            Vector3 vector = default(Vector3);
            float num = this.viewlen - this.minDistance;
            float num2 = this.maxDistance - this.minDistance;
            float num3 = num / num2;
            float num4 = Mathf.Cos(Mathf.Pow(num3, (float)this.powtimes));
            this.picth = Mathf.Min(this.picth, (float)this.picth_max);
            this.picth = Mathf.Max(this.picth, (float)this.picth_min);
            float num5 = Mathf.Lerp(0f, this.picth, num3);
            Quaternion quaternion = Quaternion.Euler(num5, this.yaw, 0f);
            Vector3 vector2 = default(Vector3);
            if (this.box_cam)
            {
                float num6 = this.viewlen;
                RaycastHit raycastHit = default(RaycastHit);
                Ray ray = default(Ray);
                ray.origin = this.taget.position - base.transform.forward * 500f;
                ray.direction = base.transform.forward;
                LayerMask layerMask = 1 << LayerMask.NameToLayer("box_cam");
                //if (Physics.Raycast(ray, ref raycastHit, 1000f, layerMask))
                if (Physics.Raycast(ray, out raycastHit, 1000f, layerMask))
                {
                    float num7 = Vector3.Distance(raycastHit.point, this.taget.position) * 0.9f;
                    num6 = Mathf.Min(Mathf.Max(0.01f, num7), this.viewlen);
                    float num8 = Mathf.Max(0f, num6 - this.minDistance);
                    float num9 = this.maxDistance - this.minDistance;
                    float num10 = num8 / num9;
                    float num11 = Mathf.Cos(Mathf.Pow(num10, (float)this.powtimes));
                    vector2 = quaternion * new Vector3(0f, 0f, -num6) + this.taget.position + new Vector3(0f, this.targetHeight + 1.5f, 0f);
                }
                else
                {
                    vector2 = quaternion * new Vector3(0f, 0f, -num6) + this.taget.position;
                }
            }
            else
            {
                //vector2 = quaternion * new Vector3(0f, 0f, -this.viewlen) + this.taget.position + new Vector3(0f, this.targetHeight + this.normalHei * (1f - num3), 0f);
                if((shakeType&1)!=0)
                {
                    shakeX = this.targetHeight;
                }
                if((shakeType&2)!=0)
                {
                    shakeY = this.targetHeight;
                }
                if((shakeType&4)!=0)
                {
                    shakeZ = this.targetHeight;
                }
                vector2 = defaultView + new Vector3(shakeX, shakeY, shakeZ) + this.taget.position;
                //vector2 = new Vector3(this.viewlen + shakeX, this.viewlen + 4 + shakeY, this.viewlen + shakeZ) + this.taget.position;
            }
            if (this.bUseDelay)
            {
                Vector3 position = vector2;
                float num12 = Vector3.Distance(base.transform.position, vector2);
                if (num12 > 0.1f)
                {
                    Vector3 vector3 = vector2 - base.transform.position;
                    position = base.transform.position + vector3.normalized * Mathf.Min(num12, vector3.magnitude * this.fMoveSpeed * Time.deltaTime);
                }
                base.transform.position = position;
            }
            else
            {
                if (comeFrist)
                {
                    base.transform.position = vector2;
                    disVec3 = vector2 - this.taget.position;
                    comeFrist = false;
                }
                if (startAround)
                {
                    transform.RotateAround(taget.transform.position, Vector3.up, aroundSpeed * Time.deltaTime);
                    camPostion = transform.localPosition;
                    disVec3 = camPostion - this.taget.position;
                }
                else
                {
                    base.transform.position = disVec3 + this.taget.position;
                }
            }
        }
    }
    private bool comeFrist = true;
    public bool startAround = false;
    public int aroundSpeed = 10;
    private Vector3 camPostion;
    private Vector3 disVec3;
}

