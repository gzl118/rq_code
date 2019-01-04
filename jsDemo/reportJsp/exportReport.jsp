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
	<%
	request.setCharacterEncoding( "GBK" );
	String reportFileHome=Context.getInitCtx().getMainDir();
	
	String raqPath=application.getRealPath(reportFileHome);
	String raqNames="20005,20007,20008";
	String[] strs=raqNames.split(",");

	for(int i=0;i<strs.length;i++){
		String tempname=strs[i];
		if(tempname.lastIndexOf(".raq") <= 0 ){
			tempname = tempname + ".raq";
		}
		String raq=raqPath+"/"+tempname;

		String excelpath = "D:\\excel\\";

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
	<div
		style=" height: expression(parent.document.body.clientHeight-33 + 'px'); padding-left: 10px; padding-bottom: 10px;" id="divcontent">
		<table id="rpt" align="left">
			<tr>
				<td>
					<table align="center" width="100%" height="100%"
						style="padding-right: 10px; padding-bottom: 10px;">
						<tr>
							<td>
							</td>
						</tr>
					</table>
					</td>
			</tr>
		</table>
		<div style="clear:both;"></div>
		</div>
		<script language="javascript">
						//document.getElementById("t_page_span").innerHTML = report1_getTotalPage();
						//document.getElementById("c_page_span").innerHTML = report1_getCurrPage();
						document.getElementById("divbar").style.width=document.getElementById("divcontent").scrollWidth;
					</script>
</body>
</html>
