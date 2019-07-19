using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Fastagram.Code.Model
{
    public class User
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Avatar { get; set; }
        public User(int id, string name, string avatar)
        {
            Id = id;
            Name = name;
            Avatar = avatar;
        }
    }
}