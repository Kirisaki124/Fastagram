using System;
using Fastagram.App_Code;

namespace Fastagram
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Manager.IsUserValid(txtUserName.Text, txtPassword.Text))
            {
                lbMessage.Text = "You are now logged in!";
            }
            else
            {
                lbMessage.Text = "Wrong username or password!";
            }
        }
    }
}