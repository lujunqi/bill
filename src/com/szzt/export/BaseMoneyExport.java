package com.szzt.export;

import com.dodou.inferface.Export;
import com.dodou.log.Log;

public class BaseMoneyExport extends Export
{
	public BaseMoneyExport()
	{
		this.setFileName("押金报表");
	}

	@Override
	public void initSql(String where)
	{
		StringBuilder sql = new StringBuilder();
		sql.append("select t.fld_13  as 日期, t.fld_12  as 时间, t.shop_nm as 上送终端名称, t.amt   as 押金金额, t.fld_48  as 记账联号, t.fld_57  as PSAM卡号, t.sales_man as 拓展人, t.unit_area as 地区, t.unit_name as 客户名称, t.term_id1 as 商户编号 ");
		sql.append(" from (select t.*, m.*, substr(t.fld_48, 16, 8) as terminalsno, (t.fld_4 / 100) as amt from SECU_DEPO t ");
		sql.append(" left join (select (select o.operman_name from operman_info o ");
		sql.append(" where o.operman_id = m.e_id) as sales_man, c.unit_area, temp.term_id1, c.unit_name from Apppay_105      m, commercial_info c, Term_App_Table  temp ");
		sql.append("where temp.commercial_id = c.commercial_id and m.commercial_id = c.commercial_id and temp.apppay_id = m.apppay_id) m on m.term_id1 = substr(t.fld_48, 0, 15)) t where 1 = 1 ");
		sql.append(where == null ? "" : where);
		this.setSql(sql.toString());
		Log.getLogger().debug("押金sql:" + this.getSql());
	}
}
