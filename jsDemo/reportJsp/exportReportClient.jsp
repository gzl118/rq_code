<%@ page contentType="text/html;charset=GBK"%>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.runqian.report4.usermodel.Context"%>
<%@ page import="com.runqian.report4.model.*"%>

<%@ page import="com.runqian.report4.usermodel.*"%>

<%@ page import="com.runqian.report4.util.*"%>
<%@ page import="java.sql.*"%>

<html>
<head>
	<link type="text/css" href="css/style.css" rel="stylesheet" />
</head>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0
	style="">
	<div><input type="button" id="btn" onclick="excel1()" value="ExportExcel"/></div>
<%
   String raqNames="20005,20007,20008";
   String[] strs=raqNames.split(",");
   String strResult="";
   for(int i=0;i<strs.length;i++){
		String tempname=strs[i];
		if(tempname.lastIndexOf(".raq") <= 0 ){
			tempname = tempname + ".raq";
		}
	   String reportParamsId = null;
	   Hashtable hash = new Hashtable();
	   hash.put("rdate","2018-09-01"); 
	   hash.put("rfoid","164");
	   if( hash.size() > 0 ) {
		   reportParamsId = com.runqian.report4.view.ParamsPool.createParamsId();//生成参数缓存id
		   com.runqian.report4.view.ParamsPool.put(reportParamsId, hash );//将id放到缓存中
	   }
	   strResult+=",file="+tempname+"&reportParamsId="+reportParamsId;
   }
   if(strResult.length()>0)
	   strResult=strResult.substring(1);
%>
<script language=javascript>
	var nindex=0;	
	var nresult="<%=strResult%>";
	var splitresult=nresult.split(",");
	function excel1() {		
		var flag=setInterval(function(){
			var url="http://localhost:7878/jsDemo/reportServlet?action=3&columns=0&srcType=file&width=0&height=0&pageStyle=0&is2007=1&"+splitresult[nindex];
			document.report1_saveAs_frame.location =url;
			nindex++;
			if(nindex==splitresult.length){
				 clearInterval(flag);
				 nindex=0;
			}
		},3*1000);
	}
</script>
<iframe name="report1_saveAs_frame" id="report1_saveAs_frame" src="" style="display:none"></iframe>
</body>
</html>
