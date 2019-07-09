using Fastagram.App_Code.Data;
using System;

namespace Fastagram
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Manager.IsExist(txtUserName.Text))
            {
                if (txtPassword.Text == txtRePassword.Text)
                {
                    Manager.AddUser(txtUserName.Text, txtPassword.Text);
                    lbMessage.Text = "Register successfully! You can now login!";
                }
                else
                {
                    lbMessage.Text = "Password not match!";
                }
            }
            else
            {
                lbMessage.Text = $"Your {txtUserName.Text} is already exist!";
            }
        }
    }
}