using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;

namespace Fastagram.Code.Socket
{
    [HubName("notifyHub")]
    public class NotifyHub : Hub
    {
        public void hello(string message)
        {
            Clients.All.hello(message);
        }
    }
}