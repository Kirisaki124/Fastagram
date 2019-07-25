﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Detail.aspx.cs" Inherits="Fastagram.Detail" %>

<!DOCTYPE html>
<%@ Import Namespace="Fastagram.Code.Model" %>
<%@ Import Namespace="Fastagram.Code.Data" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <!--Reference the SignalR library. -->
    <script src="Scripts/jquery.signalR-2.4.1.min.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="signalr/hubs"></script>
    <link rel="stylesheet" href="App_Themes/Theme/home.css" />
    <link rel="stylesheet" href="App_Themes/Theme/detail.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.css" />
</head>
<script type="text/javascript">
    var chat = $.connection.notifyHub;

    $(() => {

        chat.client.notifyNewComment = (postId, userId, avatar, userName, comment) => {
            $("#comment" + postId).append(`
                <div class="comment-bubble">
                    <img class="avatar" src="Avatar/${avatar}" />
                    <div class="comment-bubble-text">
                        <a href="Profile.aspx?id=${userId}"><span><b>${userName}</b></span></a>
                        <span>${comment}</span>
                    </div>
                </div>`);

        }


        chat.client.notifyLikePost = (postId, userId, likeCount) => {
            $("#like" + postId).html(`${likeCount} <i class="far fa-thumbs-up"></i> Like`);
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

    function likePost(postId, userId) {

        chat.server.notifyLikePost(postId, userId);
    }

    function checkEnter(event, id, userId) {
        if (event.keyCode === 13) {
            event.preventDefault();
            addComment(id, userId);
        }
    }
</script>

<body>
    <div class="container">
        <form id="form1" runat="server">
            <% Post item = Manager.GetPostById(Request.QueryString["id"]); %>
            <div>
                <div class="post">
                    <div class="post-header">
                        <img class="avatar" src="Avatar/<%= item.User.Avatar %>" />
                        <div class="post-header-text">
                            <b class="user-name"><%= item.User.Name %></b>
                            <p class="date"><%= GetPrettyDate(item.Date) %></p>
                        </div>
                    </div>

                    <p><%= item.Content %></p>
                    <div class="image-container">
                        <a href="Detail?id=<%= item.Id %>">
                            <img class="image" src='<%= imagePath + item.Image %>' />
                        </a>
                    </div>

                    <div class="post-action">
                        <div id="like<%=item.Id %>" class="like" onclick="likePost(<%=item.Id %>, <%=((User)Session["user"]).Id %>)"><%=item.LikeCount %> <i class="far fa-thumbs-up"></i>Like</div>
                        <%--<button onclick="likePost(<%=item.Id %>, <%=((User)Session["user"]).Id %>)">like</button>--%>
                        <div class="comment" onclick='$("#post<%=item.Id %>").focus()'><i class="far fa-comment-alt"></i>Comment</div>
                    </div>

                    <div id="comment<%=item.Id %>" class="comment-box">
                        <%
                            foreach (Comment comment in item.Comments)
                            {
                        %>
                        <div class="comment-bubble">
                            <img class="avatar" src="Avatar/<%= comment.User.Avatar %>" />
                            <div class="comment-bubble-text">
                                <a href="Profile.aspx?id=<%= comment.User.Id %>"><span><b><%= comment.User.Name %></b></span></a>
                                <span><%= comment.Content %></span>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <div style="display: flex; margin-top: 10px; align-items: center;">
                        <img class="avatar" src="Avatar/<%= ((User)Session["user"]).Avatar %>" />
                        <div class="new-comment">
                            <input id="post<%= item.Id %>" type="text" placeholder="Enter something..." onkeyup="checkEnter(event, <%= item.Id %>, <%= ((User) Session["user"]).Id %>)" />
                        </div>
                    </div>

                </div>
            </div>
        </form>
    </div>
</body>
</html>
