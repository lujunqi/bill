<%@page import="com.dodou.inferface.Export"%><%@ page	contentType="text/html;charset=utf-8" language="java"%><%@ include	file="../../../import.jsp"%><%
    response.setContentType("text/html;charset=utf-8");
    String date = request.getParameter("date");
    response.setHeader("Content-disposition",
		    "attachment; filename=mchnt_" + date + ".txt");
    String sql = 
"select (select temp.term_id3\n" +
"          from term_app_table temp\n" + 
"         where temp.apppay_id = a.apppay_id\n" + 
"           and temp.status = 1\n" + 
"         group by temp.term_id3) as term_id3,\n" + 
"       a.unit_no,\n" + 
"       memo,\n" + 
"       (select max(c5) from back_type where c1 = a.account_bank_id) as c5,\n" + 
"       com_code,\n" + 
"       c.unit_name,\n" + 
"       REPLACE(TRANSLATE(c.unit_add,\n" + 
"                             '+-*/\\=~\\!@\\#$%^&<>,.;；\\:''\"\\\\|[]（）{}()，`',\n" + 
"                             ' '),\n" + 
"                   ' ',\n" + 
"                   '') as unit_add,\n" + 
"       a.account_bank_brach,\n" + 
"       a.account_bank_id,\n" + 
"       c.legal_id_card,\n" + 
"       c.legaler_name,\n" + 
"       c.contact_name_1,\n" + 
"       a.account_type,\n" + 
"       MARCHANT_NAME,\n" + 
"       MARCHANT_NAME2,\n" + 
"       REPLACE(TRANSLATE(c.contact_tel_1,\n" + 
"                             '+-*/\\=~\\!@\\#$%^&<>,.;；\\:''\"\\\\|[]（）{}()，`',\n" + 
"                             ' '),\n" + 
"                   ' ',\n" + 
"                   '') as contact_tel_1,\n" + 
"       REPLACE(TRANSLATE(c.contact_tel_2,\n" + 
"                             '+-*/\\=~\\!@\\#$%^&<>,.;；\\:''\"\\\\|[]（）{}()，`',\n" + 
"                             ' '),\n" + 
"                   ' ',\n" + 
"                   '') as contact_tel_2,\n" + 
"       Unit_area,\n" + 
"       account_bank,\n" + 
"       mcc18,\n" + 
"       marchanttype,\n" + 
"       mcc,\n" + 
"       Unit_area,\n" + 
"       bank_name,\n" + 
"       qingsuanno,\n" + 
"       lq_rule,\n" + 
"       account_no,\n" + 
"       account_name,\n" + 
"       comm_no,\n" + 
"       fee_rule1,\n" + 
"       fee_rule2,\n" + 
"       fee_content,\n" + 
"       fee_lev\n" + 
"  from Apppay_105 a, commercial_info c, ws_area w, bank_info b\n" + 
" where to_char(appr_date, 'yyyy-MM-dd') = '"+date+"'\n" + 
"   and appr_status = 2\n" + 
"   and a.commercial_id = c.commercial_id\n" + 
"   and w.areaid = c.unit_area\n" + 
"   and b.bank_code = a.account_bank\n" + 
"   and (fee_chan = 1 or fee_chan is null)";



    DatabaseAccess dba = new DatabaseAccess();
    ResultSet rs = dba.executeQuery(sql);
    StringBuffer content = new StringBuffer();

    while (rs.next()) {
		content.append("I,");
		content.append(rs.getString("term_id3").trim() + ",");
		if (rs.getString("unit_no").equals("4")) {
		    content.append("06,");
		} else {
		    content.append("00,");
		}
		//所属分公司代码
		content.append("0800085500,");
		//商户中文名称
		content.append(rs.getString("unit_name") + ",");
		//商户中文简称
		content.append(rs.getString("MARCHANT_NAME2") + ",");
		//收单机构代码
		content.append("0848215500,");
		//受理机构代码
		content.append("08"+rs.getString("com_code").trim()+",");
		if (rs.getString("unit_no").equals("4")) {
		    //所属平台机构代码
		    content.append("0800085501,");
		    //收单接入机构代码
		    content.append("0800085501,");
		} else {
		    //所属平台机构代码
		    content.append("0800085500,");
		    //收单接入机构代码
		    content.append("0800085500,");
		}
		//国家代码
		content.append("156,");
		//行政区划代码
		content.append(rs.getString("term_id3").trim().substring(3, 7)
			+ ",");
		//受理地区代码
		content.append(rs.getString("com_code").trim().substring(4)
			+ ",");		
		//交易商户类型
		content.append(rs.getString("term_id3").trim().substring(7, 11)
			+ ",");
		//清算地区代码
		content.append(rs.getString("term_id3").trim().substring(3, 7)
			+ ",");
		//真实商户类型
		content.append(rs.getString("term_id3").trim().substring(7, 11)
			+ ",");
		//商户组别
		if (rs.getString("unit_no").equals("4")) {
		    content.append("00,");
		} else {
		    content.append("17,");
		}
		//商户状态
		content.append("1,");
		//所属行业类型
		if (rs.getString("unit_no").equals("4")) {
		    content.append(",");
		} else {
		    content.append("00,");
		}
		//受卡方名称地址----交易特殊控制
		content.append(",,,,");
		//联接方式
		content.append("P,");
		//是否MIS商户
		content.append(",");
		//交易币种
		content.append("80000000000000000000,");
		//默认交易币种
		content.append("156,");
		//营业执照号码
		content.append(rs.getString("comm_no") + ",");
		//执照有效期  发证机关
		content.append(",,");
		//注册地址
		content.append(rs.getString("unit_add") + ",");
		//税务登记代码  企业性质 企业代码
		content.append(",,,");
		//法人代表证件类型
		content.append("01,");
		//法人代表证件号码
		content.append(rs.getString("legal_id_card") + ",");
		//法人代表姓名
		content.append(rs.getString("legaler_name") + ",");
		//商户联系人
		content.append(rs.getString("contact_name_1") + ",");
		//商户联系人通讯地址 邮编
		content.append(",,");
		//商户联系人电话
		content.append(rs.getString("contact_tel_2") + ",");
		//移动电话
		content.append(rs.getString("contact_tel_1") + ",");
		//电子邮件 传真 财务联系人 终端维护公司 注册资本 注册资本币种 经营范围
		content.append(",,,,,,,");
		//营业地址
		content.append(rs.getString("unit_add") + ",");
		//签约标志     电子票据业务标志
		content.append(",,");
		//资金入账方式
		content.append(rs.getString("account_type") + ",");
		//结算行机构代码
		if (rs.getString("account_type").equals("2")) {
		    content.append("08"+rs.getString("account_bank").trim() + ",");
		}else{
			content.append(",");
		}
		//商户清算模式
		content.append("1,,");
		//资金划付周期      垫付回补类型     直联清算标识
		content.append("0,0,1,");
		//商户开户行名称
		if (rs.getString("account_type").equals("2")) {
		    //账户支行
		    content.append(rs.getString("account_bank_brach").trim()
			    + ",");
		} else {
		    //账户银行
		    content.append(rs.getString("bank_name").trim() + ",");
		}
		//商户开户行行号
		content.append(rs.getString("account_bank_id")+ ",");
		//开户行接收行行号
	    content.append(rs.getString("c5") + ",");
		//商户账户币种
		content.append("156,");
		//账户名称
		content.append(rs.getString("account_name") + ",");
		//账号
		content.append(rs.getString("account_no") + ",");
		//本金清算类型
		content.append(",,");
		//特殊计费类型         特殊计费档次
		content.append(rs.getString("fee_content") + ","
			+ rs.getString("fee_lev") + ",");
		//分润算法
		content.append(rs.getString("lq_rule") + ",");
		//商户计费算法
		content.append("NK001&"+rs.getString("fee_rule1")+"#TP001&"+rs.getString("fee_rule2")+"#,");
		//收单分润算法
		content.append("CS002&CS099&#,");
		//分润角色
		content.append("0000001000,");
		//商户层级
		content.append(",,,,,,");
		//报表类型
		content.append("1111000000,");
		//收单收益帐号    开户行清算号
		content.append(",,");
		//是否参加日间清算
		content.append("0,");
		//商户清算附言.............................
		if (rs.getString("account_type").equals("3")) {
		    content.append("银联代理商户入帐,0,0,00100,11,00104,09900,00119,11,");
		}else{
			content.append(",,,,,,,,,");
		}
		//商户属性位图
		content.append("0010000000,");
		//税务类别...............................
		if (rs.getString("unit_no").equals("4")) {
			content.append(",,,,,,,00000165501,00165501,00,,,,,,,,,,,,0,0,,,,,,,");
		}else{
			content.append(",,,,,,,,,,,,,,,,,,,,,,,,,,,,,");
		}
		//新业务规则启用标志
		content.append("1,");
		//商户网址...end
		content.append(",,,,,,,,,,,,,,,,,,,,1,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,");
		content.append("\n");
    }
    rs.close();
    dba.release();
    Log.getLogger().info(content.toString());
    Export ex = new Export() {
		public void initSql(String where) {
		}
    };
    ex.release();
    ex.setFileName("导出商户");
    ex.exportLog(session);
    out.print(content);%>
