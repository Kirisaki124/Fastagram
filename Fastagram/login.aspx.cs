using Fastagram.Code.Data;
using Fastagram.Code.Encrypt;
using System;
using System.Web;
using System.Web.UI.HtmlControls;

namespace Fastagram
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["user"] != null)
                {
                    Response.Redirect("home");
                }

                if (Request.Cookies["remember"] != null && Request.Cookies["remember"].Expires > DateTime.Now)
                {
                    Session["user"] = Manager.GetUserByName(Request.Cookies["remember"].Value);
                    Response.Redirect("home");
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Manager.IsUserValid(txtUserName.Text, Encryption.ComputeSha256Hash(txtPassword.Text)))
            {
                Session["user"] = Manager.GetUserByName(txtUserName.Text);

                HtmlInputCheckBox cbRemember = frmLogin.FindControl("cbRemember") as HtmlInputCheckBox;

                if (cbRemember.Checked)
                {
                    HttpCookie cookie = new HttpCookie("remember", txtUserName.Text);
                    cookie.Expires = DateTime.Now.AddDays(10);

                    Response.Cookies.Add(cookie);
                }

                Response.Redirect("home");
            }
            else
            {
                lbMessage.Text = "Wrong username or password!";
            }
        }
    }
}