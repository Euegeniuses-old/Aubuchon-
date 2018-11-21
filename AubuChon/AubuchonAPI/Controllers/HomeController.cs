using AubuchonAPI.Models.Uploads;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.Http;
using System.Web.Http.Cors;

namespace AubuchonAPI.Controllers
{
    //[EnableCors(origins: "http://localhost:55651", headers: "*", methods: "*")]
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    [RoutePrefix("api/Home")]
    public class HomeController : ApiController
    {
        #region Upload
        [Route("Upload", Name = "Upload")]
        [HttpPost]
        public HttpResponseMessage Upload()
        {
            var objStatus = new Status();
            var httpRequest = HttpContext.Current.Request;
            var IsContainValidFile = false;
            HttpPostedFile postedFile = null;
            var objUpload = new Upload();
            try
            {
                if (httpRequest.Files.Count > 0 && httpRequest.Files["Photo"] != null)
                {
                    postedFile = httpRequest.Files["Photo"];
                    var contenttype = MimeMapping.GetMimeMapping(postedFile.FileName);
                    if (contenttype.ToLower().Contains("image"))
                    {
                        IsContainValidFile = true;
                    }
                    else
                    {
                        objStatus.Message = "Please select valid image";
                        objStatus.IsSuccess = false;
                        return Request.CreateResponse(HttpStatusCode.BadRequest, objStatus);
                    }
                }
                else
                {
                    objStatus.Message = "Please select image";
                    objStatus.IsSuccess = false;
                    return Request.CreateResponse(HttpStatusCode.BadRequest, objStatus);
                }

                if (IsContainValidFile)
                {
                    string fname = Path.GetFileNameWithoutExtension(postedFile.FileName.ToString());
                    string fextension = Path.GetExtension(postedFile.FileName);
                    var newFileName = DateTime.Now.Ticks + fextension;
                    objUpload.FilePath = Setting.ImagesPath + newFileName;
                    string filePath = Path.Combine(System.Web.Hosting.HostingEnvironment.MapPath("~/" + Setting.ImagesPath), newFileName);
                    postedFile.SaveAs(filePath);
                }

                //Upload save the image
                objStatus = UploadsMethod.UploadImage(objUpload);
            }
            catch (Exception ex)
            {
                objStatus.IsSuccess = false;
                objStatus.Message = Setting.GeneralErrMsg;
            }
            return Request.CreateResponse(HttpStatusCode.OK, objStatus);
        }
        #endregion
        
        #region GetIpList
        [Route("GetIpList", Name = "GetIpList")]
        [HttpPost]
        public HttpResponseMessage GetIpList()
        {
            var objStatus = new Status();
            var content = string.Empty;
            try
            {
                var url = System.Configuration.ConfigurationManager.AppSettings["IpUrl"].ToString();
                var request = (HttpWebRequest)WebRequest.Create(url);
                request.Method = "GET";
                ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
                using (var response = (HttpWebResponse)request.GetResponse())
                {
                    using (var stream = response.GetResponseStream())
                    {
                        using (var sr = new StreamReader(stream))
                        {
                            content = sr.ReadToEnd();
                        }
                    }
                }
                JObject json = JObject.Parse(content);
                objStatus.IsSuccess = true;
                objStatus.Data = json;
                return Request.CreateResponse(HttpStatusCode.OK, objStatus);
            }
            catch (Exception)
            {
                objStatus.IsSuccess = false;
                objStatus.Data = Setting.GeneralErrMsg;
                return Request.CreateResponse(HttpStatusCode.InternalServerError, objStatus);
            }
        }
        #endregion


        #region GetIpList
        [Route("CheckPublicIp", Name = "CheckPublicIp")]
        [HttpPost]
        public HttpResponseMessage CheckPublicIp(IpDetails objIpAddress)
        {
            var objStatus = new Status();
            var content = string.Empty;
            try
            {
                var url = System.Configuration.ConfigurationManager.AppSettings["IpUrl"].ToString();
                var request = (HttpWebRequest)WebRequest.Create(url);
                request.Method = "GET";
                ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
                using (var response = (HttpWebResponse)request.GetResponse())
                {
                    using (var stream = response.GetResponseStream())
                    {
                        using (var sr = new StreamReader(stream))
                        {
                            content = sr.ReadToEnd();
                        }
                    }
                }

                if (!string.IsNullOrEmpty(content))
                {
                    JObject json = JObject.Parse(content);
                    var jsonObj = JObject.Parse(content);
                    var IpList = jsonObj.Properties().Select(s => s.Name).ToList();
                    //var PublicIp = "67.255.0.129";
                    //objIpAddress.IpAddress = "67.255.0.129";
                    var isexist = IpList.Any(s => s.Contains(objIpAddress.IpAddress));
                    if (isexist)
                    {
                        objStatus.IsSuccess = true;
                        objStatus.Message = "Public ip is white listed";
                        return Request.CreateResponse(HttpStatusCode.OK, objStatus);
                    }
                    else
                    {
                        objStatus.IsSuccess = false;
                        objStatus.Message = "Ip address not white listed";
                        return Request.CreateResponse(HttpStatusCode.OK, objStatus);
                    }
                }
                else
                {
                    objStatus.IsSuccess = false;
                    objStatus.Message = "Ip list not found";
                    return Request.CreateResponse(HttpStatusCode.NotFound, objStatus);
                }
            }
            catch (Exception)
            {
                objStatus.IsSuccess = false;
                objStatus.Data = Setting.GeneralErrMsg;
                return Request.CreateResponse(HttpStatusCode.InternalServerError, objStatus);
            }
        }
        #endregion
    }
}
