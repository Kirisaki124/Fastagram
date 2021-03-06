﻿using Fastagram.Code.Data;
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

    }
}