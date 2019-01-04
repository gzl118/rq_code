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
<%@ page import="com.bootdo.system.domain.ExportDO"%>
<%@ page import="com.alibaba.fastjson.JSON"%>
<%@ page import="org.apache.commons.lang3.StringUtils"%>

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

	String sjson = request.getParameter("report");
	List<ExportDO> list=JSON.parseArray(sjson,ExportDO.class);
	for(ExportDO item : list){
		String code=item.getRaq();
		if(StringUtils.isEmpty(code))
			continue;
		if(StringUtils.isEmpty(item.getRdate()))
			continue;
		String excelpath = "D:"+File.separator+"excel"+File.separator+item.getRdate()+File.separator;
		File file=new File(excelpath);
		if(!file.exists()){
			file.mkdirs();
		}
		String tempname="";
		if(code.lastIndexOf(".raq") <= 0 ){
			tempname = code + ".raq";
		}
		String raq=raqPath+"/"+tempname;
		ReportDefine rd=(ReportDefine)ReportUtils.read(raq);
		Context cxt=new Context();
		Engine engine=new Engine(rd,cxt);				
		cxt.setParamValue("rdate",item.getRdate());
		cxt.setParamValue("rfoid",item.getRfoid());
		cxt.setParamValue("roid",item.getRoid());	
		cxt.setParamValue("rtitle",item.getRoid());			
		cxt.setParamValue("rdepart",item.getRdepart());
		cxt.setMacroValue("rdepart",item.getRdepart());
		IReport ireport=engine.calc();
		ReportUtils.exportToExcel2007(excelpath +code+".xlsx",ireport,false);
		request.setAttribute("report",ireport);
	}
%>
</body>
</html>
