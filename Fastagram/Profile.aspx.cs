using System;
using Fastagram.App_Code.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Fastagram.App_Code.Model;

namespace Fastagram
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                string path = Server.MapPath("~/Images");
                User user = (User)Session["user"];
                Manager.GetPostByUser(user.Id, 1);
                path += user.Avatar;
                ImgAvatar.ImageUrl = path;
            }
        }
    }
}