using System;
using Fastagram.App_Code.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Fastagram.App_Code.Model;
using System.IO;

namespace Fastagram
{
    public partial class Profile : System.Web.UI.Page
    {
        public List<Image> images;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                string path = "Images";
                User user = (User)Session["user"];
                List<Post> posts = Manager.GetPostByUser(user.Id, 1);
                path = Path.Combine(path, user.Avatar);
                ImgAvatar.ImageUrl = path;
                lbPostCount.Text = posts.Count().ToString();
                lbUserName.Text = user.Name; 
                images = new List<Image>();
                foreach(Post post in posts)
                {
                    path = "Images";
                    Image temp = new Image();
                    temp.ImageUrl = Path.Combine(path, post.Image);
                    images.Add(temp);
                }
                
                foreach(Image image in images)
                {
                    panelPost.Controls.Add(image);
                }
            }
        }
    }
}