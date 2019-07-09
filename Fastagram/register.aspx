<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Fastagram.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="frmRegister" runat="server">
        <asp:Label ID="lbMessage" runat="server" Text=""></asp:Label>
        <br />
        <asp:Label ID="lbUserName" runat="server" Text="User Name:"></asp:Label>
        <asp:TextBox ID="txtUserName" runat="server" required="true"></asp:TextBox>
        <br />
        <asp:Label ID="lbPassword" runat="server" Text="Password:"></asp:Label>
        <asp:TextBox ID="txtPassword" runat="server" required="true" TextMode="Password"></asp:TextBox>
        <br />
        <asp:Label ID="lbRePassword" runat="server" Text="Re-enter password:"></asp:Label>
        <asp:TextBox ID="txtRePassword" runat="server" required="true" TextMode="Password"></asp:TextBox>
        <br />
        <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click"/>
    </form>
</body>
</html>
