using System;
using Fastagram.Code.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Fastagram.Code.Model;
using System.IO;

namespace Fastagram
{
    public partial class Profile : System.Web.UI.Page
    {
        public List<Post> posts;
        public int id;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                id = Convert.ToInt32(Request.QueryString["id"]);
                string path = "Avatar";
                User user = (User)Session["user"];
                if (id != 0)
                {
                    user = Manager.GetUserByID(id);
                }
                posts = Manager.GetPostByUser(user.Id, 1);
                path = Path.Combine(path, user.Avatar);
                ImgAvatar.ImageUrl = path;
                lbPostCount.Text = posts.Count().ToString();
                lbUserName.Text = user.Name;
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            string path = Server.MapPath("~/Avatar"); //Path
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
                    Manager.ChangeAvatar(dateCreated.ToString("MM_dd_yyyy_hh_mm_ss_tt") + extension, (Session["user"] as User).Id);
                    string imgPath = Path.Combine(path, dateCreated.ToString("MM_dd_yyyy_hh_mm_ss_tt") + extension);
                    fuImage.SaveAs(imgPath);
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Something went wrong");
                    Console.WriteLine(ex.Message);
                }
            }
            Session["user"] = Manager.GetUserByID(((User)Session["user"]).Id);
            Response.Redirect("Profile");
        }
    }
}