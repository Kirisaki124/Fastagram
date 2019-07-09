using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Fastagram.App_Code.Model;

namespace Fastagram.App_Code.Data
{
    public class DataAccess
    {
        public static int MaxPostPerPage { get; set; } = 20;
        static SqlConnection GetConnection()
        {
            string ConnectionString = ConfigurationManager.ConnectionStrings["FastagramDB"].ToString();
            return new SqlConnection(ConnectionString);
        }
        static DataTable ExecuteSelect(string sql, params SqlParameter[] Params)
        {
            SqlCommand command = new SqlCommand(sql, GetConnection());
            command.Parameters.AddRange(Params);
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            DataSet ds = new DataSet();
            adapter.Fill(ds);
            return ds.Tables[0];
        }
        public static int ExecuteUpdate(string sql, params SqlParameter[] Params)
        {
            SqlCommand command = new SqlCommand(sql, GetConnection());
            command.Parameters.AddRange(Params);
            command.Connection.Open();
            int k = command.ExecuteNonQuery();
            command.Connection.Close();
            return k;
        }
        public static bool IsUserValid(string userName, string password)
        {
            string sql = "select * from [User] where Username = @un and Password = @pw";
            SqlParameter para1 = new SqlParameter("@un", SqlDbType.NVarChar);
            para1.Value = userName;
            SqlParameter para2 = new SqlParameter("@pw", SqlDbType.NVarChar);
            para2.Value = password;
            DataTable data = ExecuteSelect(sql, para1, para2);
            return data.Rows.Count == 1;
        }
        public static bool AddUser(string userName, string password)
        {
            string sql = @"insert into [User] (UserName, Password)
                           values(@un, @pw)";
            SqlParameter para1 = new SqlParameter("@un", SqlDbType.NVarChar);
            para1.Value = userName;
            SqlParameter para2 = new SqlParameter("@pw", SqlDbType.NVarChar);
            para2.Value = password;
            return ExecuteUpdate(sql, para1, para2) == 1;
        }
        public static List<Post> GetPostByPage (int page)
        {
            List<Post> posts = new List<Post>();
            string sql = @"select *
                           from (select ROW_NUMBER() over (order by DateCreated) as rownum ,*
                           from Post 
                           )as a
                           where rownum between @min and @max";
            SqlParameter para1 = new SqlParameter("@un", SqlDbType.Int);
            para1.Value = (page - 1) * MaxPostPerPage;
            SqlParameter para2 = new SqlParameter("@pw", SqlDbType.Int);
            para2.Value = page * MaxPostPerPage;

            DataTable dt = ExecuteSelect(sql, para1, para2);

            foreach (DataRow row in dt.Rows)
            {
                int id = Convert.ToInt32(row["PostId"]);
                int userId = Convert.ToInt32(row["UserID"]);
                string image = row["Image"].ToString();
                string content = row["Content"].ToString();
                DateTime date = Convert.ToDateTime(row["DateCreated"]);
                posts.Add(new Post(id, userId, image, content, date));
            }
            return posts;
        }
        public static bool IsExist (string userName)
        {
            string sql = "select * from [User] where UserName = @un";
            SqlParameter para1 = new SqlParameter("@un", SqlDbType.NVarChar);
            para1.Value = userName;
            DataTable data = ExecuteSelect(sql, para1);
            return data.Rows.Count == 1;
        }
        
    }
}