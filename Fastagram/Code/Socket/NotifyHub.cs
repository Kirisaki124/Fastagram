﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
using Fastagram.Code.Data;
using Fastagram.Code.Model;

namespace Fastagram.Code.Socket
{
    [HubName("notifyHub")]
    public class NotifyHub : Hub
    {
        public void notifyNewComment(string id, string userId, string comment)
        {
            Clients.All.notifyNewComment(id, userId, Manager.GetUserByID(Convert.ToInt32(userId)).Avatar, Manager.GetUserByID(Convert.ToInt32(userId)).Name, comment);
            Manager.AddComment(Convert.ToInt32(userId), Convert.ToInt32(id), comment); 
        }
        public void notifyLikePost(string postId, string userId)
        {
            Manager.ToggleLike(Convert.ToInt32(postId), Convert.ToInt32(userId));
            int likeCounts = Manager.GetPostById(postId).LikeCount;
            Clients.All.notifyLikePost(postId, userId, likeCounts);

        }
        public void getMorePostByPage(int page)
        {
            List<Post> a = Manager.GetPostByPage(page);
            Clients.Caller.getMorePost(a);
        }
        public void notifyNewPost()
        {
            Clients.All.notifyNewPost();
        }

        public void notifyDeletePost(int id)
        {
            Manager.DeletePostById(id);
            Clients.All.notifyDeletePost(id);
        }
    }
}