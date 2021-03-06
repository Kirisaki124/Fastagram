﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Fastagram.Home" %>

<%@ Import Namespace="Fastagram.Code.Model" %>
<%@ Import Namespace="Fastagram.Code.Data" %>
<%@ Import Namespace="System.IO" %>
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.css" />
</head>
<script type="text/javascript">
    var chat = $.connection.notifyHub;

    document.addEventListener('DOMContentLoaded', function () {
        if (Notification.permission !== "granted") {
            Notification.requestPermission();
        }
    });  

    function pushNotification(title, desc) {

        if (Notification.permission !== "granted") {
            Notification.requestPermission();
        }
        else {
            var notification = new Notification(title, {
                icon: '',
                body: desc,
            });

            /* Remove the notification from Notification Center when clicked.*/
            notification.onclick = function () {
                window.open('https://fastagram.azurewebsites.net/Home');
            };

            /* Callback function when the notification is closed. */
            notification.onclose = function () {
                console.log('Notification closed');
            };

        }
    }  

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
            pushNotification('New Comment From Fastagram', userName + ": " + comment);
        }

        chat.client.notifyLikePost = (postId, userId, likeCount) => {
            $("#like" + postId).html(`${likeCount} <i class="far fa-thumbs-up"></i> Like`);
        }

        chat.client.notifyNewPost = () => {
            var unreadPostCount = parseInt($('#totalNewPost a').html().split(' ')[0]);
            $('#totalNewPost a').html(`${++unreadPostCount} new post(s)`);
            pushNotification('New Post From Fastagram', 'Click to see more');
        }

        chat.client.notifyDeletePost = (id) => {
            $("#post-container-" + id).remove();
        }

        chat.client.getMorePost = (posts) => {
            $(posts).each(function () {
                var deleteBtn = "";
                if (this.User.Id === parseInt('<%= (Session["user"] as User).Id %>')) {
                    deleteBtn = `<a onclick="deletePost(${this.Id})" style="float: right" href="#">Delete</a>`;
                }

                var html = `
                <div class="post" id='post-container-${this.Id}'>
                ${deleteBtn}
            <div class="post-header">
                <img class="avatar" src="<%= Session["avaPath"].ToString() %>/${this.User.Avatar}" />
                <div class="post-header-text">
                    <a href="Profile?id=${this.User.Id}"><b class="user-name">${this.User.Name}</b></a>
                    <p class="date">${this.FriendlyDate}</p>
                </div>
            </div>

            <p>${this.Content}</p>
            <div class="image-container">
                <a href="Detail?id=${this.Id}">
                    <img class="image" src='<%= Session["imagePath"].ToString() %>/${this.Image}' />
                </a>
            </div>

            <div class="post-action">
                <div id="like${this.Id}" class="like" onclick="likePost(${this.Id},  <%= ((User)Session["user"]).Id %>)">${this.LikeCount} <i class="far fa-thumbs-up"></i>Like</div>
                <div class="comment" onclick='$("#post${this.Id}").focus()'><i class="far fa-comment-alt"></i>Comment</div>
            </div>

            <div id="comment${this.Id}" class="comment-box">`;

                $(this.Comments).each(function () {
                    html += `<div class="comment-bubble">
                    <img class="avatar" src="<%= Session["avaPath"].ToString() %>/${this.User.Avatar}" />
                    <div class="comment-bubble-text">
                        <a href="Profile?id=${this.User.Id}"><span><b>${this.User.Name}</b></span></a>
                        <span>${this.Content}</span>
                    </div>
                </div>`
                });
                html += `</div>
            <div style="display: flex; margin-top: 10px; align-thiss: center;">
                <img class="avatar" src="<%= Session["avaPath"] + "/" + ((User)Session["user"]).Avatar %>" />
                <div class="new-comment">
                    <input id="post${this.Id}" type="text" placeholder="Enter something..." onkeyup="checkEnter(event, ${this.Id}, <%= ((User) Session["user"]).Id %>)" />
                </div>
            </div>
        </div>`;
                $("#newFeed").append(html)
            })
            console.log(posts);
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

    var cPage = 1;

    $(window).scroll(function () {
        if ($(window).scrollTop() + $(window).height() >= $(document).height() - 20) {
            chat.server.getMorePostByPage(++cPage);
        }
    });

    function addComment(id, userId) {
        var comment = $('#post' + id).val();
        chat.server.notifyNewComment(id, userId, comment);
        var comment = $('#post' + id).val('');
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

    function notifyIncomingPost() {
        chat.server.notifyNewPost();
    }

    function deletePost(id) {
        if (confirm('Are you sure?') === true) {
            chat.server.notifyDeletePost(id);
        }
    }

</script>
<body>
    <div class="nav">
        <a href="Profile"><%= ((User)Session["user"]).Name %></a>
        <span id="totalNewPost" class="total-new-post"><a href="">0 new post(s)</a></span>
        <a href="home?signout=true" style="float: right; margin-right: 20px;">Sign Out</a>
    </div>

    <div class="container">
        <form runat="server">
            <div class="upload">
                <div class="message">
                    <img class="avatar" src="Avatar/<%= ((User) Session["user"]).Avatar %>" />
                    <asp:TextBox ID="contentUpload" runat="server" placeholder="What are you thinking?"></asp:TextBox>
                    <span onclick="$('#fuImage').click()" class="upload-image"><i class="far fa-image"></i>Upload Image</span>
                    <div id="doneUpload" hidden style="margin-left: 5px">
                        <i class="fas fa-check-circle" style="color: forestgreen"></i>
                    </div>
                </div>
                <asp:FileUpload ID="fuImage" runat="server" accept=".jpg, .png, .jpeg" hidden onchange="$('#doneUpload').show();" />
                <asp:Button ID="btnUpload" runat="server" Text="Post" OnClick="btnUpload_Click" CssClass="post-button" OnClientClick="notifyIncomingPost()" />
            </div>
        </form>
        <div id="newFeed">
            <%
                foreach (Post item in listPost)
                {
            %>
            <div class="post" id="post-container-<%= item.Id %>">
                <% 
                    if (item.User.Id == (Session["user"] as User).Id)
                    {
                %>
                <a onclick="deletePost(<%= item.Id %>)" style="float: right" href="#">Delete</a>
                <% } %>
                <div class="post-header">
                    <img class="avatar" src="Avatar/<%= item.User.Avatar %>" />
                    <div class="post-header-text">
                        <a href="Profile?id=<%= item.User.Id %>"><b class="user-name"><%= item.User.Name %></b></a>
                        <p class="date"><%= item.FriendlyDate %></p>
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
                            <a href="Profile?id=<%= comment.User.Id %>"><span><b><%= comment.User.Name %></b></span></a>
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
            <%
                }
            %>
        </div>

    </div>
</body>
</html>
