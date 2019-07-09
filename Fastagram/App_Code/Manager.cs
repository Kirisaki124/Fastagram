
namespace Fastagram.App_Code
{
    public class Manager
    {
        public static bool IsUserValid(string userName, string password)
        {
            return DataAccess.IsUserValid(userName, password);
        }
    }
}