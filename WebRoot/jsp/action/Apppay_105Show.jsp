<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	try
	{
		Apppay_105Dao Apppay_105dao = new Apppay_105Dao();
		String apppay_id = request.getParameter("apppay_id");
		Apppay_105 Apppay_105x = Apppay_105dao
				.whereApppay_id(new Integer(apppay_id));
		System.out.println("com1");
		JSONArray ja = new JSONArray();
		JSONObject jo = new JSONObject();
		jo.put("apppay_id", Apppay_105x.getApppay_id());
		jo.put("commercial_id", Apppay_105x.getCommercial_id());
		jo.put("apptype", Apppay_105x.getApptype());
		jo.put("account_type", Apppay_105x.getAccount_type());
		jo.put("account_no", Apppay_105x.getAccount_no());
		jo.put("account_bank", Apppay_105x.getAccount_bank());
		jo.put("account_bank_brach",
				Apppay_105x.getAccount_bank_brach());
		jo.put("account_bank_id", Apppay_105x.getAccount_bank_id());
		jo.put("account_province", Apppay_105x.getAccount_province());
		jo.put("account_city", Apppay_105x.getAccount_city());
		jo.put("account_name", Apppay_105x.getAccount_name());
		jo.put("contract_type", Apppay_105x.getContract_type());
		System.out.println("com2");
		jo.put("contract_fee", Apppay_105x.getContract_fee());
		System.out.println("com3");
		jo.put("ec_id", Apppay_105x.getEc_id());
		jo.put("ec_branch", Apppay_105x.getEc_branch());
		jo.put("ec_branch_name", Apppay_105x.getEc_branch_name());
		jo.put("e_id", Apppay_105x.getE_id());
		jo.put("appr_man", Apppay_105x.getAppr_man());
		jo.put("appr_status", Apppay_105x.getAppr_status());
		jo.put("appr_date", Apppay_105x.getAppr_date());
		jo.put("reason", Apppay_105x.getReason());
		jo.put("appr_remark", Apppay_105x.getAppr_remark());
		jo.put("status", Apppay_105x.getStatus());
		jo.put("credit_flag", Apppay_105x.getCredit_flag());
		jo.put("credit_card_limit", Apppay_105x.getCredit_card_limit());
		jo.put("credit_m_a_limit", Apppay_105x.getCredit_m_a_limit());
		jo.put("credit_m_c_limit", Apppay_105x.getCredit_m_c_limit());
		jo.put("debit_card_limit", Apppay_105x.getDebit_card_limit());
		jo.put("debit_m_a_limit", Apppay_105x.getDebit_m_a_limit());
		jo.put("debit_m_c_limit", Apppay_105x.getDebit_m_c_limit());
		jo.put("input_date", Apppay_105x.getInput_date());
		jo.put("change_date", Apppay_105x.getChange_date());
		jo.put("mcc", Apppay_105x.getMcc());
		jo.put("mcc18", Apppay_105x.getMcc18());
		jo.put("lq_rule", Apppay_105x.getLq_rule());
		jo.put("fee_rule1", Apppay_105x.getFee_rule1());
		jo.put("fee_rule2", Apppay_105x.getFee_rule2());
		jo.put("marchanttype", Apppay_105x.getMarchanttype());
		jo.put("fee_content", Apppay_105x.getFee_content());
		jo.put("fee_lev", Apppay_105x.getFee_lev());
		jo.put("fee_chan", Apppay_105x.getFee_chan());
		jo.put("UNIT_NO", Apppay_105x.getUNIT_NO());
		ja.add(jo);
		jo = new JSONObject();
		jo.put("total", Apppay_105dao.getTotalCount());
		jo.put("Apppay_105", ja);
		out.println(jo);
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>
