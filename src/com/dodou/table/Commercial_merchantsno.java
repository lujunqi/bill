package com.dodou.table;

import java.sql.Timestamp;
import javax.servlet.http.HttpServletRequest;
import com.dodou.util.*;

public class Commercial_merchantsno
{
	private String mcc;
	private int merchantsno_id;
	private int commercial_id;
	private String ratededuction;
	private String account_no;
	private String account_bank;
	private String account_name;
	private String input_date;
	private String merchantsno;
	private int appr_man;
	private int appr_status;
	private String appr_date;
	private int appr_remark;
	private int status;
	private String change_date;
	private String merchant_busi;
	private int sales_man;
	private String file_name;
	private int fee_chan;
	private String reason;
	private String bank_no;

	public String getBank_no()
	{
		return bank_no;
	}

	public void setBank_no(String bank_no)
	{
		this.bank_no = bank_no;
	}

	public String getReason()
	{
		return reason;
	}

	public void setReason(String reason)
	{
		this.reason = reason;
	}

	public int getFee_chan()
	{
		return fee_chan;
	}

	public void setFee_chan(int fee_chan)
	{
		this.fee_chan = fee_chan;
	}

	public String getFile_name()
	{
		return file_name;
	}

	public void setFile_name(String file_name)
	{
		this.file_name = file_name;
	}

	// ljn add
	private String merchant_name;
	private String marchantType;
	private String lq_rule;
	private String fee_rule1;
	private String fee_rule2;

	private String chan_type;
	private String chan_name;
	private String account_bank_brach;
	private String fee_content;

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

	private String fee_lev;

	public String getChan_name()
	{
		return chan_name;
	}

	public void setChan_name(String chan_name)
	{
		this.chan_name = chan_name;
	}

	public String getAccount_bank_brach()
	{
		return account_bank_brach;
	}

	public void setAccount_bank_brach(String account_bank_brach)
	{
		this.account_bank_brach = account_bank_brach;
	}

	private String unit_area;
	private String mcc18;

	// end

	public String getMcc18()
	{
		return mcc18;
	}

	public void setMcc18(String mcc18)
	{
		this.mcc18 = mcc18;
	}

	public String getMcc()
	{
		return mcc;
	}

	public void setMcc(String mcc)
	{
		this.mcc = mcc;
	}

	public int getMerchantsno_id()
	{
		return merchantsno_id;
	}

	public void setMerchantsno_id(int merchantsno_id)
	{
		this.merchantsno_id = merchantsno_id;
	}

	public int getCommercial_id()
	{
		return commercial_id;
	}

	public void setCommercial_id(int commercial_id)
	{
		this.commercial_id = commercial_id;
	}

	public String getRatededuction()
	{
		return ratededuction;
	}

