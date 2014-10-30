package com.szzt.export;

import com.dodou.inferface.Export;
import com.dodou.log.Log;

public class UnReceiveBaseMoneyExport extends Export
{
	public UnReceiveBaseMoneyExport()
	{
		this.setFileName("代收押金报表");
	}

	@Override
	public void initSql(String where)
	{
		StringBuilder sql = new StringBuilder();
		sql.append("select fax.id as 序号, temp.term_id1 as 商户编号, comm.unit_name as 客户名称, fax.in_time as 发票开出时间, (select cost.money from Temicost cost where cost.cost_type = 0 and cost.teminal_info_id = temp.teminal_info_id) as 押金 ");
		sql.append(" from Commercial_Info comm, term_app_table temp, (select * from TEMICOST_HIS t ");
		sql.append(" where t.id not in (select trim(s.fld_48) from secu_depo s)) fax where temp.status = 1 and comm.commercial_id = temp.commercial_id and temp.apptype = '105' and temp.teminal_info_id = fax.teminal_info_id");
		sql.append(where == null ? "" : where);
		this.setSql(sql.toString());
		Log.getLogger().debug("代收押金:" + this.getSql());
	}
}
