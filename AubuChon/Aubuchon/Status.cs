using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Aubuchon
{
    public class Status
    {
        public bool IsSuccess { get; set; }
        public string Message { get; set; }
        public string StatusCode { get; set; }
        public object Data { get; set; }
        public int TotalCount { get; set; }
    }
}