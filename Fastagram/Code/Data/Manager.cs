using Fastagram.Code.Model;
using System;
using System.Collections.Generic;

namespace Fastagram.Code.Data
{
    public class Manager
    {
        public static bool IsUserValid(string userName, string password)
        {
            return DataAccess.IsUserValid(userName, password);
        }
        public static bool AddUser(string userName, string password)
        {
            return DataAccess.AddUser(userName, password);
        }
        public static bool IsExist(string userName)
        {
            return DataAccess.IsExist(userName);
        }
        public static User GetUserByName(string userName)
        {
            return DataAccess.GetUserByName(userName);
        }
        public static List<Post> GetPostByPage (int page)
        {
            return DataAccess.GetPostByPage(page);
        }
        public static List<Post> GetPostByUser (int userID, int page)
        {
            return DataAccess.GetPostByUser(userID, page);
        }
        public static bool ToggleLike (int postId, int userId)
        {
            return DataAccess.ToggleLike(postId, userId);
        }
        public static bool AddComment(int userId, int postId, string comment)
        {
            return DataAccess.AddComment(userId, postId, comment);
        }
        public static bool AddPost(int userId, string image, string content)
        {
            return DataAccess.AddPost(userId, image, content);
        }
        public static List<Post> SearchPost (string content)
        {
            return DataAccess.SearchPost(content);
        }
        public static bool UpdatePost(int postId, string content, string image)
        {
            return DataAccess.UpdatePost(postId, content, image);
        }
        public static User GetUserByID(int userId)
        {
            return DataAccess.GetUserByID(userId);
        }
        public static bool DeletePostById(int postId)
        {
            return DataAccess.DelPostById(postId);
        }
        public static bool ChangeAvatar(string avaLink, int userId)
        {
            return DataAccess.ChangeAvatar(avaLink, userId);
        }
        public static Post GetPostById(string postId)
        {
            return DataAccess.GetPostByID(postId);
        }

    }
}