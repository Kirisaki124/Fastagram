using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Fastagram.App_Code
{
    public class DataAccess
    {
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
            return ExecuteUpdate(sql, para1, para2) ==1;
        }
    }
}