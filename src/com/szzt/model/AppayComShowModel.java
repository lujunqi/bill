package com.szzt.model;

import java.util.Date;

public class AppayComShowModel
{
	private String name;
	private int APPPAY_ID;
	private String APPTYPE;
	private int APPR_STATUS;
	private String contract_fee;
	private String input_date;
	private String more;
	private int COMMERCIAL_ID;
	private String trem1;
	private Date input;
	private Date change;

	public Date getChange()
	{
		return change;
	}

	public void setChange(Date change)
	{
		this.change = change;
	}

	public Date getInput()
	{
		return input;
	}

	public void setInput(Date input)
	{
		this.input = input;
	}

	public String getTrem1()
	{
		return trem1;
	}

	public void setTrem1(String trem1)
	{
		this.trem1 = trem1;
	}

	public int getCOMMERCIAL_ID()
	{
		return COMMERCIAL_ID;
	}

	public void setCOMMERCIAL_ID(int cOMMERCIAL_ID)
	{
		COMMERCIAL_ID = cOMMERCIAL_ID;
	}

	public String getMore()
	{
		return more;
	}

	public void setMore(String more)
	{
		this.more = more;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public int getAPPPAY_ID()
	{
		return APPPAY_ID;
	}

	public void setAPPPAY_ID(int aPPPAY_ID)
	{
		APPPAY_ID = aPPPAY_ID;
	}

	public String getAPPTYPE()
	{
		return APPTYPE;
	}

	public void setAPPTYPE(String aPPTYPE)
	{
		APPTYPE = aPPTYPE;
	}

	public int getAPPR_STATUS()
	{
		return APPR_STATUS;
	}

	public void setAPPR_STATUS(int aPPR_STATUS)
	{
		APPR_STATUS = aPPR_STATUS;
	}

	public String getContract_fee()
	{
		return contract_fee;
	}

	public void setContract_fee(String contract_fee)
	{
		this.contract_fee = contract_fee;
	}

	public String getInput_date()
	{
		return input_date;
	}

	public void setInput_date(String input_date)
	{
		this.input_date = input_date;
	}

}
