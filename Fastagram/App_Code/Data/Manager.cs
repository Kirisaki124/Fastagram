namespace Fastagram.App_Code.Data
{
    public class Manager
    {
        public static bool IsUserValid(string userName, string password)
        {
            return DataAccess.IsUserValid(userName, password);
        }
        public static bool AddUser(string userName, string password)
        {
            return DataAccess.AddUser(userName, password);
        }

    }
}