<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Fastagram.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="frmLogin" runat="server">
        <asp:Label ID="lbMessage" runat="server" Text=""></asp:Label>
        <br />
        <asp:Label runat="server" Text="User Name"></asp:Label>
        <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
        <br />
        <asp:Label runat="server" Text="Password"></asp:Label>
        <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click"/>
        <br />
        <asp:Label runat="server" Text="Don't have any account? "></asp:Label><asp:HyperLink NavigateUrl="Register.aspx" runat="server">Register Now!</asp:HyperLink>
    </form>
</body>
</html>
