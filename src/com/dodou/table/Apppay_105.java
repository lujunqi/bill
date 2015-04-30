package com.dodou.table;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class Apppay_105
{
	private int UNIT_NO;
	private int apppay_id;
	private int commercial_id;
	private String apptype;
	private int account_type;
	private String account_no;
	private String account_bank;
	private String account_bank_brach;
	private String account_bank_id;
	private String account_province;
	private String account_city;
	private String account_name;
	private int contract_type;
	private String contract_fee;
	private int ec_id;
	private String ec_branch;
	private String ec_branch_name;
	private int e_id;
	private String appr_man;
	private int appr_status;
	private String appr_date;
	private String reason;
	private String appr_remark;
	private int status;
	private String credit_flag;
	private String credit_card_limit;
	private String credit_m_a_limit;
	private String credit_m_c_limit;
	private String debit_card_limit;
	private String debit_m_a_limit;
	private String debit_m_c_limit;
	private String input_date;
	private String change_date;
	private String mcc;
	private String mcc18;
	private String lq_rule;
	private String fee_rule1;
	private String fee_rule2;
	private String marchanttype;
	private String fee_content;
	private String fee_lev;
	private String fee_chan;
	private String MARCHANT_NAME;
	private String MARCHANT_NAME2;

	private String LC_FEE_PRE;
	private String LC_FEE_TOP;
	private String OUT_FEE_PRE;
	private String OUT_FEE_TOP;
	
	public String getLC_FEE_PRE() {
		return LC_FEE_PRE;
	}

	public void setLC_FEE_PRE(String lC_FEE_PRE) {
		LC_FEE_PRE = lC_FEE_PRE;
	}

	public String getLC_FEE_TOP() {
		return LC_FEE_TOP;
	}

	public void setLC_FEE_TOP(String lC_FEE_TOP) {
		LC_FEE_TOP = lC_FEE_TOP;
	}

	public String getOUT_FEE_PRE() {
		return OUT_FEE_PRE;
	}

	public void setOUT_FEE_PRE(String oUT_FEE_PRE) {
		OUT_FEE_PRE = oUT_FEE_PRE;
	}

	public String getOUT_FEE_TOP() {
		return OUT_FEE_TOP;
	}

	public void setOUT_FEE_TOP(String oUT_FEE_TOP) {
		OUT_FEE_TOP = oUT_FEE_TOP;
	}
	
	public String getMARCHANT_NAME()
	{
		return MARCHANT_NAME;
	}

	public void setMARCHANT_NAME(String mARCHANT_NAME)
	{
		MARCHANT_NAME = mARCHANT_NAME;
	}

	public String getMARCHANT_NAME2()
	{
		return MARCHANT_NAME2;
	}

	public void setMARCHANT_NAME2(String mARCHANT_NAME2)
	{
		MARCHANT_NAME2 = mARCHANT_NAME2;
	}

	private String REMARK_INFO;// 备注信息

	public String getREMARK_INFO()
	{
		return REMARK_INFO;
	}

	public void setREMARK_INFO(String rEMARK_INFO)
	{
		REMARK_INFO = rEMARK_INFO;
	}

	public int getApppay_id()
	{
		return apppay_id;
	}

	public void setApppay_id(int apppay_id)
	{
		this.apppay_id = apppay_id;
	}

	public int getCommercial_id()
	{
		return commercial_id;
	}

	public int getUNIT_NO()
	{
		return UNIT_NO;
	}

	public void setUNIT_NO(int uNIT_NO)
	{
		UNIT_NO = uNIT_NO;
	}

	public void setCommercial_id(int commercial_id)
	{
		this.commercial_id = commercial_id;
	}

	public String getApptype()
	{
		return apptype;
	}

	public void setApptype(String apptype)
	{
		this.apptype = apptype;
	}

	public int getAccount_type()
	{
		return account_type;
	}

	public void setAccount_type(int account_type)
	{
		this.account_type = account_type;
	}

	public String getAccount_no()
	{
		return account_no;
	}

	public void setAccount_no(String account_no)
	{
		this.account_no = account_no;
	}

	public String getAccount_bank()
	{
		return account_bank;
	}

	public void setAccount_bank(String account_bank)
	{
		this.account_bank = account_bank;
	}

	public String getAccount_bank_brach()
	{
		return account_bank_brach;
	}

	public void setAccount_bank_brach(String account_bank_brach)
	{
		this.account_bank_brach = account_bank_brach;
	}

	public String getAccount_bank_id()
	{
		return account_bank_id;
	}

	public void setAccount_bank_id(String account_bank_id)
	{
		this.account_bank_id = account_bank_id;
	}

	public String getAccount_province()
	{
		return account_province;
	}

	public void setAccount_province(String account_province)
	{
		this.account_province = account_province;
	}

	public String getAccount_city()
	{
		return account_city;
	}

	public void setAccount_city(String account_city)
	{
		this.account_city = account_city;
	}

	public String getAccount_name()
	{
		return account_name;
	}

	public void setAccount_name(String account_name)
	{
		this.account_name = account_name;
	}

	public int getContract_type()
	{
		return contract_type;
	}

	public void setContract_type(int contract_type)
	{
		this.contract_type = contract_type;
	}

	public String getContract_fee()
	{
		return contract_fee;
	}

	public void setContract_fee(String contract_fee)
	{
		this.contract_fee = contract_fee;
	}

	public int getEc_id()
	{
		return ec_id;
	}

	public void setEc_id(int ec_id)
	{
		this.ec_id = ec_id;
	}

	public String getEc_branch()
	{
		return ec_branch;
	}

	public void setEc_branch(String ec_branch)
	{
		this.ec_branch = ec_branch;
	}

	public String getEc_branch_name()
	{
		return ec_branch_name;
	}

	public void setEc_branch_name(String ec_branch_name)
	{
		this.ec_branch_name = ec_branch_name;
	}

	public int getE_id()
	{
		return e_id;
	}

	public void setE_id(int e_id)
	{
		this.e_id = e_id;
	}

	public String getAppr_man()
	{
		return appr_man;
	}

	public void setAppr_man(String appr_man)
	{
		this.appr_man = appr_man;
	}

	public int getAppr_status()
	{
		return appr_status;
	}

	public void setAppr_status(int appr_status)
	{
		this.appr_status = appr_status;
	}

	public String getAppr_date()
	{
		return appr_date;
	}

	public void setAppr_date(String appr_date)
	{
		this.appr_date = appr_date;
	}

	public String getReason()
	{
		return reason;
	}

	public void setReason(String reason)
	{
		this.reason = reason;
	}

	public String getAppr_remark()
	{
		return appr_remark;
	}

	public void setAppr_remark(String appr_remark)
	{
		this.appr_remark = appr_remark;
	}

	public int getStatus()
	{
		return status;
	}

	public void setStatus(int status)
	{
		this.status = status;
	}

	public String getCredit_flag()
	{
		return credit_flag;
	}

	public void setCredit_flag(String credit_flag)
	{
		this.credit_flag = credit_flag;
	}

	public String getCredit_card_limit()
	{
		return credit_card_limit;
	}

	public void setCredit_card_limit(String credit_card_limit)
	{
		this.credit_card_limit = credit_card_limit;
	}

	public String getCredit_m_a_limit()
	{
		return credit_m_a_limit;
	}

	public void setCredit_m_a_limit(String credit_m_a_limit)
	{
		this.credit_m_a_limit = credit_m_a_limit;
	}

	public String getCredit_m_c_limit()
	{
		return credit_m_c_limit;
	}

	public void setCredit_m_c_limit(String credit_m_c_limit)
	{
		this.credit_m_c_limit = credit_m_c_limit;
	}

	public String getDebit_card_limit()
	{
		return debit_card_limit;
	}

	public void setDebit_card_limit(String debit_card_limit)
	{
		this.debit_card_limit = debit_card_limit;
	}

	public String getDebit_m_a_limit()
	{
		return debit_m_a_limit;
	}

	public void setDebit_m_a_limit(String debit_m_a_limit)
	{
		this.debit_m_a_limit = debit_m_a_limit;
	}

	public String getDebit_m_c_limit()
	{
		return debit_m_c_limit;
	}

	public void setDebit_m_c_limit(String debit_m_c_limit)
	{
		this.debit_m_c_limit = debit_m_c_limit;
	}

	public String getInput_date()
	{
		return input_date;
	}

	public void setInput_date(String input_date)
	{
		this.input_date = input_date;
	}

	public String getChange_date()
	{
		return change_date;
	}

	public void setChange_date(String change_date)
	{
		this.change_date = change_date;
	}

	public String getMcc()
	{
		return mcc;
	}

	public void setMcc(String mcc)
	{
		this.mcc = mcc;
	}

	public String getMcc18()
	{
		return mcc18;
	}

	public void setMcc18(String mcc18)
	{
		this.mcc18 = mcc18;
	}

	public String getLq_rule()
	{
		return lq_rule;
	}

	public void setLq_rule(String lq_rule)
	{
		this.lq_rule = lq_rule;
	}

	public String getFee_rule1()
	{
		return fee_rule1;
	}

	public void setFee_rule1(String fee_rule1)
	{
		this.fee_rule1 = fee_rule1;
	}

	public String getFee_rule2()
	{
		return fee_rule2;
	}

	public void setFee_rule2(String fee_rule2)
	{
		this.fee_rule2 = fee_rule2;
	}

	public String getMarchanttype()
	{
		return marchanttype;
	}

	public void setMarchanttype(String marchanttype)
	{
		this.marchanttype = marchanttype;
	}

	public String getFee_content()
	{
		return fee_content;
	}

	public void setFee_content(String fee_content)
	{
		this.fee_content = fee_content;
	}

	public String getFee_lev()
	{
		return fee_lev;
	}

	public void setFee_lev(String fee_lev)
	{
		this.fee_lev = fee_lev;
	}

	public String getFee_chan()
	{
		return fee_chan;
	}

	public void setFee_chan(String fee_chan)
	{
		this.fee_chan = fee_chan;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		
		if (request.getParameter("LC_FEE_PRE") != null
				&& !request.getParameter("LC_FEE_PRE").equals(""))
		{
			this.setLC_FEE_PRE(request.getParameter("LC_FEE_PRE"));
		}
		if (request.getParameter("LC_FEE_TOP") != null
				&& !request.getParameter("LC_FEE_TOP").equals(""))
		{
			this.setLC_FEE_TOP(request.getParameter("LC_FEE_TOP"));
		}
		if (request.getParameter("OUT_FEE_PRE") != null
				&& !request.getParameter("OUT_FEE_PRE").equals(""))
		{
			this.setOUT_FEE_PRE(request.getParameter("OUT_FEE_PRE"));
		}
		if (request.getParameter("OUT_FEE_TOP") != null
				&& !request.getParameter("OUT_FEE_TOP").equals(""))
		{
			this.setOUT_FEE_TOP(request.getParameter("OUT_FEE_TOP"));
		}

		if (request.getParameter("MARCHANT_NAME") != null
				&& !request.getParameter("MARCHANT_NAME").equals(""))
		{
			this.setMARCHANT_NAME(request.getParameter("MARCHANT_NAME"));

		}
		if (request.getParameter("MARCHANT_NAME2") != null
				&& !request.getParameter("MARCHANT_NAME2").equals(""))
		{
			this.setMARCHANT_NAME2(request.getParameter("MARCHANT_NAME2"));

		}
		if (request.getParameter("REMARK_INFO") != null
				&& !request.getParameter("REMARK_INFO").equals(""))
		{
			this.setREMARK_INFO(request.getParameter("REMARK_INFO"));

		}
		
		if (request.getParameter("apppay_id") != null
				&& !request.getParameter("apppay_id").equals(""))
		{
			this.setApppay_id(Integer.parseInt(request
					.getParameter("apppay_id")));

		}
		if (request.getParameter("UNIT_NO") != null
				&& !request.getParameter("UNIT_NO").equals(""))
		{
			this.setUNIT_NO(Integer.parseInt(request.getParameter("UNIT_NO")));
		}
		if (request.getParameter("cId") != null
				&& !request.getParameter("cId").equals(""))
		{
			this.setCommercial_id(Integer.parseInt(request.getParameter("cId")));
		}
		if (request.getParameter("apptype") != null
				&& !request.getParameter("apptype").equals(""))
		{
			this.setApptype(request.getParameter("apptype"));
		}
		if (request.getParameter("account_type") != null
				&& !request.getParameter("account_type").equals(""))
		{
			this.setAccount_type(Integer.parseInt(request
					.getParameter("account_type")));
		}
		if (request.getParameter("account_no") != null
				&& !request.getParameter("account_no").equals(""))
		{
			this.setAccount_no(request.getParameter("account_no"));
		}
		if (request.getParameter("account_bank") != null
				&& !request.getParameter("account_bank").equals(""))
		{
			this.setAccount_bank(request.getParameter("account_bank"));
		}
		if (request.getParameter("account_bank_brach") != null
				&& !request.getParameter("account_bank_brach").equals(""))
		{
			this.setAccount_bank_brach(request
					.getParameter("account_bank_brach"));
		}
		if (request.getParameter("account_bank_id") != null
				&& !request.getParameter("account_bank_id").equals(""))
		{
			this.setAccount_bank_id(request.getParameter("account_bank_id"));
		}
		if (request.getParameter("account_province") != null
				&& !request.getParameter("account_province").equals(""))
		{
			this.setAccount_province(request.getParameter("account_province"));
		}
		if (request.getParameter("account_city") != null
				&& !request.getParameter("account_city").equals(""))
		{
			this.setAccount_city(request.getParameter("account_city"));
		}
		if (request.getParameter("account_name") != null
				&& !request.getParameter("account_name").equals(""))
		{
			this.setAccount_name(request.getParameter("account_name"));
		}
		if (request.getParameter("contract_type") != null
				&& !request.getParameter("contract_type").equals(""))
		{
			this.setContract_type(Integer.parseInt(request
					.getParameter("contract_type")));
		}
		if (request.getParameter("contract_fee") != null
				&& !request.getParameter("contract_fee").equals(""))
		{
			this.setContract_fee(request.getParameter("contract_fee"));
		}
		if (request.getParameter("ec_id") != null
				&& !request.getParameter("ec_id").equals(""))
		{
			this.setEc_id(Integer.parseInt(request.getParameter("ec_id")));
		}
		if (request.getParameter("ec_branch") != null
				&& !request.getParameter("ec_branch").equals(""))
		{
			this.setEc_branch(request.getParameter("ec_branch"));
		}
		if (request.getParameter("ec_branch_name") != null
				&& !request.getParameter("ec_branch_name").equals(""))
		{
			this.setEc_branch_name(request.getParameter("ec_branch_name"));
		}
		if (request.getParameter("e_id") != null
				&& !request.getParameter("e_id").equals(""))
		{
			this.setE_id(Integer.parseInt(request.getParameter("e_id")));
		}
		if (request.getParameter("appr_man") != null
				&& !request.getParameter("appr_man").equals(""))
		{
			this.setAppr_man(request.getParameter("appr_man"));
		}
		if (request.getParameter("appr_status") != null
				&& !request.getParameter("appr_status").equals(""))
		{
			this.setAppr_status(Integer.parseInt(request
					.getParameter("appr_status")));
		}
		if (request.getParameter("appr_date") != null
				&& !request.getParameter("appr_date").equals(""))
		{
			this.setAppr_date(request.getParameter("appr_date"));
		}
		if (request.getParameter("reason") != null
				&& !request.getParameter("reason").equals(""))
		{
			this.setReason(request.getParameter("reason"));
		}
		System.out.println(request.getParameter("appr_remark") +"=============");
		if (request.getParameter("appr_remark") != null
				&& !request.getParameter("appr_remark").equals(""))
		{
			this.setAppr_remark(request.getParameter("appr_remark"));
		}
		if (request.getParameter("status") != null
				&& !request.getParameter("status").equals(""))
		{
			this.setStatus(Integer.parseInt(request.getParameter("status")));
		}
		if (request.getParameter("credit_flag") != null
				&& !request.getParameter("credit_flag").equals(""))
		{
			this.setCredit_flag(request.getParameter("credit_flag"));
		}
		if (request.getParameter("credit_card_limit") != null
				&& !request.getParameter("credit_card_limit").equals(""))
		{
			this.setCredit_card_limit(request.getParameter("credit_card_limit"));
		}
		if (request.getParameter("credit_m_a_limit") != null
				&& !request.getParameter("credit_m_a_limit").equals(""))
		{
			this.setCredit_m_a_limit(request.getParameter("credit_m_a_limit"));
		}
		if (request.getParameter("credit_m_c_limit") != null
				&& !request.getParameter("credit_m_c_limit").equals(""))
		{
			this.setCredit_m_c_limit(request.getParameter("credit_m_c_limit"));
		}
		if (request.getParameter("debit_card_limit") != null
				&& !request.getParameter("debit_card_limit").equals(""))
		{
			this.setDebit_card_limit(request.getParameter("debit_card_limit"));
		}
		if (request.getParameter("debit_m_a_limit") != null
				&& !request.getParameter("debit_m_a_limit").equals(""))
		{
			this.setDebit_m_a_limit(request.getParameter("debit_m_a_limit"));
		}
		if (request.getParameter("debit_m_c_limit") != null
				&& !request.getParameter("debit_m_c_limit").equals(""))
		{
			this.setDebit_m_c_limit(request.getParameter("debit_m_c_limit"));
		}
		if (request.getParameter("input_date") != null
				&& !request.getParameter("input_date").equals(""))
		{
			this.setInput_date(request.getParameter("input_date"));
		}
		if (request.getParameter("change_date") != null
				&& !request.getParameter("change_date").equals(""))
		{
			this.setChange_date(request.getParameter("change_date"));
		}
		if (request.getParameter("mcc") != null
				&& !request.getParameter("mcc").equals(""))
		{
			this.setMcc(request.getParameter("mcc"));
		}
		if (request.getParameter("mcc18") != null
				&& !request.getParameter("mcc18").equals(""))
		{
			this.setMcc18(request.getParameter("mcc18"));
		}
		if (request.getParameter("lq_rule") != null
				&& !request.getParameter("lq_rule").equals(""))
		{
			this.setLq_rule(request.getParameter("lq_rule"));
		}
		if (request.getParameter("fee_rule1") != null
				&& !request.getParameter("fee_rule1").equals(""))
		{
			this.setFee_rule1(request.getParameter("fee_rule1"));
		}
		if (request.getParameter("fee_rule2") != null
				&& !request.getParameter("fee_rule2").equals(""))
		{
			this.setFee_rule2(request.getParameter("fee_rule2"));
		}
		if (request.getParameter("marchanttype") != null
				&& !request.getParameter("marchanttype").equals(""))
		{
			this.setMarchanttype(request.getParameter("marchanttype"));
		}
		if (request.getParameter("fee_content") != null
				&& !request.getParameter("fee_content").equals(""))
		{
			this.setFee_content(request.getParameter("fee_content"));
		}
		if (request.getParameter("fee_lev") != null
				&& !request.getParameter("fee_lev").equals(""))
		{
			this.setFee_lev(request.getParameter("fee_lev"));
		}
		if (request.getParameter("fee_chan") != null
				&& !request.getParameter("fee_chan").equals(""))
		{
			this.setFee_chan(request.getParameter("fee_chan"));
		}
		String top = this.getContract_fee();
		if (null != top)
		{
			if (this.getContract_type() == 2)
			{
				this.setContract_fee(top.replace("%", "").replace("-", "")
						+ "%");
			} else if (this.getContract_type() == 3)
			{
				if (null != request.getParameter("FEE_SET_TOP"))
				{
					this.setContract_fee(top.replace("%", "").replace("-", "")
							+ "%-" + request.getParameter("FEE_SET_TOP"));
				}
			} else
			{
				this.setContract_fee(top.replace("%", "").replace("-", ""));
			}
		}
	}
}
