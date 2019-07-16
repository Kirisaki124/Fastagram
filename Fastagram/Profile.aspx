﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Fastagram.Profile" %>

<%@ Import Namespace="Fastagram.App_Code.Model" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Image ID="ImgAvatar" runat="server" />
            <asp:Label ID="lbPostCount" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="lbUserName" runat="server" Text="Label"></asp:Label>
        </div>

        <% foreach (Post post in posts)
          {
        %>
        <div>
            <img src="<%= Path.Combine("Images", post.Image) %>" />
        </div>
        <%} %>
        <div>
        </div>
    </form>
</body>
</html>
