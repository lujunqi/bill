package com.szzt.export;

import com.dodou.inferface.Export;
import com.dodou.log.Log;

public class TerminalDayLogExport extends Export
{

	public TerminalDayLogExport()
	{
		this.setFileName("终端日报表");
	}

	@Override
	public void initSql(String where)
	{
		StringBuilder sql = new StringBuilder();
		sql.append("select count1.sumCount as 年交易笔数,");
		sql.append("count1.sumAmt as 年交易金额,");
		sql.append(" count1.sumFee as 年手续费,");
		sql.append("  count1.sumGain as 年通联收益,");
		sql.append(" tergain.FEE_COUNT as 交易笔数,");
		sql.append("   tergain.FEE_AMOUNT as 交易金额,");
		sql.append(" tergain.FEE as 商户手续费,");
		sql.append(" tergain.GAIN as 通联收益,");
		sql.append(" tergain.TOTAL_DATE as 统计日期,");
		sql.append(" ter.teminal_product as 机具产权,");
		sql.append("ter.UNIT_INSTALLED_ADD as 机具安装地址,");
		sql.append(" ter.UNIT_INSTALLED_MAN as 机具安装人,");
		sql.append("ter.UNIT_INSTALLED_TEL as 安装人联系电话,");
		sql.append(" to_char(ter.ARCHIVE_DATE, 'yyyy-mm-dd') as 归档时间,");
		sql.append("(select o.OPERMAN_NAME   from operman_info o  where o.OPERMAN_ID = ter.debug_man) as 调试人,");
		sql.append(" (select o.OPERMAN_NAME           from operman_info o          where o.OPERMAN_ID = ter.inst_man)  as 装机人,        temp.term_id2 as 终端编号,");
		sql.append("  (select ar.city from Ws_Area ar where ar.areaid=comm.unit_area)  as 客户所在地区,");
		sql.append(" temp.term_id1 as 商户编号,");
		sql.append(" comm.TRADE_NAME as 商户对外营业名称,");
		sql.append("comm.COMM_NAME as 营业执照名称");
		sql.append("   from REP_TEMINAL tergain,        TEMINAL_INFO ter,        COMMERCIAL_INFO comm,        Apppay_105 merch,        ws_area area,        term_app_table temp,        (select sum(FEE_COUNT) as sumCount,                TEMINAL_INFO_ID,                sum(FEE_AMOUNT) as sumAmt,                sum(FEE) as sumFee,                sum(GAIN) as sumGain           from REP_TEMINAL          where to_char(trunc(sysdate), 'yy') = substr(TOTAL_DATE, 1, 2)          group by TEMINAL_INFO_ID) count1");
		sql.append("  where        merch.apppay_id=temp.apppay_id        and ter.teminal_info_id=temp.teminal_info_id        and comm.commercial_id=temp.commercial_id     and tergain.TEMINAL_INFO_ID = temp.teminal_info_id    and count1.TEMINAL_INFO_ID = temp.teminal_info_id    and tergain.COMMERCIAL_ID=temp.commercial_id    and  temp.status=1 and temp.apptype='105' and merch.APPR_STATUS = 2 and comm.UNIT_AREA = area.AREAID  and ter.teminal_status=13 and ter.installed_status=4 ");
		sql.append(where == null ? "" : where);
		this.setSql(sql.toString());
		Log.getLogger().debug("终端日报表导出:" + this.getSql());
	}

}
