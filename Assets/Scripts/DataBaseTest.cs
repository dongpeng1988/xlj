using UnityEngine;
using System;
using System.Collections;
//using System.Data;

public class DataBaseTest : MonoBehaviour {

string strID = "";
string strName = "";
string strSex = "";
int Index = 1;
// Use this for initialization
void Start () {
}

/*void OnGUI()
{

  if (GUI.Button(new Rect(100,320,100,100),"click Me"))
  {
   foreach(DataRow dr in CMySql.MyObj.Tables[0].Rows)
   {
    if (Index.ToString() == dr["ID"].ToString())
    {
     strID = dr["ID"].ToString();
     strName =  dr["Name"].ToString();
     strSex = dr["Sex"].ToString();
     
     break;
    }
   }   
   Index++;
    if(Index > 5)
   {
    Index = 1;
   }  
   
  }
  GUI.Label(new Rect(320,100,150,70),"DataBaseTest");
  GUI.Label(new Rect(300,210,150,70),strID);
  GUI.Label(new Rect(300,320,150,70),strName);
  GUI.Label(new Rect(300,430,150,70),strSex);
  
}*/
}