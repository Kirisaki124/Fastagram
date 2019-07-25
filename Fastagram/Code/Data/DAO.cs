using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Fastagram.Code.Model;

namespace Fastagram.Code.Data
{
    public class DataAccess
    {
        private static int MaxPostPerPage = 2;
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
            foreach (SqlParameter p in Params)
            {
            }
            command.Parameters.Clear();
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
        public static List<Post> GetPostByPage(int page)
        {
            List<Post> posts = new List<Post>();
            string sql = @"select *
                           from (select ROW_NUMBER() over (order by DateCreated desc) as rownum ,*
                           from Post 
                           )as a
                           where rownum between @min and @max";
            SqlParameter para1 = new SqlParameter("@min", SqlDbType.Int);
            para1.Value = (page - 1) * MaxPostPerPage + 1;
            SqlParameter para2 = new SqlParameter("@max", SqlDbType.Int);
            para2.Value = page * MaxPostPerPage;

            DataTable dt = ExecuteSelect(sql, para1, para2);

            foreach (DataRow row in dt.Rows)
            {
                int id = Convert.ToInt32(row["PostId"]);
                int userId = Convert.ToInt32(row["UserID"]);
                int likeCount = GetLikeByPost(id);
                List<Comment> comments = GetCommentByPost(id);
                string image = row["Image"].ToString();
                string content = row["Content"].ToString();
                DateTime date = Convert.ToDateTime(row["DateCreated"]);
                posts.Add(new Post(id, userId, image, content, date, likeCount, comments));
            }
            return posts;
        }
        public static bool IsExist(string userName)
        {
            string sql = "select * from [User] where UserName = @un";
            SqlParameter para1 = new SqlParameter("@un", SqlDbType.NVarChar);
            para1.Value = userName;
            DataTable data = ExecuteSelect(sql, para1);
            return data.Rows.Count == 1;
        }
        public static User GetUserByName(string userName)
        {
            string sql = "select * from [User] where UserName = @un";
            SqlParameter para1 = new SqlParameter("@un", SqlDbType.NVarChar);
            para1.Value = userName;
            DataTable data = ExecuteSelect(sql, para1);
            foreach (DataRow row in data.Rows)
            {
                int id = Convert.ToInt32(row["UserId"]);
                string name = row["UserName"].ToString();
                string avatar = row["Avatar"].ToString();
                return new User(id, name, avatar);
            }
            return null;
        }
        public static List<Post> GetPostByUser(int userId, int page)
        {
            List<Post> posts = new List<Post>();

            string sql = @"select *
                           from (select ROW_NUMBER() over (order by DateCreated) as rownum ,*
                           from Post 
                           )as a
                           where UserID = @uid and rownum between @min and @max";
            SqlParameter para1 = new SqlParameter("@min", SqlDbType.Int);
            para1.Value = (page - 1) * MaxPostPerPage;
            SqlParameter para2 = new SqlParameter("@max", SqlDbType.Int);
            para2.Value = page * MaxPostPerPage;
            SqlParameter para3 = new SqlParameter("@uid", SqlDbType.Int);
            para3.Value = userId;

            DataTable dt = ExecuteSelect(sql, para1, para2, para3);

            foreach (DataRow row in dt.Rows)
            {
                int id = Convert.ToInt32(row["PostId"]);
                int likeCount = GetLikeByPost(id);
                List<Comment> comments = GetCommentByPost(id);
                string image = row["Image"].ToString();
                string content = row["Content"].ToString();
                DateTime date = Convert.ToDateTime(row["DateCreated"]);
                posts.Add(new Post(id, userId, image, content, date, likeCount, comments));
            }
            return posts;
        }
        private static int GetLikeByPost(int postId)
        {
            string sql = @"select count(*) [Like Count]
                            from [Like]
                            where PostID = @pid";
            SqlParameter para1 = new SqlParameter("@pid", SqlDbType.Int);
            para1.Value = postId;

            DataTable dt = ExecuteSelect(sql, para1);

            return Convert.ToInt32(dt.Rows[0]["Like Count"]);

        }
        private static List<Comment> GetCommentByPost(int postId) //getcomment when get post
        {
            List<Comment> comments = new List<Comment>();
            string sql = @"select * from Comment where PostID = @pid";
            SqlParameter para1 = new SqlParameter("@pid", SqlDbType.Int);
            para1.Value = postId;

            DataTable dt = ExecuteSelect(sql, para1);

            foreach (DataRow row in dt.Rows)
            {
                int id = Convert.ToInt32(row["CommentID"]);
                int userId = Convert.ToInt32(row["UserID"]);
                string content = row["content"].ToString();
                DateTime dateCreated = Convert.ToDateTime(row["DateCreated"]);
                comments.Add(new Comment(id, userId, postId, content, dateCreated));
            }
            return comments;
        }
        public static bool ToggleLike(int postId, int userId)
        {
            string sql = "select * from [like] where PostID = @pid and UserID = @uid";
            SqlParameter para1 = new SqlParameter("@pid", SqlDbType.Int);
            para1.Value = postId;
            SqlParameter para2 = new SqlParameter("@uid", SqlDbType.Int);
            para2.Value = userId;

            DataTable dt = ExecuteSelect(sql, para1, para2);
            

            if (dt.Rows.Count == 1)
            {
                sql = "delete from [like] where PostID =@pid and UserID =@uid ";
                return ExecuteUpdate(sql, para1, para2) == 1;
            }
            else if (dt.Rows.Count == 0)
            {
                sql = @"insert into [Like]
                        values (@pid,@uid)";
                return ExecuteUpdate(sql, para1, para2) == 1;
            }
            return false;
        }
        public static bool AddComment(int userId, int postId, string comment)
        {
            string sql = @"insert into Comment (PostID,UserID,Content,DateCreated)
                            values (@pid, @uid, @com, GETDATE())";
            SqlParameter para1 = new SqlParameter("@pid", SqlDbType.Int);
            para1.Value = postId;
            SqlParameter para2 = new SqlParameter("@uid", SqlDbType.Int);
            para2.Value = userId;
            SqlParameter para3 = new SqlParameter("@com", SqlDbType.NVarChar);
            para3.Value = comment;

            return ExecuteUpdate(sql, para1, para2, para3) == 1;
        }
        public static bool AddPost(int userId, string image, string content)
        {
            string sql = @"insert into Post (UserID, Image, Content, DateCreated)
                            values (@uid, @img, @con, GETDATE())";
            SqlParameter para1 = new SqlParameter("@uid", SqlDbType.Int);
            para1.Value = userId;
            SqlParameter para2 = new SqlParameter("@img", SqlDbType.NVarChar);
            para2.Value = image;
            SqlParameter para3 = new SqlParameter("@con", SqlDbType.NVarChar);
            para3.Value = content;

            return ExecuteUpdate(sql, para1, para2, para3) == 1;
        }
        public static List<Post> SearchPost(string content)
        {
            List<Post> posts = new List<Post>();
            string sql = @"select *
                        from Post
                        where Content like @con ";
            SqlParameter para1 = new SqlParameter("@con", SqlDbType.NVarChar);
            para1.Value = content;

            DataTable dt = ExecuteSelect(sql, para1);

            foreach (DataRow row in dt.Rows)
            {
                int id = Convert.ToInt32(row["PostID"]);
                int userId = Convert.ToInt32(row["UserID"]);
                int likeCount = GetLikeByPost(id);
                List<Comment> comments = GetCommentByPost(id);
                string image = row["Image"].ToString();
                string con = row["Content"].ToString();
                DateTime date = Convert.ToDateTime(row["DateCreated"]);
                posts.Add(new Post(id, userId, image, con, date, likeCount, comments));
            }
            return posts;
        }
        public static Post GetPostByID(string postId)
        {
            string sql = @"select *
                            from Post
                            where PostID =  @pid ";
            SqlParameter para1 = new SqlParameter("@pid", SqlDbType.Int);
            para1.Value = postId;

            DataTable dt = ExecuteSelect(sql, para1);

            foreach (DataRow row in dt.Rows)
            {
                int id = Convert.ToInt32(row["PostID"]);
                int userId = Convert.ToInt32(row["UserID"]);
                int likeCount = GetLikeByPost(id);
                List<Comment> comments = GetCommentByPost(id);
                string image = row["Image"].ToString();
                string content = row["Content"].ToString();
                DateTime date = Convert.ToDateTime(row["DateCreated"]);
                return new Post(id, userId, image, content, date, likeCount, comments);
            }
            return null;
        }
        public static bool UpdatePost (int postID, string content, string image)
        {
            string sql = @"update Post
                            set Content = @con, [Image] = @img
                            where PostID = @pid";
            SqlParameter para1 = new SqlParameter("@pid", SqlDbType.Int);
            para1.Value = postID;
            SqlParameter para2 = new SqlParameter("@img", SqlDbType.NVarChar);
            para2.Value = image;
            SqlParameter para3 = new SqlParameter("@con", SqlDbType.NVarChar);
            para3.Value = content;

            return ExecuteUpdate(sql, para1, para2, para3) == 1;
        }
        public static User GetUserByID (int userId)
        {
            string sql = " select * from [User] where UserId = @uid";
            SqlParameter para1 = new SqlParameter("@uid", SqlDbType.Int);
            para1.Value = userId;
            DataTable data = ExecuteSelect(sql, para1);
            foreach (DataRow row in data.Rows)
            {
                int id = Convert.ToInt32(row["UserId"]);
                string name = row["UserName"].ToString();
                string avatar = row["Avatar"].ToString();
                return new User(id, name, avatar);
            }
            return null;
        }
        public static bool DelPostById(int postId)
        {
            string sql = "delete from Post where PostID = @pid";
            SqlParameter para1 = new SqlParameter("@pid", SqlDbType.Int);
            para1.Value = postId;
            return ExecuteUpdate(sql, para1) == 1;
        }
        public static bool ChangeAvatar(string avaLink, int userId)
        {
            string sql = @"update [User]
                        set Avatar = @ava
                        where UserId = @uid ";
            SqlParameter para1 = new SqlParameter("@uid", SqlDbType.Int);
            para1.Value = userId;
            SqlParameter para2 = new SqlParameter("@ava", SqlDbType.NVarChar);
            para2.Value = avaLink;

            return ExecuteUpdate(sql, para1, para2) == 1;
        }
    }
}