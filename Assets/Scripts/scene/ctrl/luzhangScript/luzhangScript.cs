using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class luzhangScript : MonoBehaviour
{
    particleScript[] particles;
    public BoxCollider boxCollider;
    public int startwidth = 0;

    int mWidth = 0;
    public int width
    {
        get { return mWidth; }
        set
        {
            this.mWidth = value;
            this.Reset(value);
        }
    }

    void Start()
    {
        this.GetAllParticleScript();

        this.mWidth = this.startwidth;
        this.Reset(this.width);
    }

    void Update()
    {
        this.Reset(this.width);
    }
    public void GetAllParticleScript()
    {
        particles = this.GetComponentsInChildren<particleScript>();
    }

    void Reset(int w)
    {
        this.Reset_Collider(w);
        this.Reset_Particle(w);
    }
    void Reset_Collider(int w)
    {
        w = Mathf.Abs(w);
        BoxCollider collider = this.boxCollider;
        if (collider != null)
        {
            Vector3 size = collider.size;
            size.x = w;
            collider.size = size;
        }
    }
    void Reset_Particle(int w)
    {
        if (particles == null)
            return;

        foreach(particleScript p in particles)
        {
            if (p == null)
                continue;
            p.width = w;
        }
    }
}
