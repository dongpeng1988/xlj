namespace sw.util
{

    using sw.game;
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.IO;
    using System.Net;
    using System.Reflection;
    using System.Runtime.InteropServices;
    using System.Text;
    using System.Threading;
    using UnityEngine;

    public class LoggerHelper
    {
        public static sw.util.LogLevel CurrentLogLevels = (sw.util.LogLevel.CRITICAL | sw.util.LogLevel.EXCEPT | sw.util.LogLevel.ERROR | sw.util.LogLevel.WARNING | sw.util.LogLevel.INFO | sw.util.LogLevel.DEBUG);
        //public static sw.util.LogLevel CurrentLogLevels = (sw.util.LogLevel.CRITICAL | sw.util.LogLevel.EXCEPT | sw.util.LogLevel.ERROR | sw.util.LogLevel.WARNING | sw.util.LogLevel.INFO );
        public static string DebugFilterStr = string.Empty;
        private static ulong index = 0L;
        private static sw.util.LogWriter m_logWriter = new sw.util.LogWriter();
        private const bool SHOW_STACK = true;
        static Queue<string> postErrors;
        public static void Dispose()
        {
            if (postErrThread != null)
                postErrThread.Abort();
            postErrThread = null;
        }
        static Thread postErrThread;
        static LoggerHelper()
        {
            Application.RegisterLogCallback(new Application.LogCallback(LoggerHelper.ProcessExceptionReport));
            
        }
        public static string ContextInfo="";
        public static string userid,appver,ptid;
        public static void StartPostError()
        {
            postErrors = new Queue<string>();
            postErrThread = new Thread(new ThreadStart(PostError));
            postErrThread.Start();
        }
        public static string PostWebRequest(string postUrl, string paramData, Encoding dataEncode)
        {
            string ret = string.Empty;
            try
            {
                byte[] byteArray = dataEncode.GetBytes(paramData); //转化
                HttpWebRequest webReq = (HttpWebRequest)WebRequest.Create(new Uri(postUrl));
                webReq.Method = "POST";
                webReq.ContentType = "application/x-www-form-urlencoded";
                webReq.Timeout = 600000;
                webReq.ContentLength = byteArray.Length;
                Stream newStream = webReq.GetRequestStream();
                newStream.Write(byteArray, 0, byteArray.Length);//写入参数
                newStream.Close();
                HttpWebResponse response = (HttpWebResponse)webReq.GetResponse();
                StreamReader sr = new StreamReader(response.GetResponseStream(), Encoding.Default);
                ret = sr.ReadToEnd();
                sr.Close();
                response.Close();
                newStream.Close();
            }
            catch (Exception ex)
            {
                //Log("post error log error:"+ex.Message, sw.util.LogLevel.CRITICAL, true);
            }
            return ret;
        }
        public static string reportUrl = "http://192.168.1.11:88/int_error_inside.php";
        static void PostError()
        {
             
            while(postErrors !=null)
            {
                string msg=null;
                lock (postErrors)
                {
                      if (postErrors.Count > 0)
                    {
                        msg = postErrors.Dequeue();                        
                    }
                }
                string appver = "";

                if (msg == null)
                    Thread.Sleep(50);
                else
                    PostWebRequest(reportUrl, new StringBuilder().Append("ptid=").Append(ptid).Append("&msg=").Append(WWW.EscapeURL(ContextInfo + "\n")).Append(WWW.EscapeURL(msg)).Append("&tp=0&appVer=").Append(appver).
                        Append("&device=").Append(SystemInfo.deviceModel)
                        .Append(";o:").Append(SystemInfo.operatingSystem)
                        .Append(";g:").Append(SystemInfo.graphicsDeviceName)
                        .Append(";m:").Append(SystemInfo.systemMemorySize).Append("&userid=").Append(userid).ToString(), Encoding.UTF8);
                
            }
           
        }
        public static void Critical(object message, bool isShowStack = true)
        {
            if (sw.util.LogLevel.CRITICAL == (CurrentLogLevels & sw.util.LogLevel.CRITICAL))
            {
                string msg = string.Concat(new object[] { " [CRITICAL]: ", message, '\n', isShowStack ? GetStacksInfo() : "" });
                Log(msg, sw.util.LogLevel.CRITICAL, true);
                if (postErrors != null)
                {
                    lock (postErrors)
                    {
                        postErrors.Enqueue(msg);
                    }
                }
            }
        }

        public static void Debug(object message, bool isShowStack = true, int user = 0)
        {
            if (!(DebugFilterStr != "") && (sw.util.LogLevel.DEBUG == (CurrentLogLevels & sw.util.LogLevel.DEBUG)))
            {
                object[] objArray = new object[5];
                objArray[0] = " [DEBUG]: ";
                objArray[1] = isShowStack ? GetStackInfo() : "";
                objArray[2] = message;
                objArray[3] = " Index = ";
                index += (ulong) 1L;
                objArray[4] = index;
                Log(string.Concat(objArray), sw.util.LogLevel.DEBUG, true);
            }
        }

        public static void Debug(string filter, object message, bool isShowStack = true)
        {
           
            if ((!(DebugFilterStr != "") || !(DebugFilterStr != filter)) && (sw.util.LogLevel.DEBUG == (CurrentLogLevels & sw.util.LogLevel.DEBUG)))
            {
              
                Log(" [DEBUG]: " + (isShowStack ? GetStackInfo() : "") + message, sw.util.LogLevel.DEBUG, true);
              
            }
        }

        public static void Error(object message, bool isShowStack = true)
        {
            if (sw.util.LogLevel.ERROR == (CurrentLogLevels & sw.util.LogLevel.ERROR))
            {
                string msg = string.Concat(new object[] { " [ERROR]: ", message, '\n', isShowStack ? GetStacksInfo() : "" });
                Log(msg, sw.util.LogLevel.ERROR, true);
                 if(postErrors != null)
                {
                    lock(postErrors)
                    {
                        postErrors.Enqueue(msg);
                    }
                }
            }
           
        }

        public static void Except(Exception ex, object message  )
        {
            if (sw.util.LogLevel.EXCEPT == (CurrentLogLevels & sw.util.LogLevel.EXCEPT))
            {
                Exception innerException = ex;
                while (innerException.InnerException != null)
                {
                    innerException = innerException.InnerException;
                }
                Log(" [EXCEPT]: " + ((message == null) ? "" : (message + "\n")) + ex.Message + innerException.StackTrace, sw.util.LogLevel.CRITICAL, true);
            }
        }

        private static string GetStackInfo()
        {
           
            StackTrace trace = new StackTrace();
            if (trace.GetFrame(2) == null)
            {
                //UnityEngine.Debug.Log(" GetStackInfo frame is null:" + trace.GetFrame(0) + "," + trace.GetFrame(1) + "," + trace.GetFrame(2));
                return string.Empty;
            }

            MethodBase method = trace.GetFrame(2).GetMethod();
           
            return string.Format("{0}(): ", method.Name);
        }

        private static string GetStacksInfo()
        {
            StringBuilder builder = new StringBuilder();
            StackFrame[] frames = new StackTrace().GetFrames();
            for (int i = 2; i < frames.Length; i++)
            {
                builder.AppendLine(frames[i].ToString());
            }
            return builder.ToString();
        }

        public static void Info(object message, bool isShowStack = true)
        {
            if (sw.util.LogLevel.INFO == (CurrentLogLevels & sw.util.LogLevel.INFO))
            {
                Log(" [INFO]: " + (isShowStack ? GetStackInfo() : "") + message, sw.util.LogLevel.INFO, true);
            }
        }
        public static Action<string, LogLevel> OnLog;
        public static Action<string, LogLevel> testDebugLog;

        private static void Log(string message, sw.util.LogLevel level, bool writeEditorLog = true)
        {
            string msg = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss,fff") + message;
            m_logWriter.WriteLog(msg, level, writeEditorLog);
            if (OnLog != null)
                OnLog(msg, level);
            if (testDebugLog != null)//测试脚本记录错误日志
                testDebugLog(msg,level);
			//UnityEngine.Debug.Log(message);
            //Messenger.Broadcast<string>(CommonEvent.SHOW_STATUS, message);
        
        }
        public static string GetInfo()
        {
            return m_logWriter.LogPath + "," + m_logWriter.error;
        }
        private static void ProcessExceptionReport(string message, string stackTrace, LogType type)
        {
            sw.util.LogLevel dEBUG = sw.util.LogLevel.DEBUG;
            switch (type)
            {
                case LogType.Error:
                    dEBUG = sw.util.LogLevel.ERROR;
                    break;

                case LogType.Assert:
                    dEBUG = sw.util.LogLevel.DEBUG;
                    break;

                case LogType.Warning:
                    dEBUG = sw.util.LogLevel.WARNING;
                    break;

                case LogType.Log:
                    dEBUG = sw.util.LogLevel.DEBUG;
                    return;
                    break;

                case LogType.Exception:
                    dEBUG = sw.util.LogLevel.EXCEPT;
                    break;
            }
            if (dEBUG == (CurrentLogLevels & dEBUG))
            {
                string msg = string.Concat(new object[] { " [SYS_", dEBUG, "]: ", message, '\n', stackTrace });
                Log(msg, dEBUG, false);
                if(postErrors != null && dEBUG == LogLevel.ERROR || dEBUG == LogLevel.EXCEPT)
                {
                    
                        lock (postErrors)
                        {
                            postErrors.Enqueue(msg);
                        }
                     
                }
            }
        }

        public static void Release()
        {
            m_logWriter.Release();
        }

        public static void UploadLogFile()
        {
            m_logWriter.UploadTodayLog();
        }

        public static void Warning(object message, bool isShowStack = true)
        {
            if (sw.util.LogLevel.WARNING == (CurrentLogLevels & sw.util.LogLevel.WARNING))
            {
                Log(" [WARNING]: " + (isShowStack ? GetStackInfo() : "") + message, sw.util.LogLevel.WARNING, true);
            }
        }

        public static sw.util.LogWriter LogWriter
        {
            get
            {
                return m_logWriter;
            }
        }
        static Queue<string> postReportData;
        static Thread postReportDataThread;
       // public static string reportDataUrl = "http://182.254.229.168/syinterface/report3.php";
        public static void StartPostReportData()
        {
            postReportData = new Queue<string>();
            postReportDataThread = new Thread(new ThreadStart(PostReportData));
            postReportDataThread.Start();
        }
        static void PostReportData()
        {   
            //while (postReportData != null)
            //{
            //    string msg = null;
            //    lock (postReportData)
            //    {
            //        if (postReportData.Count > 0)
            //        {
            //            msg = postReportData.Dequeue();
            //        }
            //    }
            //    if (msg == null)
            //        Thread.Sleep(50);
            //    else
            //        PostWebRequest(GameConfig.srvListUrl+"/report3.php", msg, Encoding.UTF8);
            //}
        }
        public static void reportData(string message)
        {
            if (postReportData != null)
            {
                lock (postReportData)
                {
                    postReportData.Enqueue(message.ToString());
                }
            }
        }
    }
}

