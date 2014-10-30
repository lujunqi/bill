<%@page import="com.dodou.inferface.Export"%><%@ page contentType="text/html;charset=utf-8" language="java"%><%@ include file="../../../import.jsp"%><%
	response.setContentType("text/html;charset=utf-8");
	String date = request.getParameter("date");
	response.setHeader("Content-disposition",
			"attachment; filename=mchnt_" + date + ".txt");
	String sql = "select (select temp.term_id1 from term_app_table temp  where temp.apppay_id=a.apppay_id and temp.status = 1  group by temp.term_id1)as term_id1, memo, MARCHANT_NAME, MARCHANT_NAME2, Unit_area, account_bank, mcc18, marchanttype, mcc, Unit_area, bank_name, qingsuanno, lq_rule, account_no, account_name, comm_no, fee_rule1, fee_rule2, fee_content, fee_lev from Apppay_105 a, commercial_info c,ws_area w,bank_info b where appr_date = to_date('"
			+ date
			+ "', 'yyyy-MM-dd') and appr_status = 2 and a.commercial_id =c.commercial_id and w.areaid=c.unit_area and b.bank_code=a.account_bank and (fee_chan = 1 or fee_chan is null)";
	DatabaseAccess dba = new DatabaseAccess();
	ResultSet rs = dba.executeQuery(sql);
	StringBuffer content = new StringBuffer();

	while (rs.next())
	{
		content.append("I,");
		content.append(rs.getString("term_id1").trim() + ",");
		content.append("0848215500,");
		//32域机构代码
		content.append("084821" + rs.getString("memo").trim() + ",");
		//所属平台机构代码
		content.append("0800085500,");
		//商户中文名称
		content.append(rs.getString("MARCHANT_NAME2") + ",");
		//商户中文简称
		content.append(rs.getString("MARCHANT_NAME2") + ",");
		//行政区划代码
		content.append(rs.getString("Unit_area").trim() + ",");
		//内卡结算机构代码
		content.append("08" + rs.getString("account_bank").trim() + ",");
		//交易商户类型
		//TODO 这里要改成mcc18域
		content.append(rs.getString("mcc18") + ",");
		//商户状态
		content.append("1,");
		//受理地区代码
		content.append(rs.getString("memo").trim() + ",");
		content.append("1,0800085500,");
		//商户组别
		content.append(rs.getString("marchanttype").trim() + ",");
		//商户服务类型
		content.append("00,");
		//真实商户类型
		content.append(rs.getString("mcc") + ",");
		//清算地区代码
		content.append(rs.getString("Unit_area").trim() + ",");
		content.append("80000000000000000000,S,156,1,0,0,0,156,0,,,,,     ,9799,0,0,,,,,,,,,,,,,,,");
		//??
		content.append(rs.getString("bank_name").trim() + ",");
		content.append("2,0,0,");
		//开户行清算号
		if (rs.getString("qingsuanno") == null)
		{
			content.append("000,");
		} else
		{
			content.append(rs.getString("qingsuanno").trim() + ",");
		}
		content.append("CS002&CS099&#,0000001000,");
		//分润算法
		//content.append(rs.getFee_rule1()+"&"+rs.getFee_rule2()+"&#,");
		content.append(rs.getString("lq_rule") + ",");
		content.append("1,,1,0010000000,0,1110000000,0,1,0,1,");
		//内卡清算资金账号
		content.append(rs.getString("account_no") + ",");
		//内卡清算资金账户名称
		content.append(rs.getString("account_name") + ",");
		content.append("156,");
		//内卡清算资金开户行清算号
		if (rs.getString("qingsuanno") == null)
		{
			content.append("000,");
		} else
		{
			content.append(rs.getString("qingsuanno").trim() + ",");
		}
		content.append("0,0,");
		//商户营业执照
		content.append(rs.getString("comm_no") + ",");
		content.append("209912,");
		//营业执照号码
		content.append(rs.getString("comm_no") + ",");
		//商户手续费决定索引
		content.append("NK001&" + rs.getString("fee_rule1").trim()
				+ "#TP001&" + rs.getString("fee_rule2").trim() + "#,");
		//开户行机构标识码
		content.append("08" + rs.getString("account_bank").trim() + ",");
		content.append(",,,,,,,,,,");
		if (rs.getString("fee_content") == null)
		{
			content.append("00,");
		} else
		{
			content.append(rs.getString("fee_content") + ",");
		}
		if (rs.getString("fee_lev") == null)
		{
			content.append("0");
		} else
		{
			content.append(rs.getString("fee_lev") + "");
		}
		//终端类型
		content.append(",03,");
		content.append("\n");
	}
	rs.close();
	dba.release();
	Log.getLogger().info(content.toString());
	Export ex = new Export()
	{
		public void initSql(String where)
		{
		}
	};
	ex.release();
	ex.setFileName("导出商户");
	ex.exportLog(session);
	out.print(content);
%>
