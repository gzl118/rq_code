package test;

import com.runqian.report4.usermodel.input.AbstractInputListener;
import com.runqian.report4.usermodel.input.InputSQL;

public class PrintSQLInputListener extends AbstractInputListener {
	
	public void beforeSave()throws Exception {
	}
	
	public void afterSave()throws Exception {
		InputSQL[] abc = this.getInputSql();
		for(int i=0;i<this.getInputSql().length;i++){
			String sql = abc[i].getSql();
			if(sql.matches("insert.*")){
				//这里过滤出来insert语句，取得的语句可以在本类中执行，或用作其它。
				System.out.println("这是insert语句"+sql);
				}else{
					System.out.println("这是update语句"+sql);
				}
		}
	}

}
