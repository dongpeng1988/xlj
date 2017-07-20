using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;
using System;

public class TSetCursorHandle 
{
	[DllImport("vtest",CallingConvention=CallingConvention.Cdecl)]
    public static extern int TSetCursor(string strFilename);
	
	[DllImport("vtest",CallingConvention=CallingConvention.Cdecl)]
    public static extern int Add(int a,int b);
	
}
