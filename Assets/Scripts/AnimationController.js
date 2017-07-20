//Animation
public var idleAnimName = "stand";
public var walkAnimName = "walk";
public var runAnimName = "run";
public var readyAniName ="ready";
public var dizzyAniName ="dizzy";
public var deathAnimName = "death";
public var jumpStartName = "jumpstart";
public var jumpName = "jump";
public var jumpEndName = "jumpend";

public var attackname = "attack";
public var shootAdditive : AnimationClip;
public var deathani : AnimationClip;
public var animationComponent : Animation;
private var bQiCheng  = false;
public var qichengdian : Transform;
function Start () {
    animationComponent= this.GetComponent.<Animation>();
	Initialize();

}

public function SetQiCheng(v: boolean)
{
	bQiCheng = v;
	if(v==false)
	{
		transform.localPosition.y = -1.288867;
	}
	else
	{
		
		Idle();
	}
}

function InitNormalAni( aniname  : String) : boolean
{
	 if(animationComponent[aniname]!= null)
     {
        animationComponent[aniname].layer = 1;
        
        return true;
     }
     return false;
}
function Initialize()
{
        if(!GetComponent(Animation)) return;
        
        GetComponent.<Animation>().Stop();//stop any animations that might be set to play automatically
        GetComponent.<Animation>().wrapMode = WrapMode.Loop;//set all animations to loop by default
        
        InitNormalAni(readyAniName);		
        InitNormalAni(walkAnimName);		
        InitNormalAni(runAnimName);	
        InitNormalAni(dizzyAniName);
        InitNormalAni(jumpStartName);
        InitNormalAni(jumpName);
        InitNormalAni(jumpEndName);
        InitNormalAni(this.deathAnimName);
		InitNormalAni(idleAnimName);
		CrossFade(this.idleAnimName);
 
	    animationComponent.SyncLayer(1);
	    
		
}
//Animation Here
//Idle animation
public function Idle () {
	
	if(bQiCheng)
		return;
	
	CrossFade(idleAnimName);
}
public function JumpMiddle()
{
	if(bQiCheng)
		return;
	
	CrossFade(this.jumpName);
}
public function JumpStart()
{
	if(bQiCheng)
		return;
	
 
	CrossFade(this.jumpStartName,WrapMode.Once); 
}
public function JumpEnd()
{
	if(bQiCheng)
		return;
	

	CrossFade(this.jumpEndName);
}

public function Attack()
{
	if(animationComponent!=null)
	{
		if(animationComponent[attackname]!=null)
		{
			animationComponent[attackname].layer = 4;
			animationComponent[attackname].weight = 1;
			animationComponent[attackname].speed = 1;
			animationComponent[attackname].blendMode = AnimationBlendMode.Blend;
			animationComponent[attackname].wrapMode = WrapMode.Once;
			GetComponent.<Animation>().Play(attackname);
		}
		else
		{
			Debug.LogError("没有攻击动作");
		}
	}
	else
	{
		Debug.LogWarning("can't find ani when play attack");
	}

}
public function Update()
{
    if(bQiCheng)
    {
        transform.position  = qichengdian.transform.position;
        transform.rotation  = qichengdian.transform.rotation;
        
    }
    else
    {
    
    }
}

function EndAni()
{
	GetComponent.<Animation>().enabled =false;
}
function Death()
{
	if(bQiCheng)
		return;
		
	if(animationComponent!=null)
	{
		if(animationComponent[this.deathAnimName]!=null)
		{
			animationComponent[deathAnimName].layer = 4;
			animationComponent[deathAnimName].weight = 1;
			animationComponent[deathAnimName].speed = 1;
			animationComponent[deathAnimName].blendMode = AnimationBlendMode.Blend;
			animationComponent[deathAnimName].wrapMode = WrapMode.ClampForever;
			GetComponent.<Animation>().Play(deathAnimName);
		}
		else
		{
			Debug.LogError("没有死亡动作");
		}
	}
	else
	{
		Debug.LogWarning("can't find ani when play death");
	}	
		
		
	
}
//walk animation
function Walk() {
	if(bQiCheng)
		return;
	
	CrossFade(walkAnimName);
}

function CrossFade(name : String, mode :WrapMode)
{
	if(name ==null)
	{
		return;
	}
	
	if(GetComponent.<Animation>()==null)
	{
		return;
	}	
//	if(animation[name]==null)
//	{
//		return;
//	}
	GetComponent.<Animation>().wrapMode = mode;
	GetComponent.<Animation>().CrossFade(name);
}
function CrossFade(name : String)
{
	if(name ==null)
	{
		return;
	}
	
	if(GetComponent.<Animation>()==null)
	{
		return;
	}	
//	if(animation[name]==null)
//	{
//		return;
//	}
	Debug.Log("AnimationName:"+name);
	GetComponent.<Animation>().CrossFade(name);
}


//run animation
function Run() {
	if(bQiCheng)
		return;
	CrossFade(runAnimName);
}

       
//jump animation
function Jump() {
	//CrossFade(jumpAnimName,WrapMode.Once);
}
