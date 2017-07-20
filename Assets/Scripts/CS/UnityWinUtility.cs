using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;
using System;

public class UnityWinUtility 
{
	[DllImport("UnityWinUtility")]
    public static extern void EnableIME(bool bEnable);
	
	[DllImport("UnityWinUtility")]
    public static extern void EnableCustomCursor(bool bEnable);
	
	[DllImport("UnityWinUtility")]
    public static extern void RegistCursor(int nCursorID, string strFilename);

	[DllImport("UnityWinUtility")]
    public static extern void ApplyCursor(int  nCursorID);
}
