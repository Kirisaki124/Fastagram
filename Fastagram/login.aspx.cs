using Fastagram.App_Code.Data;
using System;

namespace Fastagram
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] != null)
            {
                Response.Redirect("Home.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Manager.IsUserValid(txtUserName.Text, txtPassword.Text))
            {
                lbMessage.Text = "You are now logged in!";
                Session["user"] = Manager.GetUserByName(txtUserName.Text);
                Response.Redirect("Home.aspx");
            }
            else
            {
                lbMessage.Text = "Wrong username or password!";
            }
        }
    }
}