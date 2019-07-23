<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Fastagram.Profile" %>

<%@ Import Namespace="Fastagram.Code.Model" %>
<%@ Import Namespace="Fastagram.Code.Data" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="App_Themes/Theme/home.css" />
    <link rel="stylesheet" href="App_Themes/Theme/Profile.css" />
</head>
<body>
    
    <form id="form1" runat="server">
        <div class="container">
            
            <div class="user-profile">
                <div class="c-avatar">
                    <asp:Image CssClass="avatar" ID="ImgAvatar" runat="server" />
                </div>
                <div class="c-user-name">
                    <asp:Label CssClass="user-name" ID="lbUserName" runat="server" Text="Label"></asp:Label>
                </div>
                <div class="c-post-count">
                    <p class="title">Post Count:</p>
                    <asp:Label CssClass="post-count" ID="lbPostCount" runat="server" Text="Label"></asp:Label>
                </div>
            </div>
            <br />
            <br />
            <hr />
            <div class="upload">
                <asp:FileUpload  ID="fuImage" runat="server" accept=".jpg, .png, .jpeg" />
                <asp:Button ID="btnUpload" runat="server" Text="Change Avatar" OnClick="btnUpload_Click" />
            </div>
            <hr />
            <br />
            <br />
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
