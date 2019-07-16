<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Fastagram.Home" %>
<%@ Import Namespace="Fastagram.App_Code.Model" %>
<%@ Import Namespace="Fastagram.App_Code.Data" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        New feed here <br/>
        <%
            foreach(Post item in listPost)
            {
                %>
                    <h1><%=item.Id %></h1>
                    <h1><%=item.UserId %></h1>
                    <img src='<%=imagePath + item.Image %>'/>
                    <h1><%=item.Content %></h1>
                    <h1><%=item.Date %></h1>
                    comment post
                    <%
                        foreach(Comment comment in item.Comments)
                        {
                            %>
                                <h1><%=Manager.GetUserByID(comment.UserId).Name %></1>
                                <h1><%=comment.Content %></h1>
                            <%
                        }
                    %>
                    
                    <form action="Home.aspx">
                        <input name="user" value='<%=Session["user"] %>' hidden="hidden"/>
                        <input type="text"/>
                        <input type="submit"/>
                    </form>
                <%
                    
            }
        %>
        <div>
            create post <br/>
            <asp:FileUpload ID="fuImage" runat="server" accept=".jpg, .png, .jpeg"/>
            <asp:Button ID="btnUpload" runat="server" Text="Button" OnClick="btnUpload_Click" />
        </div>
        <asp:Button ID="btnSignout" runat="server" Text="Signout" OnClick="btnSignout_Click"/>
    </form>

</body>
</html>
