﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Fastagram.Home" %>

<%@ Import Namespace="Fastagram.Code.Model" %>
<%@ Import Namespace="Fastagram.Code.Data" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <!--Reference the SignalR library. -->
    <script src="Scripts/jquery.signalR-2.4.1.min.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="signalr/hubs"></script>
    <link rel="stylesheet" href="App_Themes/Theme/home.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/fontawesome.min.css">
</head>
<script type="text/javascript">
    var chat = $.connection.notifyHub;

    $(() => {

        chat.client.notifyNewComment = (postId, userId,userName, comment) => {
            $("#comment" + postId).append(`<div><h1>${userName}</h1><p>${comment}</p></div >`)
        }

        $.connection.hub.start().done(() => {
            $('#sendmessage').click(() => {
                // Call the Send method on the hub. 
                chat.server.abc($('#message').val());
                // Clear text box and reset focus for next comment. 
                $('#message').val('').focus();
            });
        })


    });

    function addComment(id, userId) {
        var comment = $('#post' + id).val();
        chat.server.notifyNewComment(id, userId, comment);
        
        //window.location = "home"
        // Clear text box and reset focus for next comment.
    }

</script>
<body>
    <a href="Profile">Profile</a>

    <div class="container">
        <form runat="server">
            <div class="upload">
                <asp:FileUpload ID="fuImage" runat="server" accept=".jpg, .png, .jpeg" />
                <asp:Button ID="btnUpload" runat="server" Text="Post" OnClick="btnUpload_Click" />
            </div>
        </form>
        <%
            foreach (Post item in listPost)
            {
        %>
        <div class="post">
            <h3 class="user-name"><%= Manager.GetUserByID(item.UserId).Name %></h3>
            <p class="date"><%= item.Date %></p>

            <p><%= item.Content %></p>
            <div class="image-container">
                <a href="Detail?id=<%= item.Id %>">
                    <img class="image" src='<%= imagePath + item.Image %>' />
                </a>
            </div>

            <div class="post-action">
                <div class="like">Like</div>
                <div class="comment">Comment</div>
            </div>

            <div id="comment<%=item.Id %>">
                <%
                    foreach (Comment comment in item.Comments)
                    {
                %>
                <div>
                    <h1><%= Manager.GetUserByID(comment.UserId).Name %></h1>
                    <p><%= comment.Content %></p>
                </div>
                <%
                    }
                %>
            </div>

            <div class="new-comment">       
                
                    <input id="post<%= item.Id %>" type="text" placeholder="Enter something..." />
                    <button onclick='addComment(<%= item.Id %>, <%= ((User) Session["user"]).Id %>)'>comment</button>
                
            </div>
        </div>
        <%

            }
        %>
    </div>
</body>
</html>
