<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Fastagram.Profile" %>
<%@ Import Namespace= "Fastagram.App_Code.Model" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Image ID="ImgAvatar" runat="server"  />
            <asp:Label ID="lbPostCount" runat="server" Text="Label"></asp:Label>
        </div>
        <% foreach (Post post in posts) %>
        <div>
            
        </div>
    </form>
</body>
</html>
