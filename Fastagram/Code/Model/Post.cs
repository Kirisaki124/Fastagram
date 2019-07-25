using Fastagram.Code.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Fastagram.Code.Model
{
    public class Post
    {
        public int Id { get; set; }
        public User User { get; }
        public string Image { get; set; }
        public string Content { get; set; }
        public DateTime Date { get; set; }
        public string FriendlyDate => GetPrettyDate(Date);
        public int LikeCount { get; set; }
        public List<Comment> Comments { get; set; }
        public Post(int id, int userId, string image, string content, DateTime date, int likecount, List<Comment> comments)
        {
            Id = id;
            User = Manager.GetUserByID(userId);
            Image = image;
            Content = content;
            Date = date;
            LikeCount = likecount;
            Comments = comments;
        }

        public static string GetPrettyDate(DateTime d)
        {
            // 1.
            // Get time span elapsed since the date.
            TimeSpan s = DateTime.Now.Subtract(d);

            // 2.
            // Get total number of days elapsed.
            int dayDiff = (int)s.TotalDays;

            // 3.
            // Get total number of seconds elapsed.
            int secDiff = (int)s.TotalSeconds;

            // 4.
            // Don't allow out of range values.
            if (dayDiff < 0 || dayDiff >= 31)
            {
                return null;
            }

            // 5.
            // Handle same-day times.
            if (dayDiff == 0)
            {
                // A.
                // Less than one minute ago.
                if (secDiff < 60)
                {
                    return "Just now";
                }
                // B.
                // Less than 2 minutes ago.
                if (secDiff < 120)
                {
                    return "1 minute ago";
                }
                // C.
                // Less than one hour ago.
                if (secDiff < 3600)
                {
                    return string.Format("{0} minutes ago",
                        Math.Floor((double)secDiff / 60));
                }
                // D.
                // Less than 2 hours ago.
                if (secDiff < 7200)
                {
                    return "1 hour ago";
                }
                // E.
                // Less than one day ago.
                if (secDiff < 86400)
                {
                    return string.Format("{0} hours ago",
                        Math.Floor((double)secDiff / 3600));
                }
            }
            // 6.
            // Handle previous days.
            if (dayDiff == 1)
            {
                return "Yesterday";
            }
            if (dayDiff < 7)
            {
                return string.Format("{0} days ago",
                    dayDiff);
            }
            if (dayDiff < 31)
            {
                return string.Format("{0} weeks ago",
                    Math.Ceiling((double)dayDiff / 7));
            }
            return null;
        }
    }
}