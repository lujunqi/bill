package com.szzt.export;

import com.dodou.inferface.Export;
import com.dodou.log.Log;

/**
 * 商户日报表
 * 
 * @author 陈孟琳
 * 
 */
public class CommercialDayLogExport extends Export
{
	public CommercialDayLogExport()
	{
		this.setFileName("商户日报表");
	}

	@Override
	public void initSql(String where)
	{
		StringBuilder builder = new StringBuilder();
		builder.append("select count1.sumCount as 年交易笔数,");
		builder.append(" count1.sumAmt as 年交易金额,");
		builder.append("count1.sumFee as 年手续费,");
		builder.append("count1.sumGain as 年通联收益,");
		builder.append(" area.CITY as 地区,");
		builder.append("  (select channel.channel_name from channel_info channel where channel.channel_id= merch.ec_id)  as 拓展渠道,");
		builder.append("temp.term_id1 as 商户编号,");
		builder.append("c.unit_name as 客户单位名称,");
		builder.append("merch.MCC,");
		builder.append("gain.FEE_COUNT as 交易笔数,");
		builder.append(" gain.FEE_AMOUNT as 交易金额,");
		builder.append("  gain.FEE as 商户手续费,");
		builder.append(" gain.GAIN as 通联收益,");
		builder.append(" gain.TOTAL_DATE as 统计日期");
		builder.append("  from REP_MERCHANT gain,        Apppay_105 merch,        (select temp.commercial_id,temp.apppay_id,temp.term_id1 from term_app_table temp where  temp.status=1 and  temp.apptype='105'  group by temp.commercial_id,temp.apppay_id,temp.term_id1) temp,        WS_AREA area,        commercial_info c,        (select sum(FEE_COUNT) as sumCount,                MERCHANTSNO_ID,                sum(FEE_AMOUNT) as sumAmt,                sum(FEE) as sumFee,                sum(GAIN) as sumGain           from REP_MERCHANT          where to_char(trunc(sysdate), 'yy') = substr(TOTAL_DATE, 1, 2)          group by MERCHANTSNO_ID) count1");
		builder.append(" where  gain.customer_id=temp.commercial_id  and gain.merchantsno_id=temp.apppay_id  and merch.apppay_id=temp.apppay_id  and count1.MERCHANTSNO_ID = temp.apppay_id  and c.commercial_id=temp.commercial_id  and area.AREAID = c.UNIT_AREA  and merch.APPR_STATUS = 2");
		builder.append(null == where ? "" : where);
		this.setSql(builder.toString());
		Log.getLogger().debug("商户日报表:" + this.getSql());

	}

}
