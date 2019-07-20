﻿using Fastagram.Code.Data;
using System;

namespace Fastagram
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] != null)
            {
                Response.Redirect("home");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Manager.IsUserValid(txtUserName.Text, txtPassword.Text))
            {
                Session["user"] = Manager.GetUserByName(txtUserName.Text);
                Response.Redirect("home");
            }
            else
            {
                lbMessage.Text = "Wrong username or password!";
            }
        }
    }
}