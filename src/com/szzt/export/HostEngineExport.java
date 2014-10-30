package com.szzt.export;

import com.dodou.inferface.Export;

public class HostEngineExport extends Export
{
	public HostEngineExport()
	{
		this.setFileName("主机报表");
	}

	@Override
//	public void initSql(String where)
//	{
//		StringBuffer sql = new StringBuffer("select ");
//		sql.append("t.host_no as 主机序列号").append(",");
//		sql.append(
//				"(select ar.city from ws_area ar where ar.areaid = t.area) as 地区")
//				.append(",");
//		sql.append(
//				" case when (case when exists (select i.serial1  from teminal_info i  where  Upper(i.serial1)=Upper(t.host_no) ) then 2 else 1 end) = 1 then '仓库中' else '商户处'end as 状态")
//				.append(",");
//		sql.append("t.in_time as 入库时间").append(",");
//		sql.append(" com.unit_name as 商户名称").append(",");
//		sql.append(" temp.term_id1 as 商户编号").append(",");
//		sql.append("    '已使用' as 使用状态");
//		sql.append(" from ");
//		sql.append("TEMINAL_INFO_KEY t").append(",");
//		sql.append(" Commercial_Info  com").append(",");
//		sql.append(" term_app_table   temp").append(",");
//		sql.append(" teminal_info     ter");
//		sql.append(" where ");
//		sql.append("temp.commercial_id = com.commercial_id").append(" and ");
//		sql.append("ter.commercial_id = com.commercial_id").append(" and ");
//		sql.append(" ter.teminal_status = 13").append(" and ");
//		sql.append(" ter.installed_status = 4").append(" and ");
//		sql.append("temp.teminal_info_id = ter.teminal_info_id")
//				.append(" and ");
//		sql.append(" Upper(ter.serial1)=Upper(t.host_no) ");
//		sql.append(where == null ? "" : where);
//
//		// 未使用
//		sql.append(" union all ");
//		sql.append("select t.host_no as 主机序列号").append(",");
//		sql.append(
//				"(select ar.city from ws_area ar where ar.areaid = t.area) as 地区")
//				.append(",");
//		sql.append(" '仓库中' as 状态").append(",");
//		sql.append("t.in_time as 入库时间").append(",");
//		sql.append(" '无' as 商户名称").append(",");
//		sql.append(" '无' as 商户编号").append(",");
//		sql.append("    '未使用' as 使用状态");
//		sql.append(" from ");
//		sql.append("TEMINAL_INFO_KEY t").append(",");
//		sql.append(" teminal_info     ter");
//		sql.append(" where ");
//		sql.append(" Upper(ter.serial1)=Upper(t.host_no) ").append(" and ");
//		sql.append("(ter.teminal_status != 13 or ");
//		sql.append("(ter.installed_status = 0 and ter.teminal_status = 13)) ");
//		sql.append(where == null ? "" : where);
//		// 不在终端表的
//		sql.append(" union all ");
//		sql.append("select t.host_no as 主机序列号").append(",");
//		sql.append(
//				"(select ar.city from ws_area ar where ar.areaid = t.area) as 地区")
//				.append(",");
//		sql.append(" '仓库中' as 状态").append(",");
//		sql.append("t.in_time as 入库时间").append(",");
//		sql.append(" '无' as 商户名称").append(",");
//		sql.append(" '无' as 商户编号").append(",");
//		sql.append("    '未使用' as 使用状态");
//		sql.append(" from ");
//		sql.append("TEMINAL_INFO_KEY t ");
//		sql.append(" where ");
//		sql.append("  Upper(t.host_no) not in (select Upper(tt.serial1) from Teminal_Info tt) ");
//		sql.append(where == null ? "" : where);
//
//		this.setSql(sql.toString());
//		System.out.println(this.getSql());
//	}
	public void initSql(String where)
	{
		StringBuffer sql = new StringBuffer("select ");
		sql.append("t.host_no as 主机序列号").append(",");
		sql.append(
				"(select ar.city from ws_area ar where ar.areaid = t.area) as 地区")
				.append(",");
		sql.append(
				" case when (case when exists (select i.serial1  from teminal_info i  where  Upper(i.serial1)=Upper(t.host_no) ) then 2 else 1 end) = 1 then '仓库中' else '商户处'end as 状态")
				.append(",");
		sql.append("t.in_time as 入库时间").append(",");
		sql.append(" com.unit_name as 商户名称").append(",");
		sql.append(" temp.term_id1 as 商户编号").append(",");
		sql.append("    '已使用' as 使用状态");
		sql.append(" from ");
		sql.append("TEMINAL_INFO_KEY t").append(",");
		sql.append(" Commercial_Info  com").append(",");
		sql.append(" term_app_table   temp").append(",");
		sql.append(" teminal_info     ter");
		sql.append(" where ");
		sql.append("temp.commercial_id = com.commercial_id").append(" and ");
		sql.append("ter.commercial_id = com.commercial_id").append(" and ");
		sql.append(" ter.teminal_status = 13").append(" and ");
		sql.append(" ter.installed_status = 4").append(" and ");
		sql.append("temp.teminal_info_id = ter.teminal_info_id")
				.append(" and ");
		sql.append(" Upper(ter.serial1)=Upper(t.host_no) ");
		sql.append(where == null ? "" : where);

		// 未使用
		sql.append(" union all ");
		sql.append("select t.host_no as 主机序列号").append(",");
		sql.append(
				"(select ar.city from ws_area ar where ar.areaid = t.area) as 地区")
				.append(",");
		sql.append(" '仓库中' as 状态").append(",");
		sql.append("t.in_time as 入库时间").append(",");
		sql.append(" '无' as 商户名称").append(",");
		sql.append(" '无' as 商户编号").append(",");
		sql.append("    '未使用' as 使用状态");
		sql.append(" from ");
		sql.append("TEMINAL_INFO_KEY t").append(",");
		sql.append(" teminal_info     ter");
		sql.append(" where ");
		sql.append(" Upper(ter.serial1)=Upper(t.host_no) ").append(" and ");
		sql.append("(ter.teminal_status != 13 or ");
		sql.append("(ter.installed_status = 0 and ter.teminal_status = 13)) ");
		sql.append(where == null ? "" : where);
		// 不在终端表的
		sql.append(" union all ");
		sql.append("select t.host_no as 主机序列号").append(",");
		sql.append(
				"(select ar.city from ws_area ar where ar.areaid = t.area) as 地区")
				.append(",");
		sql.append(" '仓库中' as 状态").append(",");
		sql.append("t.in_time as 入库时间").append(",");
		sql.append(" '无' as 商户名称").append(",");
		sql.append(" '无' as 商户编号").append(",");
		sql.append("    '未使用' as 使用状态");
		sql.append(" from ");
		sql.append("TEMINAL_INFO_KEY t ");
		sql.append(" where ");
		sql.append("  Upper(t.host_no) not in (select Upper(tt.serial1) from Teminal_Info tt) ");
		sql.append(where == null ? "" : where);

		this.setSql(sql.toString());
		System.out.println(this.getSql());
	}
}
