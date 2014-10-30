<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
try{
Apppay_105Dao Apppay_105dao = new Apppay_105Dao();
if (request.getParameter("page_size") != null){int page_size = new Integer(request.getParameter("page_size"));
Apppay_105dao.setPageSize(page_size);}
if (request.getParameter("cur_page") != null){int cur_page = new Integer(request.getParameter("cur_page"));
Apppay_105dao.setCurPage(cur_page);}
Apppay_105 apppay_105 = new Apppay_105();
 apppay_105.requestGetParameter(request);
Apppay_105[] Apppay_105s = Apppay_105dao.select(apppay_105);
JSONArray ja = new JSONArray();
for (int i = 0; i < Apppay_105s.length && Apppay_105s[i] != null; i++) {
	JSONObject jo = new JSONObject();
	jo.put("apppay_id", Apppay_105s[i].getApppay_id());
	jo.put("commercial_id", Apppay_105s[i].getCommercial_id());
	jo.put("apptype", Apppay_105s[i].getApptype());
	jo.put("account_type", Apppay_105s[i].getAccount_type());
	jo.put("account_no", Apppay_105s[i].getAccount_no());
	jo.put("account_bank", Apppay_105s[i].getAccount_bank());
	jo.put("account_bank_brach", Apppay_105s[i].getAccount_bank_brach());
	jo.put("account_bank_id", Apppay_105s[i].getAccount_bank_id());
	jo.put("account_province", Apppay_105s[i].getAccount_province());
	jo.put("account_city", Apppay_105s[i].getAccount_city());
	jo.put("account_name", Apppay_105s[i].getAccount_name());
	jo.put("contract_type", Apppay_105s[i].getContract_type());
	jo.put("contract_fee", Apppay_105s[i].getContract_fee());
	jo.put("ec_id", Apppay_105s[i].getEc_id());
	jo.put("ec_branch", Apppay_105s[i].getEc_branch());
	jo.put("ec_branch_name", Apppay_105s[i].getEc_branch_name());
	jo.put("e_id", Apppay_105s[i].getE_id());
	jo.put("appr_man", Apppay_105s[i].getAppr_man());
	jo.put("appr_status", Apppay_105s[i].getAppr_status());
	jo.put("appr_date",Apppay_105s[i].getAppr_date());
	jo.put("reason", Apppay_105s[i].getReason());
	jo.put("appr_remark", Apppay_105s[i].getAppr_remark());
	jo.put("status", Apppay_105s[i].getStatus());
	jo.put("credit_flag", Apppay_105s[i].getCredit_flag());
	jo.put("credit_card_limit", Apppay_105s[i].getCredit_card_limit());
	jo.put("credit_m_a_limit", Apppay_105s[i].getCredit_m_a_limit());
	jo.put("credit_m_c_limit", Apppay_105s[i].getCredit_m_c_limit());
	jo.put("debit_card_limit", Apppay_105s[i].getDebit_card_limit());
	jo.put("debit_m_a_limit", Apppay_105s[i].getDebit_m_a_limit());
	jo.put("debit_m_c_limit", Apppay_105s[i].getDebit_m_c_limit());
	jo.put("input_date",Apppay_105s[i].getInput_date());
	jo.put("change_date",Apppay_105s[i].getChange_date());
	jo.put("mcc", Apppay_105s[i].getMcc());
	jo.put("mcc18", Apppay_105s[i].getMcc18());
	jo.put("lq_rule", Apppay_105s[i].getLq_rule());
	jo.put("fee_rule1", Apppay_105s[i].getFee_rule1());
	jo.put("fee_rule2", Apppay_105s[i].getFee_rule2());
	jo.put("marchanttype", Apppay_105s[i].getMarchanttype());
	jo.put("fee_content", Apppay_105s[i].getFee_content());
	jo.put("fee_lev", Apppay_105s[i].getFee_lev());
	jo.put("fee_chan", Apppay_105s[i].getFee_chan());
ja.add(jo);
}
JSONObject jo = new JSONObject();
jo.put("rows",Apppay_105dao.getRowsCount());
jo.put("total",Apppay_105dao.getTotalCount());
jo.put("cur_page",Apppay_105dao.getCurPage());
jo.put("total_page",Apppay_105dao.getPageCount());
jo.put("Apppay_105s", ja);
out.println(jo);
} catch (Exception e) {
	response.setStatus(500);
	e.printStackTrace(response.getWriter());
	e.printStackTrace();
}
%>
