<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Fastagram.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="App_Themes/Theme/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="App_Themes/Theme/register.css" />
</head>
<body>
    <!-- This snippet uses Font Awesome 5 Free as a dependency. You can download it at fontawesome.io! -->

    <div class="container">
        <div class="row">
            <div class="col-lg-10 col-xl-9 mx-auto">
                <div class="card card-signin flex-row my-5">
                    <div class="card-img-left d-none d-md-flex">
                        <!-- Background image for card set in CSS! -->
                    </div>
                    <div class="card-body">
                        <h5 class="card-title text-center">Register</h5>
                        <% 
                            if (lbMessage.Text != "")
                            {
                        %>
                            <asp:Label ID="lbMessage" runat="server" class="alert alert-danger"></asp:Label>
                        <%
                            }
                        %>
                        <form class="form-signin" id="frmRegister" runat="server">
                            <div class="form-label-group">
                                <asp:TextBox ID="txtUserName" runat="server" required="true" class="form-control" placeholder="Username" autofocus></asp:TextBox>
                                <label for="txtUserName">Username</label>
                            </div>
                            <div class="form-label-group">
                                <asp:TextBox ID="txtPassword" runat="server" required="true" TextMode="Password" class="form-control" placeholder="Password"></asp:TextBox>
                                <label for="txtPassword">Password</label>
                            </div>

                            <div class="form-label-group">
                                <asp:TextBox ID="txtRePassword" runat="server" required="true" TextMode="Password" class="form-control" placeholder="Confirm Password"></asp:TextBox>
                                <label for="txtRePassword">Confirm password</label>
                            </div>

                            <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" class="btn btn-lg btn-success btn-block text-uppercase" />
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