	public void setRatededuction(String ratededuction)
	{
		this.ratededuction = ratededuction;
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

	public String getAccount_name()
	{
		return account_name;
	}

	public void setAccount_name(String account_name)
	{
		this.account_name = account_name;
	}

	public String getInput_date()
	{
		return input_date;
	}

	public void setInput_date(String input_date)
	{
		this.input_date = input_date;
	}

	public String getMerchantsno()
	{
		return merchantsno;
	}

	public void setMerchantsno(String merchantsno)
	{
		this.merchantsno = merchantsno;
	}

	public int getAppr_man()
	{
		return appr_man;
	}

	public void setAppr_man(int appr_man)
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

	public int getAppr_remark()
	{
		return appr_remark;
	}

	public void setAppr_remark(int appr_remark)
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

	public String getChange_date()
	{
		return change_date;
	}

	public void setChange_date(String change_date)
	{
		this.change_date = change_date;
	}

	public String getMerchant_busi()
	{
		return merchant_busi;
	}

	public void setMerchant_busi(String merchant_busi)
	{
		this.merchant_busi = merchant_busi;
	}

	public int getSales_man()
	{
		return sales_man;
	}

	public void setSales_man(int sales_man)
	{
		this.sales_man = sales_man;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		if (request.getParameter("mcc") != null
				&& !request.getParameter("mcc").equals(""))
		{
			this.setMcc(request.getParameter("mcc"));
		}
		if (request.getParameter("merchantsno_id") != null
				&& !request.getParameter("merchantsno_id").equals(""))
		{
			this.setMerchantsno_id(Integer.parseInt(request
					.getParameter("merchantsno_id")));
		}
		if (request.getParameter("commercial_id") != null
				&& !request.getParameter("commercial_id").equals(""))
		{
			this.setCommercial_id(Integer.parseInt(request
					.getParameter("commercial_id")));
		}
		if (request.getParameter("ratededuction") != null
				&& !request.getParameter("ratededuction").equals(""))
		{
			this.setRatededuction(request.getParameter("ratededuction"));
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
		if (request.getParameter("account_name") != null
				&& !request.getParameter("account_name").equals(""))
		{
			this.setAccount_name(request.getParameter("account_name"));
		}
		if (request.getParameter("account_bank_brach") != null
				&& !request.getParameter("account_bank_brach").equals(""))
		{
			this.setAccount_bank_brach(request
					.getParameter("account_bank_brach"));
		}
		if (request.getParameter("input_date") != null
				&& !request.getParameter("input_date").equals(""))
		{
			this.setInput_date(request.getParameter("input_date"));
		}
		if (request.getParameter("merchantsno") != null
				&& !request.getParameter("merchantsno").equals(""))
		{
			this.setMerchantsno(request.getParameter("merchantsno"));
		}
		if (request.getParameter("bank_no") != null
				&& !request.getParameter("bank_no").equals(""))
		{
			this.setBank_no(request.getParameter("bank_no"));
		}
		if (request.getParameter("appr_man") != null
				&& !request.getParameter("appr_man").equals(""))
		{
			this.setAppr_man(Integer.parseInt(request.getParameter("appr_man")));
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
		if (request.getParameter("appr_remark") != null
				&& !request.getParameter("appr_remark").equals(""))
		{
			this.setAppr_remark(Integer.parseInt(request
					.getParameter("appr_remark")));
		}
		if (request.getParameter("status") != null
				&& !request.getParameter("status").equals(""))
		{
			this.setStatus(Integer.parseInt(request.getParameter("status")));
		}
		if (request.getParameter("change_date") != null
				&& !request.getParameter("change_date").equals(""))
		{
			this.setChange_date(request.getParameter("change_date"));
		}
		if (request.getParameter("merchant_busi") != null
				&& !request.getParameter("merchant_busi").equals(""))
		{
			this.setMerchant_busi(request.getParameter("merchant_busi"));
		}
		if (request.getParameter("sales_man") != null
				&& !request.getParameter("sales_man").equals(""))
		{
			this.setSales_man(Integer.parseInt(request
					.getParameter("sales_man")));
		}

		// ljn add
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
		if (request.getParameter("lq_rule") != null
				&& !request.getParameter("lq_rule").equals(""))
		{
			this.setLq_rule(request.getParameter("lq_rule"));
		}
		if (request.getParameter("marchantType") != null
				&& !request.getParameter("marchantType").equals(""))
		{
			this.setMarchantType(request.getParameter("marchantType"));
		}
		if (request.getParameter("merchant_name") != null
				&& !request.getParameter("merchant_name").equals(""))
		{
			this.setMerchant_name(request.getParameter("merchant_name"));
		}

		if (request.getParameter("chan_type") != null
				&& !request.getParameter("chan_type").equals(""))
		{
			this.setChan_type(request.getParameter("chan_type"));
		}
		if (request.getParameter("chan_name") != null
				&& !request.getParameter("chan_name").equals(""))
		{
			this.setChan_name(request.getParameter("chan_name"));
		}
		if (request.getParameter("unit_area") != null
				&& !request.getParameter("unit_area").equals(""))
		{
			this.setUnit_area(request.getParameter("unit_area"));
		}
		if (request.getParameter("mcc18") != null
				&& !request.getParameter("mcc18").equals(""))
		{
			this.setMcc18(request.getParameter("mcc18"));
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
		if (request.getParameter("file_name") != null
				&& !request.getParameter("file_name").equals(""))
		{
			this.setFile_name(request.getParameter("file_name"));
		}
		if (request.getParameter("fee_chan") != null
				&& !request.getParameter("fee_chan").equals("0"))
		{
			this.setFee_chan(Integer.parseInt(request.getParameter("fee_chan")));
		}
		if (request.getParameter("reason") != null
				&& !request.getParameter("reason").equals("0"))
		{
			this.setReason(request.getParameter("reason"));
		}
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

	public String getLq_rule()
	{
		return lq_rule;
	}

	public void setLq_rule(String lq_rule)
	{
		this.lq_rule = lq_rule;
	}

	public String getMarchantType()
	{
		return marchantType;
	}

	public void setMarchantType(String marchantType)
	{
		this.marchantType = marchantType;
	}

	public String getMerchant_name()
	{
		return merchant_name;
	}

	public void setMerchant_name(String merchant_name)
	{
		this.merchant_name = merchant_name;
	}

	// end
	public String getChan_type()
	{
		return chan_type;
	}

	public void setChan_type(String chan_type)
	{
		this.chan_type = chan_type;
	}

	public String getUnit_area()
	{
		return unit_area;
	}

	public void setUnit_area(String unit_area)
	{
		this.unit_area = unit_area;
	}
}
