package com.szzt.export;

import com.dodou.inferface.Export;
import com.dodou.log.Log;

/**
 * 商户月报表
 * 
 * @author 陈孟琳
 * 
 */
public class CommercialMonthLogExport extends Export
{
	public CommercialMonthLogExport()
	{
		this.setFileName("商户月报表");
	}

	@Override
	public void initSql(String where)
	{
		StringBuilder builder = new StringBuilder();
		builder.append("select count1.sumCount     as 年交易笔数, count1.sumAmt       as 年交易金额, count1.sumFee       as 年商户手续费, count1.sumGain      as 年通联收益, count1.sumTotalGain as 年总收益, gain.serv_lev       as 商户登记, area.CITY           as 地区, (select i.channel_name from channel_info i where i.channel_id= m.ec_id)    as 拓展渠道, temp.term_id1       as 商户编号, c.trade_name        as 商户名称, m.MCC, gain.POS_COUNT      as 机具台数, gain.FEE_COUNT      as 交易笔数, gain.FEE_AMOUNT     as 交易金额, gain.FEE            as 商户手续费, gain.GAIN           as 通联收益, gain.TOTAL_GAIN     as 通联总收益, gain.TOTAL_DATE     as 统计日期");
		builder.append(" from REP_TOTAL_GAIN_MON gain, Apppay_105 m, WS_AREA area, commercial_info c, channel_info i, (select sum(FEE_COUNT) as sumCount, MERCHANTSNO_ID, sum(FEE_AMOUNT) as sumAmt, sum(FEE) as sumFee, sum(GAIN) as sumGain, sum(TOTAL_GAIN) as sumTotalGain from REP_TOTAL_GAIN_MON");
		builder.append(" where to_char(trunc(sysdate), 'yy') = substr(TOTAL_DATE, 1, 2) group by MERCHANTSNO_ID) count1, (select temp.apppay_id, temp.commercial_id, temp.term_id1 from term_app_table temp where temp.apptype = '105' and temp.status = 1 group by temp.apppay_id, temp.commercial_id, temp.term_id1) temp where gain.merchantsno_id = temp.apppay_id and gain.commercial_id = temp.commercial_id and m.apppay_id = temp.apppay_id and c.commercial_id = temp.commercial_id and area.AREAID = c.UNIT_AREA and count1.MERCHANTSNO_ID = temp.apppay_id  ");
		builder.append(where==null?"":where);
		this.setSql(builder.toString());
		Log.getLogger().debug("商户月报表：" + this.getSql());
	}
}
