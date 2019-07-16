<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Fastagram.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="App_Themes/Theme/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="App_Themes/Theme/style.css" />
</head>
<body>
    <div class="container-fluid">
        <div class="row no-gutter">
            <div class="d-none d-md-flex col-md-4 col-lg-6 bg-image"></div>
            <div class="col-md-8 col-lg-6">
                <div class="login d-flex align-items-center py-5">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-9 col-lg-8 mx-auto">
                                <h3 class="login-heading mb-4">Welcome back!</h3>
                                <% 
                                    if (lbMessage.Text != "")
                                    {
                                %>
                                    <asp:Label ID="lbMessage" runat="server" class="alert alert-danger"></asp:Label>
                                <%
                                    }
                                %>
                                <form class="form-login" id="frmLogin" runat="server">
                                    <div class="form-label-group">
                                        <asp:TextBox ID="txtUserName" runat="server" class="form-control" placeholder="User Name" required></asp:TextBox>
                                        <label for="txtUserName">User Name</label>
                                    </div>

                                    <div class="form-label-group">
                                        <asp:TextBox ID="txtPassword" runat="server" class="form-control" placeholder="Password" required TextMode="Password"></asp:TextBox>
                                        <label for="txtPassword">Password</label>
                                    </div>

                                    <div class="custom-control custom-checkbox mb-3">
                                        <input type="checkbox" class="custom-control-input" id="customCheck1">
                                        <label class="custom-control-label" for="customCheck1">Remember password</label>
                                    </div>
                                    <asp:Button ID="btnLogin" runat="server" Text="Sign In" OnClick="btnLogin_Click" class="btn btn-lg btn-info btn-block btn-login text-uppercase font-weight-bold mb-2" />

                                    <div class="text-center">
                                        <asp:Label class="small" runat="server" Text="Don't have any account? "></asp:Label><asp:HyperLink class="small" NavigateUrl="Register.aspx" runat="server">Register Now!</asp:HyperLink>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
