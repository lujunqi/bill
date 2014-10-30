package com.szzt.export;

import com.dodou.inferface.Export;
import com.dodou.log.Log;

public class TaiZhangExport extends Export
{
	public TaiZhangExport()
	{
		super.setFileName("台账报表");
	}

	@Override
	public void initSql(String where)
	{
	}

	public void initSql(String where, int apptype)
	{
		StringBuilder sql = new StringBuilder();
		sql.append(
				"select m.apppay_id as 业务序号,  i.teminal_info_id as 终端序号,(select a.city from ws_area a where a.areaid = c.unit_area) as 客户地区,(select chanel.channel_name from CHANNEL_INFO chanel where chanel.channel_id = m.ec_id) as 拓展渠道,")
				.append(" (select o.operman_name from operman_info o  where o.operman_id = m.e_id) as 拓展人,");
		if (apptype == 101)
		{
			sql.append(" '实名支付' as 开通业务,");
		} else if (apptype == 103)
		{
			sql.append(" '便捷付' as 开通业务,").append("");
		} else if (apptype == 105)
		{
			sql.append(" '收单' as 开通业务,").append(" m.ec_branch as 推荐支行,")
					.append("m.ec_branch_name as 推荐人员,");
		}
		sql.append(" m.contract_fee as 扣率,");
		sql.append(
				"(select o.operman_name  from operman_info o  where o.operman_id = c.input_user_id) as 录入人员, c.unit_name as 客户单位名称,  to_char(m.input_date, 'yyyy-MM-dd hh24:mi:ss') as 录入时间, case  when m.appr_status = 0 then           '新业务入网审批中'          when m.appr_status = 2 then           '审批通过'          when m.appr_status = 1 then           '审批未通过'          when m.appr_status = 3 then           '新增终端审批中'          when m.appr_status = 4 then           '账户变更审批中'          else           m.appr_status || ''        end as 业务状态, ")
				.append(" to_char(m.appr_date, 'yyyy-MM-dd') as 审批时间, (select temicost.refunddate  from Temicost temicost          where temicost.teminal_info_id = i.teminal_info_id            and temicost.cost_type = 0) as 押金收取时间,  (select o.operman_name  from operman_info o    where o.operman_id = i.inst_man) as 装机人,        (select o.operman_name           from operman_info o          where o.operman_id = i.safe_man) as 维护人,        CASE          WHEN i.teminal_status = 1 THEN           '审批中'          WHEN i.teminal_status = 2 THEN           '部分审批完成'          WHEN i.teminal_status = 3 THEN           '全部审批完成'          WHEN i.teminal_status = 4 THEN           '装机中'          WHEN i.teminal_status = 5 THEN           '调试完成'          WHEN i.teminal_status = 6 THEN           '已撤机'          WHEN i.teminal_status = 7 THEN           '暂缓'          WHEN i.teminal_status = 8 THEN   '未装'   WHEN i.teminal_status = 13 and i.installed_status = 4 THEN           '装机归档'          WHEN i.teminal_status = 13 and i.installed_status = 0 THEN           '取消装机归档'              WHEN i.teminal_status = 13 and i.installed_status = 5 THEN           '未调试'  WHEN i.teminal_status = 15 THEN           '整改'          ELSE           '未知'        END as 终端状态,        temp.term_id1 as 商户编号,        temp.term_id2 as 终端编号,        m.account_name,        m.account_no,        (select b.bank_name           from bank_info b          where b.bank_code = m.account_bank),        c.unit_add as 客户单位地址,        c.comm_ad as 工商营业执照地址,        c.contact_name_1 as 单位联系人,        c.contact_tel_1 as 移动电话,        c.contact_tel_2 as 固定电话,        (select temicost.money           from Temicost temicost          where temicost.teminal_info_id = i.teminal_info_id            and temicost.cost_type = 0) as 押金,        (select temicost.costnumber           from Temicost temicost          where temicost.teminal_info_id = i.teminal_info_id            and temicost.cost_type = 0) as 押金联号,        (select temicost.money           from Temicost temicost          where temicost.teminal_info_id = i.teminal_info_id            and temicost.cost_type = 1) as 服务费,        (select temicost.money           from Temicost temicost          where temicost.teminal_info_id = i.teminal_info_id            and temicost.cost_type = 2) as 通讯费,        case          when i.equi_type = 0 then           '普通POS'          when i.equi_type = 1 then           '移动POS'          when i.equi_type = 2 then           '分体POS'          when i.equi_type = 3 then           '其他类型POS'        end as 机具类型,        case i.teminal_product          when 0 then           '通联产权'          when 0 then           '银行产权'          when 0 then           '代理商产权'        end as 产权,        i.serial1 as 主机序号,        i.serial2 as 键盘序号,        i.remark_info as 备注   from teminal_info i, Apppay_")
				.append(apptype)
				.append(" m, commercial_info c, Term_App_Table temp")
				.append(" where temp.commercial_id = c.commercial_id    and i.teminal_info_id = temp.teminal_info_id    and m.commercial_id = c.commercial_id    and temp.apppay_id = m.apppay_id    and temp.apptype = '")
				.append(apptype).append("' ");
		sql.append(where == null ? "" : where);
		this.setSql(sql.toString());
		Log.getLogger().debug("台账sql:" + this.getSql());
	}
}
