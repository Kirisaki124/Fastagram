using Fastagram.Code.Data;
using Fastagram.Code.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fastagram
{
    public partial class Home : System.Web.UI.Page
    {
        public List<Post> listPost = Manager.GetPostByPage(1);
        //public List<Comment> comments = Manager;
        public string imagePath = ConfigurationManager.ConnectionStrings["ImagePath"].ToString() + "/";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["user"] == null)
                {
                    Response.Redirect("login");
                }

                if (Request.QueryString["signout"] != null && Request.QueryString["signout"] == "true")
                {
                    Session.Remove("user");
                    if (Request.Cookies["remember"] != null)
                    {
                        Request.Cookies["remember"].Expires = DateTime.Now.AddDays(-1);
                    }
                    Response.Redirect("login");
                }
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            string path = Server.MapPath("~/Images"); //Path
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path); //Create directory if it doesn't exist
            }

            string extension = Path.GetExtension(fuImage.FileName);
            DateTime dateCreated = DateTime.Now;

            if (fuImage.HasFile)
            {
                try
                {
                              // userId                      image name                                content
                    Manager.AddPost((Session["user"] as User).Id, dateCreated.ToString("MM_dd_yyyy_hh_mm_ss_tt") + extension, contentUpload.Text);
                    string imgPath = Path.Combine(path, dateCreated.ToString("MM_dd_yyyy_hh_mm_ss_tt") + extension);
                    fuImage.SaveAs(imgPath);
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Something went wrong");
                    Console.WriteLine(ex.Message);
                }
            }
            Response.Redirect("Home");
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
                    return "just now";
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
                return "yesterday";
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