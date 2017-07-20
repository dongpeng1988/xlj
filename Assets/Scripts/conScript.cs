using UnityEngine;
using System.Collections;
using System;
//using System.Data;
//using MySql.Data.MySqlClient;

public class conScript : MonoBehaviour
{
    public string mystring;
    public GUISkin myskin;//要想显示中文自己加个中文字体进去
    void Start()
    {
        //改成自己的连接字符串
        string connectionString =
           "Server=localhost;" +
           "Database=mysql;" +
           "User ID=root;" +
           "Password=;" +
           "Pooling=false";
        try
        {
//            IDbConnection dbcon;
//            dbcon = new MySqlConnection(connectionString);
//            dbcon.Open();
//            IDbCommand dbcmd = dbcon.CreateCommand();
//
//            //这里改用自己的表
//            string sql = "SELECT datavalue FROM home_config";
//            dbcmd.CommandText = sql;
//            IDataReader reader = dbcmd.ExecuteReader();
//            while (reader.Read())
//            {
//                string datavalue = (string)reader["datavalue"];//datavalue改为自己表的字段
//
//                mystring += datavalue + "\n";
//            }
//            // clean up
//            reader.Close();
//            reader = null;
//            dbcmd.Dispose();
//            dbcmd = null;
//            dbcon.Close();
//            dbcon = null;
        }
        catch (Exception ex)
        {
            mystring = ex.ToString();//出错方便查看
        }
    }
    void OnGUI()
    {
        GUI.skin = myskin;
        GUI.TextArea(new Rect(10, 10, 128, 320), mystring);
    }
}