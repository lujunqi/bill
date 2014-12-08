package com.szzt.export;

import com.dodou.inferface.Export;
import com.dodou.log.Log;

public class ZeroTerminalLogExport extends Export
{
	public ZeroTerminalLogExport()
	{
		this.setFileName("终端零交易报表");
	}

	public void initSql(String where, String timeLimit)
	{
		StringBuilder sql = new StringBuilder();
		sql.append("select (select a.city from ws_area a where a.areaid = c.unit_area) as 地区, temp.term_id1 as 商户编号, temp.term_id2 as 终端编号, c.trade_name as 商户名称, i.archive_date as 归档时间, i.unit_installed_man as 装机联系人, i.unit_installed_tel as 装机电话,  i.serial1 as 主机序列号, i.serial2 as 键盘序列号  , (select cost.money from temicost cost where cost.cost_type=0 and cost.teminal_info_id=i.teminal_info_id) as 押金");
		sql.append(" from (select m.merchantsno_id, m.teminal_info_id, sum(fee_count) as fee_count");
		sql.append(" from rep_teminal m ").append(
				null == timeLimit ? "" : timeLimit);
		sql.append(" group by m.teminal_info_id, m.merchantsno_id) gain, teminal_info i, apppay_105 m, term_app_table temp, commercial_info c");
		sql.append(" where gain.merchantsno_id=temp.apppay_id and gain.teminal_info_id = temp.teminal_info_id and i.teminal_info_id=temp.teminal_info_id and m.apppay_id=temp.apppay_id and c.commercial_id = temp.commercial_id and gain.fee_count = 0 and i.teminal_status = 13 and i.installed_status=4 and temp.apptype='105' and temp.status=1");
		sql.append(where == null ? "" : where);
		this.setSql(sql.toString());
		Log.getLogger().debug("终端零交易报表:" + this.getSql());
	}

	@Override
	public void initSql(String where)
	{

	}

}
