<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Fastagram.Profile" %>

<%@ Import Namespace="Fastagram.Code.Model" %>
<%@ Import Namespace="Fastagram.Code.Data" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="App_Themes/Theme/home.css" />
    <link rel="stylesheet" href="App_Themes/Theme/Profile.css" />
</head>
<body>
    <div class="nav">
        <a href="Home">Home</a>
        <a href="home?signout=true" style="float: right; margin-right: 20px;">Sign Out</a>
    </div>
    <form id="form1" runat="server">
        <div class="container">
            <div class="user-profile">
                <div class="c-avatar">
                    <asp:Image CssClass="avatar" ID="ImgAvatar" runat="server" onclick="$('#fuImage').click(); " style="cursor: pointer"/>
                </div>
                <div class="c-profile">
                    <div class="c-user-name">
                        <asp:Label CssClass="user-name" ID="lbUserName" runat="server" Text="Label"></asp:Label>
                    </div>
                    <div class="c-post-count">
                        <p class="title"><asp:Label CssClass="post-count" ID="lbPostCount" runat="server" Text="Label"></asp:Label> Posts</p>
                        
                    </div>
                </div>
            </div>
            <% if (id == Convert.ToInt32((Session["user"] as User).Id))
                { %>
            <div class="up" hidden>
                <asp:FileUpload ID="fuImage" runat="server" accept=".jpg, .png, .jpeg" onchange="$('#btnUpload').click();"/>
                <asp:Button ID="btnUpload" runat="server" Text="Change Avatar" OnClick="btnUpload_Click" />
            </div>
            <%} %>
            
            <div class="post-container">
                <% foreach (Post post in posts)
                    {
                %>
                <a class="detail" href="Detail.aspx?id=<%=post.Id%>">
                    <img class="post-img" src="<%= Path.Combine("Images", post.Image) %>" />
                </a>
                <%} %>
            </div>
        </div>
    </form>
</body>
</html>
