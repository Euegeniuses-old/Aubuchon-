using DifferenzLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;

namespace AubuchonAPI.Models.Uploads
{
    public class UploadsMethod
    {
        #region Uploads
        public static Status UploadImage(Upload objUpload)
        {
            var ObjStatus = new Status();
            try
            {
                var ds = DataAccess.ExecuteDataset(Setting.GetConnectionString(), "InsertUploadImage", objUpload.FilePath);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    var row = ds.Tables[0].Rows[0];
                    var isSuccess = Convert.ToBoolean(row["IsSuccess"]);
                    if (isSuccess)
                    {
                        ObjStatus.IsSuccess = Convert.ToBoolean(row["IsSuccess"]);
                        ObjStatus.Message = row["Message"].ToString();
                        ObjStatus.StatusCode = Convert.ToInt32(HttpStatusCode.OK).ToString();
                    }
                    else
                    {
                        ObjStatus.IsSuccess = true;
                        ObjStatus.Message = row["Message"].ToString();
                        ObjStatus.StatusCode = Convert.ToInt32(HttpStatusCode.OK).ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                ObjStatus.IsSuccess = false;
                ObjStatus.Message = Setting.GeneralErrMsg;
            }
            return ObjStatus;
        }
        #endregion

        #region CheckIpExistOrNot
        public static Status CheckIpExistOrNot(IpDetails objIpDetails)
        {
            var ObjStatus = new Status();
            try
            {
                var ds = DataAccess.ExecuteDataset(Setting.GetConnectionString(), "CheckIpExist", objIpDetails.IpAddress);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    var row = ds.Tables[0].Rows[0];
                    ObjStatus.IsSuccess = Convert.ToBoolean(row["IsExist"]);
                }
            }
            catch (Exception ex)
            {
                ObjStatus.IsSuccess = false;
                ObjStatus.Message = Setting.GeneralErrMsg;
            }
            return ObjStatus;
        }
        #endregion

        #region AddIpLog
        public static Status AddIpLog(IpDetails objIpDetails)
        {
            var ObjStatus = new Status();
            try
            {
                var ds = DataAccess.ExecuteDataset(Setting.GetConnectionString(), "InsertIpLog", objIpDetails.IpAddress);
            }
            catch (Exception ex)
            {
                ObjStatus.IsSuccess = false;
                ObjStatus.Message = Setting.GeneralErrMsg;
            }
            return ObjStatus;
        }
        #endregion
    }
}