package com.dodou.dao;
import java.sql.ResultSet;

import com.dodou.db.DatabaseAccess;
import com.dodou.log.Log;
import com.dodou.table.Commercial_FeeRule;
import com.dodou.util.CreatePage;
public class Commercial_FeeRuleDao extends CreatePage{
public Commercial_FeeRule[] select() throws Exception {
String sql = "select * from COMMERCIAL_FEERULE order by FEERULEID desc";
return this.select(sql);
}
public Commercial_FeeRule[] select(String sql)throws Exception
{
	Commercial_FeeRule[] commercial_FeeRules = new Commercial_FeeRule[getPageSize()];
	Log.getLogger().debug("Post_info [查找],SQL:["+sql+"]");
	DatabaseAccess dba = new DatabaseAccess() ;
	ResultSet rs = dba.executeQuery(sql);
	rs.last();
	this.setTotalCount(rs.getRow());
	rs.first();
	int j=0;
	for (int i = this.getStart(); i < this.getEnd(); i++) 
	{
		if (this.getTotalCount()==0)
			break;
		rs.absolute(i + 1);
		Commercial_FeeRule commercial_FeeRule = new Commercial_FeeRule();
		commercial_FeeRule.setFeeRuleId(rs.getString("feeRuleId"));
		commercial_FeeRule.setFeeRuleName(rs.getString("feeRuleName"));
		commercial_FeeRules[j++] = commercial_FeeRule;
	}
	Log.getLogger().debug("查询记录总数为:"+this.getTotalCount());
	rs.close();
	dba.release();
	return commercial_FeeRules;
}

}
