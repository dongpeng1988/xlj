using UnityEngine;
using System.Collections;
using System;
//using System.Data;
//using MySql.Data.MySqlClient;

public class conScript : MonoBehaviour
{
    public string mystring;
    public GUISkin myskin;//Ҫ����ʾ�����Լ��Ӹ����������ȥ
    void Start()
    {
        //�ĳ��Լ��������ַ���
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
//            //��������Լ��ı�
//            string sql = "SELECT datavalue FROM home_config";
//            dbcmd.CommandText = sql;
//            IDataReader reader = dbcmd.ExecuteReader();
//            while (reader.Read())
//            {
//                string datavalue = (string)reader["datavalue"];//datavalue��Ϊ�Լ�����ֶ�
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
            mystring = ex.ToString();//������鿴
        }
    }
    void OnGUI()
    {
        GUI.skin = myskin;
        GUI.TextArea(new Rect(10, 10, 128, 320), mystring);
    }
}