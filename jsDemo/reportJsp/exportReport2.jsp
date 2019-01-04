<%@ page contentType="text/html;charset=GBK"%>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.runqian.report4.usermodel.Context"%>
<%@ page import="com.runqian.report4.model.*"%>

<%@ page import="com.runqian.report4.usermodel.*"%>

<%@ page import="com.runqian.report4.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>

<html>
<head>
	<link type="text/css" href="css/style.css" rel="stylesheet" />
</head>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0
	style="">
	<%
	request.setCharacterEncoding( "GBK" );
	String reportFileHome=Context.getInitCtx().getMainDir();
	
	String raqPath=application.getRealPath(reportFileHome);
	String raqNames="20005,20007,20008";
	String[] strs=raqNames.split(",");

	java.util.Date d = new java.util.Date();
	SimpleDateFormat df = new SimpleDateFormat("yyyyMM");
    String sDate=df.format(d);
	
	//String excelpath = "D:\\excel\\"+sDate+"\\"; 
	String excelpath = "D:"+File.separator+"excel"+File.separator+sDate+File.separator;
	File file=new File(excelpath);
	if(!file.exists()){
		file.mkdirs();
	}

	for(int i=0;i<strs.length;i++){
		String tempname=strs[i];
		if(tempname.lastIndexOf(".raq") <= 0 ){
			tempname = tempname + ".raq";
		}
		String raq=raqPath+"/"+tempname;
		ReportDefine rd=(ReportDefine)ReportUtils.read(raq);

		Context cxt=new Context();
		cxt.setParamValue("rdate","2018-09-01");

		cxt.setParamValue("rfoid","164");

		Engine engine=new Engine(rd,cxt);

		IReport ireport=engine.calc();

		ReportUtils.exportToExcel2007(excelpath +strs[i]+".xlsx",ireport,false);

		request.setAttribute("report",ireport);
	}
%>
</body>
</html>
