using Fastagram.Code.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Fastagram.Code.Model
{
    public class Comment
    {
        public int Id { get; set; }
        public User User { get; set; }
        public int PostId { get; set; }
        public string Content { get; set; }
        public DateTime DateCreated { get; set; }
        public Comment( int id, int userId, int postid, string content, DateTime dateCreated)
        {
            Id = id;
            User = Manager.GetUserByID(userId);
            PostId = postid;
            Content = content;
            DateCreated = dateCreated;
        }
    }
}