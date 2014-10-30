package com.dodou.dao;
import java.sql.ResultSet;

import com.dodou.db.DatabaseAccess;
import com.dodou.log.Log;
import com.dodou.table.Commercial_LqRule;
import com.dodou.util.CreatePage;
public class Commercial_LqRuleDao extends CreatePage{
public Commercial_LqRule[] select() throws Exception {
String sql = "select * from COMMERCIAL_LQRULE order by RULEID desc";
return this.select(sql);
}
public Commercial_LqRule[] select(String sql)throws Exception
{
	Commercial_LqRule[] commercial_LqRules = new Commercial_LqRule[getPageSize()];
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
		Commercial_LqRule commercial_LqRule = new Commercial_LqRule();
		commercial_LqRule.setLqRuleId(rs.getString("RULEID"));
		commercial_LqRule.setLqRuleName(rs.getString("RULENAME"));
		commercial_LqRules[j++] = commercial_LqRule;
	}
	Log.getLogger().debug("查询记录总数为:"+this.getTotalCount());
	rs.close();
	dba.release();
	return commercial_LqRules;
}

}
