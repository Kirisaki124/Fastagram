using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Fastagram.App_Code.Model
{
    public class Post
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public string Image { get; set; }
        public string Content { get; set; }
        public DateTime Date { get; set; }
        public int LikeCount { get; set; }
        public List<Comment> Comments { get; set; }
        public Post(int id, int userid, string image, string content, DateTime date, int likecount, List<Comment> comments)
        {
            Id = id;
            UserId = userid;
            Image = image;
            Content = content;
            Date = date;
        }
    }
}