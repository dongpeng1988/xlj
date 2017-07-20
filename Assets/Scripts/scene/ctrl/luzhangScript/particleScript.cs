using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class particleScript : MonoBehaviour
{
    public enum Type
    {
        None = 0,
        RenderMode_LengthScale = 1,
        Shape_BoxX = 2,
    }
    public Type type = Type.None;
    public int startwidth = 0;

    int mWidth = 0;
    public int width
    {
        get{return mWidth;}
        set
        {
            this.mWidth = value;
            this.Reset_t1(value);
        }
    }

    ParticleSystem mParticleSystem;
    ParticleSystem particleSystem
    {
        get
        {
            if (mParticleSystem == null)
            {
                mParticleSystem = this.GetComponent<ParticleSystem>();
            }
            return mParticleSystem;
        }
    }
    ParticleSystemRenderer mParticleSystemRenderer;
    ParticleSystemRenderer particleSystemRenderer
    {
        get
        {
            if (mParticleSystemRenderer == null)
            {
                mParticleSystemRenderer = this.GetComponent<ParticleSystemRenderer>();
            }
            return mParticleSystemRenderer;
        }
    }

    void Start()
    {
        this.mWidth = this.startwidth;
        this.Reset(this.width);
    }

    void Update()
    {
        this.Reset(this.width);
    }

    void Reset(int w)
    {
        Reset_t1(w);
        Reset_t2(w);
    }

    int mT1_width = -1;
    void Reset_t1(int w)
    {
        if (this.type != Type.RenderMode_LengthScale)
            return;

        w = Mathf.Abs(w);
        if (w == mT1_width)
            return;
        mT1_width = w;

        ParticleSystem ps = this.particleSystem;
        ParticleSystemRenderer psrenderer = this.particleSystemRenderer;
        if (ps == null || psrenderer == null)
        {
            return;
        }

        psrenderer.lengthScale = w / ps.startSize;

        Vector3 pos = ps.transform.localPosition;
        pos.x = -w / 2;
        ps.transform.localPosition = pos;
    }

    Dictionary<uint, bool> mParticles = new Dictionary<uint, bool>();
    float p1_lasttime = 0f;
    const float T2_WAIT_TIME = 1f;
    bool CheckParticles(ParticleSystem.Particle particle)
    {
        uint particleval = particle.randomSeed;
        if (mParticles.ContainsKey(particleval))
        {
            return false;
        }
        mParticles[particleval] = true;
        return true;
    }
    void RemoveOldParticle(ParticleSystem.Particle[] particles)
    {
        mParticles.Clear();
        foreach (ParticleSystem.Particle p in particles)
        {
            mParticles[p.randomSeed] = true;
        }
    }
    void Reset_t2(int w)
    {
        if (this.type != Type.Shape_BoxX)
            return;

        float time = Time.time;
        if (time - p1_lasttime < T2_WAIT_TIME)
            return;
        p1_lasttime = time;

        w = Mathf.Abs(w);

        ParticleSystem ps = this.particleSystem;
        if (ps == null)
            return;

        ParticleSystem.Particle[] particles = new ParticleSystem.Particle[ps.maxParticles];
        int b = ps.GetParticles(particles);

        float halfwidth = w / 2f;
        for (int i = 0; i < b; i++)
        {
            if (false == CheckParticles(particles[i]))
                continue;

            Vector3 pos = particles[i].position;
            pos.x = Random.Range(-halfwidth, halfwidth);
            particles[i].position = pos;

            //Debug.LogError("Reset Particle " + particles[i].randomSeed);
        }
        ps.SetParticles(particles, b);
        RemoveOldParticle(particles);
    }
}
