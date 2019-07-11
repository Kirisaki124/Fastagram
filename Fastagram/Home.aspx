<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Fastagram.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:FileUpload ID="fuImage" runat="server" accept=".jpg, .png, .jpeg"/>
            <asp:Button ID="btnUpload" runat="server" Text="Button" OnClick="btnUpload_Click" />
        </div>
        <asp:Button ID="btnSignout" runat="server" Text="Signout" OnClick="btnSignout_Click"/>
    </form>
</body>
</html>
