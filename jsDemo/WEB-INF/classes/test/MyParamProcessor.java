package test;
import java.sql.*;
import com.runqian.report4.usermodel.input.*;
public class MyParamProcessor extends AbstractParamProcessor {
	public void process() throws Exception {
		
		boolean canEdit = false;
		Connection con = null;
		Statement stmt = null;
		try {
			// 获取缺省数据库连接
			con = context.getConnectionFactory(context.getDefDataSourceName())
					.getConnection();
			String empID = getParamValue("empID");
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * from 雇员 where 雇员ID='"+empID+"'");
			if(rs.next()){
				//判断本用户是否已经接受审核
				String isMODITY = rs.getString("ISMODITY");
				if("1".equals( isMODITY ))
					canEdit = false;
				
			}
		} finally {
			try {
				System.out.println("canEdit=========>"+canEdit);
				if(stmt != null)
					stmt.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}
		if (!canEdit) {
			throw new Exception("该填报表已经接受审核，不可修改!");
		}
	}
}
