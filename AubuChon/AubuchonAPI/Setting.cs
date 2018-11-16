using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace AubuchonAPI
{
    public class Setting
    {
        #region GetConnectionString
        public static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["connAubuchonApi"].ConnectionString;
        }
        #endregion

        public static string ImagesPath = ConfigurationManager.AppSettings["ImagesPath"].ToString();
        public const string GeneralErrMsg = "Error occured, Please try again.";
    }
}