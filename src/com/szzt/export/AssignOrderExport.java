package com.szzt.export;

import java.sql.ResultSet;

import com.dodou.inferface.Export;
import com.szzt.dao.AssignOrderDao;

public class AssignOrderExport extends Export
{
	public AssignOrderExport()
	{
		this.setFileName("派单报表");
	}

	@Override
	public void initSql(String where)
	{
		StringBuffer sql = new StringBuffer("select ");
		sql.append(" COMP_ID as ID,");
		sql.append(" UNIT_NAME as 客户单位名称,");
		sql.append(" COMP_TYPE as 投诉类型,");
		sql.append(" COMP_CONT as 投诉内容,");
		sql.append(" (select OPERMAN_NAME from OPERMAN_INFO o where INPUT_MAN=o.OPERMAN_ID) 录入人员,");
		sql.append(" (select OPERMAN_NAME from OPERMAN_INFO o where SAFE_MAN=o.OPERMAN_ID) 维护人员,");
		sql.append(" SOLVE_CONT as 解决反馈,");
		sql.append("(case COMP_STATUS when 1 then '未解决' else '已解决' end ) as 解决状态,");
		sql.append(" COMP_DATE as 派单时间,");
		sql.append(" CHANGE_DATE as 修改时间,");
		sql.append(" CONNECTMAN as 联系人,");
		sql.append(" CONNECTTEL as 联系电话,");
		sql.append("(select UNIT_INSTALLED_ADD from  TEMINAL_INFO t where t.TEMINAL_INFO_ID=a.TEMINAL_INFO_ID)  as 装机地址");
		sql.append(" from " + AssignOrderDao.TABLE).append(" a ");
		sql.append(where == null ? "" : where);
		sql.append(" order by COMP_ID asc");
		this.setSql(sql.toString());
		System.out.println(this.getSql());
	}

}
