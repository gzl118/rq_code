<%@ page contentType="text/html;charset=GBK"%>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.runqian.report4.usermodel.Context"%>

<html>
<head>
<link type="text/css" href="css/style.css" rel="stylesheet" />
<link href="./printarea/PrintArea.css" rel="stylesheet" />
    <script src="./printarea/jquery-2.1.0.js"></script>
    <script src="./print/jQuery.print.min.js"></script>
    <script type="text/javascript">
        function printareareport() {
			splittable();
            //$("#divcontent").printArea();
			$("#divcontent").print(
                {
                    iframe: true,
                    prepend: '',
                    append: '',
                    deferred: $.Deferred().done(function () {
                        reset();
                    }).fail(function () {
                        reset();
                    })
                }
            );
        }
		function splittable(){
			var trs=$("#report1").find("tr");
			var colg=$("#report1").find("colgroup")[0];
			var str1=$(colg).prop("outerHTML");
			var tb1='<div class="dtemp"><table style="width: 1740px; table-layout: fixed; border-collapse: collapse;">'+str1;			
			var tb2='<div class="dtemp" style="page-break-after: always;page-break-inside: avoid;padding-top:25px;"><table style="width: 1740px; table-layout: fixed; border-collapse: collapse;">'+str1;
			//alert(trs.length);
			$.each(trs,function(i,item){
				var str=$(item).prop("outerHTML");
				if(i<54){
						tb1+=str;
					}
					else{
						tb2+=str;
					}
			});
			tb1+="</table></div>";
			tb2+="</table></div>";
			$("#report1").css("display","none");
			$("#divcontent").append(tb1);
			$("#divcontent").append(tb2);
		}
		function reset(){
			$("#report1").css("display","visible");
			$("#divcontent").find(".dtemp").remove();
		}
    </script>
</head>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0
	style="">
	<%
	request.setCharacterEncoding( "GBK" );
	String report = request.getParameter( "raq" );
	String reportFileHome=Context.getInitCtx().getMainDir();
	StringBuffer param=new StringBuffer();
	
	//保证报表名称的完整性
	int iTmp = 0;
	if( (iTmp = report.lastIndexOf(".raq")) <= 0 ){
		report = report + ".raq";
		iTmp = 0;
	}
	
	Enumeration paramNames = request.getParameterNames();
	if(paramNames!=null){
		while(paramNames.hasMoreElements()){
			String paramName = (String) paramNames.nextElement();
			String paramValue=request.getParameter(paramName);
			if(paramValue!=null){
				//把参数拼成name=value;name2=value2;.....的形式
				param.append(paramName).append("=").append(paramValue).append(";");
			}
		}
	}

	//以下代码是检测这个报表是否有相应的参数模板
	String paramFile = report.substring(0,iTmp)+"_arg.raq";
	File f=new File(application.getRealPath(reportFileHome+ File.separator +paramFile));

%>
	<jsp:include page="toolbar.jsp" flush="false" />
	<div
		style=" height: expression(parent.document.body.clientHeight-33 + 'px'); padding-left: 10px; padding-bottom: 10px;" id="divcontent">
		<table id="rpt" align="left">
			<tr>
				<td>
					<%	//如果参数模板存在，则显示参数模板
	if( f.exists() ) {
	%>
					<table id="param_tbl" width="100%" height="100%">
						<tr>
							<td><report:param name="form1"
									paramFileName="<%=paramFile%>" needSubmit="no"
									params="<%=param.toString()%>" /></td>
							<td><a href="javascript:_submit( form1 )"><img
									src="../images/search.gif" border=no
									style="vertical-align: middle"></a></td>
						</tr>
					</table> <% }
%>

					<table align="center" width="100%" height="100%"
						style="padding-right: 10px; padding-bottom: 10px;">
						<tr>
							<td><report:html name="report1" reportFileName="<%=report%>"
									funcBarLocation="top" needPageMark="yes" generateParamForm="no"
									params="<%=param.toString()%>" needPivot="no" pivotLabel=""
									exceptionPage="/reportJsp/myError2.jsp" excelPageStyle="0" pdfExportStyle="graph,0"
									appletJarName="runqianReport4Applet.jar,dmGraphApplet.jar"
									pageMarkLabel="" firstPageLabel="" prevPageLabel=""
									nextPageLabel="" lastPageLabel="" needPrint="no" submit="" />
							</td>
						</tr>
					</table>
					</td>
			</tr>
		</table>
		<div style="clear:both;"></div>
		</div>
		<script language="javascript">
						//设置分页显示值
						//document.getElementById("t_page_span").innerHTML = report1_getTotalPage();
						//document.getElementById("c_page_span").innerHTML = report1_getCurrPage();
						document.getElementById("divbar").style.width=document.getElementById("divcontent").scrollWidth;
					</script>
</body>
</html>
