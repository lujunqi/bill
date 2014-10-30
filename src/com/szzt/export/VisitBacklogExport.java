package com.szzt.export;

import java.sql.ResultSet;

import com.dodou.inferface.Export;
import com.szzt.dao.AssignOrderDao;
import com.szzt.model.VisitBacklogModel;

public class VisitBacklogExport extends Export
{
	public VisitBacklogExport()
	{
		this.setFileName("回访报表");
	}

	@Override
	public void initSql(String where)
	{
		StringBuffer sql = new StringBuffer("select ");
		sql.append(" TEMINAL_INFO_VISIT_CALL_ID as ID,");
		sql.append(" VISIT_DATE as 回访日期,");
		sql.append(" (select OPERMAN_NAME from OPERMAN_INFO o where VISIT_MAN=o.OPERMAN_ID) as 回访人,");
		sql.append(" DEMO as 备注,");

		sql.append(" (case has_col10 when 1 then '是' else '否' end ) as 电话是否接通,");
		sql.append(" (case has_col1 when 1 then '是' else '否' end ) as 装机时间是否与登记一致,");
		sql.append(" (case has_col2 when 1 then '是' else '否' end ) as 银行卡受理知识培训,");
		sql.append(" (case has_col3 when 1 then '是' else '否' end )as 是否知道信用卡必须核对签名,");
		sql.append(" (case has_col4 when 1 then '是' else '否' end ) as POS签购单保留一年,");
		sql.append(" (case has_col5 when 1 then '是' else '否' end ) as 核对押金收取金额是否一致,");
		sql.append(" (case has_col6 when 1 then '是' else '否' end ) as 是否向商户出具正规的押金收据,");
		sql.append(" (case has_col7 when 1 then '是' else '否' end ) as 是否对我们公司目前的服务满意,");
		sql.append("(select UNIT_INSTALLED_ADD from  TEMINAL_INFO t where t.TEMINAL_INFO_ID=a.TEMINAL_INFO_ID)  as 装机地址");
		sql.append(" from TEMINAL_INFO_VISIT_CALL ").append(" a ");
		sql.append(where == null ? "" : where);
		sql.append(" order by TEMINAL_INFO_VISIT_CALL_ID asc");
		this.setSql(sql.toString());
		System.out.println(this.getSql());
	}

}
