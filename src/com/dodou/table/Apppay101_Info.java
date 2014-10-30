package com.dodou.table;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.dodou.inferface.TableBeanInterface;

public class Apppay101_Info implements TableBeanInterface
{
	private String REMARK_INFO;// 备注信息
	private int OPERATE_LIMIT;// NUMBER not null,
	private int REGISTER_CAPITAL;// NUMBER not null,
	private int OPERATE_AREA;// NUMBER not null,
	private int STAFFS;// NUMBER not null,
	private int MARKET_COMMPANY;// NUMBER not null,
	private int INNER_MANAGE;// NUMBER not null,
	private int INSPACE;// NUMBER not null,
	private int BUS_RELATION;// NUMBER not null,
	private int AUTH_ARGENT;// NUMBER not null,
	private int BUSS_TYPE_LARGE;// NUMBER not null,
	private String BUSS_TYPE_SMALL;// VARCHAR(256),
	private String NOT_NORM_DESC;// VARCHAR(256),
	private String UP_COMMERCIAL;// VARCHAR(256),
	private String INCOME_BELONG;// VARCHAR(256),
	private String REAL_OPERATE_RANGE;// VARCHAR(256),
	// --------新增信息终止--------------
	private int APPPAY_ID;// 主键
	private int COMMERCIAL_ID;// 客户ID
	private String APPTYPE = "106";
	private int ACCOUNT_TYPE = 1;
	private String ACCOUNT_NO;
	private String ACCOUNT_BANK;
	private String ACCOUNT_BANK_ID;
	private String ACCOUNT_PROVINCE;
	private String ACCOUNT_CITY;
	private String ACCOUNT_NAME;
	private String CONTRACT_FEE;
	private String EC_ID = "";
	private String EC_NAME;
	private int E_ID = 1;
	private String TERM_ID1 = "' '";
	private String TERM_ID2 = "' '";
	private String APPR_MAN;
	private int APPR_STATUS;
	private Date APPR_DATE;
	private String APPR_REMARK;
	private int STATUS = 0;
	private Date INPUT_DATE;
	private Date CHANGE_DATE;

	// -----新增字段---------
	private int COUNT_DESIRE;// 账户用户
	private int IS_DEFAULT;// 默认与否
	private String TER_MONTH_MIN;
	private String BASE;
	private String TOP;
	private int CHARGE_CYCLE;
	private String ACCOUNT_BANK_NAME;
	// --------------------------
	// --方便使用的字段
	private String more;
	private int isBind;// 是否绑定
	private String UNIT_AREA;
	private int fee_chan;

	public int getFee_chan()
	{
		return fee_chan;
	}

	public String getREMARK_INFO()
	{
		return REMARK_INFO;
	}

	public void setREMARK_INFO(String rEMARK_INFO)
	{
		REMARK_INFO = rEMARK_INFO;
	}

	public void setFee_chan(int fee_chan)
	{
		this.fee_chan = fee_chan;
	}

	public String getUNIT_AREA()
	{
		return UNIT_AREA;
	}

	public void setUNIT_AREA(String uNIT_AREA)
	{
		UNIT_AREA = uNIT_AREA;
	}

	private String commercialName;

	public String getACCOUNT_BANK_NAME()
	{
		return ACCOUNT_BANK_NAME;
	}

	public void setACCOUNT_BANK_NAME(String aCCOUNT_BANK_NAME)
	{
		ACCOUNT_BANK_NAME = aCCOUNT_BANK_NAME;
	}

	public String getCommercialName()
	{
		return commercialName;
	}

	public void setCommercialName(String commercialName)
	{
		this.commercialName = commercialName;
	}

	public int getCOUNT_DESIRE()
	{
		return COUNT_DESIRE;
	}

	public void setCOUNT_DESIRE(int cOUNT_DESIRE)
	{
		COUNT_DESIRE = cOUNT_DESIRE;
	}

	public int getIS_DEFAULT()
	{
		return IS_DEFAULT;
	}

	public void setIS_DEFAULT(int iS_DEFAULT)
	{
		IS_DEFAULT = iS_DEFAULT;
	}

	public String getTER_MONTH_MIN()
	{
		return TER_MONTH_MIN;
	}

	public void setTER_MONTH_MIN(String tER_MONTH_MIN)
	{
		TER_MONTH_MIN = tER_MONTH_MIN;
	}

	public String getBASE()
	{
		return BASE;
	}

	public void setBASE(String bASE)
	{
		BASE = bASE;
	}

	public String getTOP()
	{
		return TOP;
	}

	public void setTOP(String tOP)
	{
		TOP = tOP;
	}

	public int getCHARGE_CYCLE()
	{
		return CHARGE_CYCLE;
	}

	public void setCHARGE_CYCLE(int cHARGE_CYCLE)
	{
		CHARGE_CYCLE = cHARGE_CYCLE;
	}

	public int getIsBind()
	{
		return isBind;
	}

	public void setIsBind(int isBind)
	{
		this.isBind = isBind;
	}

	public String getMore()
	{
		return more;
	}

	public void setMore(String more)
	{
		this.more = more;
	}

	public int getOPERATE_LIMIT()
	{
		return OPERATE_LIMIT;
	}

	public void setOPERATE_LIMIT(int oPERATE_LIMIT)
	{
		OPERATE_LIMIT = oPERATE_LIMIT;
	}

	public int getREGISTER_CAPITAL()
	{
		return REGISTER_CAPITAL;
	}

	public void setREGISTER_CAPITAL(int rEGISTER_CAPITAL)
	{
		REGISTER_CAPITAL = rEGISTER_CAPITAL;
	}

	public int getOPERATE_AREA()
	{
		return OPERATE_AREA;
	}

	public void setOPERATE_AREA(int oPERATE_AREA)
	{
		OPERATE_AREA = oPERATE_AREA;
	}

	public int getSTAFFS()
	{
		return STAFFS;
	}

	public void setSTAFFS(int sTAFFS)
	{
		STAFFS = sTAFFS;
	}

	public int getMARKET_COMMPANY()
	{
		return MARKET_COMMPANY;
	}

	public void setMARKET_COMMPANY(int mARKET_COMMPANY)
	{
		MARKET_COMMPANY = mARKET_COMMPANY;
	}

	public int getINNER_MANAGE()
	{
		return INNER_MANAGE;
	}

	public void setINNER_MANAGE(int iNNER_MANAGE)
	{
		INNER_MANAGE = iNNER_MANAGE;
	}

	public int getINSPACE()
	{
		return INSPACE;
	}

	public void setINSPACE(int iNSPACE)
	{
		INSPACE = iNSPACE;
	}

	public int getBUS_RELATION()
	{
		return BUS_RELATION;
	}

	public void setBUS_RELATION(int bUS_RELATION)
	{
		BUS_RELATION = bUS_RELATION;
	}

	public int getAUTH_ARGENT()
	{
		return AUTH_ARGENT;
	}

	public void setAUTH_ARGENT(int aUTH_ARGENT)
	{
		AUTH_ARGENT = aUTH_ARGENT;
	}

	public int getBUSS_TYPE_LARGE()
	{
		return BUSS_TYPE_LARGE;
	}

	public void setBUSS_TYPE_LARGE(int bUSS_TYPE_LARGE)
	{
		BUSS_TYPE_LARGE = bUSS_TYPE_LARGE;
	}

	public String getBUSS_TYPE_SMALL()
	{
		return BUSS_TYPE_SMALL;
	}

	public void setBUSS_TYPE_SMALL(String bUSS_TYPE_SMALL)
	{
		BUSS_TYPE_SMALL = bUSS_TYPE_SMALL;
	}

	public String getNOT_NORM_DESC()
	{
		return NOT_NORM_DESC;
	}

	public void setNOT_NORM_DESC(String nOT_NORM_DESC)
	{
		NOT_NORM_DESC = nOT_NORM_DESC;
	}

	public String getUP_COMMERCIAL()
	{
		return UP_COMMERCIAL;
	}

	public void setUP_COMMERCIAL(String uP_COMMERCIAL)
	{
		UP_COMMERCIAL = uP_COMMERCIAL;
	}

	public String getINCOME_BELONG()
	{
		return INCOME_BELONG;
	}

	public void setINCOME_BELONG(String iNCOME_BELONG)
	{
		INCOME_BELONG = iNCOME_BELONG;
	}

	public String getREAL_OPERATE_RANGE()
	{
		return REAL_OPERATE_RANGE;
	}

	public void setREAL_OPERATE_RANGE(String rEAL_OPERATE_RANGE)
	{
		REAL_OPERATE_RANGE = rEAL_OPERATE_RANGE;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		// 设置客户信息
		if (null != request.getSession().getAttribute("COMMERCIAL_ID"))
			this.setCOMMERCIAL_ID((Integer) request.getSession().getAttribute(
					"COMMERCIAL_ID"));
		else
			this.setCOMMERCIAL_ID(29);

		if (request.getParameter("ACCOUNT_NO") != null
				&& !request.getParameter("ACCOUNT_NO").equals(""))
		{
			this.setACCOUNT_NO(request.getParameter("ACCOUNT_NO"));
		}
		if (request.getParameter("ACCOUNT_BANK") != null
				&& !request.getParameter("ACCOUNT_BANK").equals(""))
		{
			this.setACCOUNT_BANK(request.getParameter("ACCOUNT_BANK"));
		}
		if (request.getParameter("ACCOUNT_BANK_ID") != null
				&& !request.getParameter("ACCOUNT_BANK_ID").equals(""))
		{
			this.setACCOUNT_BANK_ID(request.getParameter("ACCOUNT_BANK_ID"));
		}
		if (request.getParameter("ACCOUNT_PROVINCE") != null
				&& !request.getParameter("ACCOUNT_PROVINCE").equals(""))
		{
			this.setACCOUNT_PROVINCE(request.getParameter("ACCOUNT_PROVINCE"));
			// this.setACCOUNT_PROVINCE(new String(request.getParameter(
			// "ACCOUNT_PROVINCE").getBytes("iso-8859-1"), "UTF-8"));
		}
		if (request.getParameter("ACCOUNT_CITY") != null
				&& !request.getParameter("ACCOUNT_CITY").equals(""))
		{
			this.setACCOUNT_CITY(request.getParameter("ACCOUNT_CITY"));
			// this.setACCOUNT_CITY(new String(request
			// .getParameter("ACCOUNT_CITY").getBytes("iso-8859-1"),
			// "UTF-8"));
		}

		System.out.println("=================乱码==========="
				+ this.getACCOUNT_PROVINCE() + ":" + this.getACCOUNT_CITY());

		if (request.getParameter("ACCOUNT_NAME") != null
				&& !request.getParameter("ACCOUNT_NAME").equals(""))
		{
			this.setACCOUNT_NAME(request.getParameter("ACCOUNT_NAME"));
		}
		if (request.getParameter("CONTRACT_FEE") != null
				&& !request.getParameter("CONTRACT_FEE").equals(""))
		{
			this.setCONTRACT_FEE(request.getParameter("CONTRACT_FEE"));
		}
		if (request.getParameter("EC_ID") != null
				&& !request.getParameter("EC_ID").equals(""))
		{
			this.setEC_ID(request.getParameter("EC_ID"));
		}
		if (request.getParameter("EC_NAME") != null
				&& !request.getParameter("EC_NAME").equals(""))
		{
			this.setEC_NAME(request.getParameter("EC_NAME"));
		}
		if (request.getParameter("TERM_ID1") != null
				&& !request.getParameter("TERM_ID1").equals(""))
		{
			this.setTERM_ID1(request.getParameter("TERM_ID1"));
		}
		if (request.getParameter("TERM_ID2") != null
				&& !request.getParameter("TERM_ID2").equals(""))
		{
			this.setTERM_ID2(request.getParameter("TERM_ID2"));
		}
		if (request.getParameter("APPR_MAN") != null
				&& !request.getParameter("APPR_MAN").equals(""))
		{
			this.setAPPR_MAN(request.getParameter("APPR_MAN"));
		}
		if (request.getParameter("APPR_STATUS") != null
				&& !request.getParameter("APPR_STATUS").equals(""))
		{
			this.setAPPR_STATUS(Integer.parseInt(request
					.getParameter("APPR_STATUS")));
		}
		if (request.getParameter("APPR_REMARK") != null
				&& !request.getParameter("APPR_REMARK").equals(""))
		{
			this.setAPPR_REMARK(request.getParameter("APPR_REMARK"));
		}
		if (request.getParameter("STATUS") != null
				&& !request.getParameter("STATUS").equals(""))
		{
			this.setSTATUS(Integer.parseInt(request.getParameter("STATUS")));
		}
		// --------------新增---------
		if (request.getParameter("IS_DEFAULT") != null
				&& !request.getParameter("IS_DEFAULT").equals(""))
		{
			this.setIS_DEFAULT(Integer.parseInt(request
					.getParameter("IS_DEFAULT")));
		}
		this.setBASE(request.getParameter("BASE"));
		this.setTOP(request.getParameter("TOP"));

		if (null != request.getParameter("CHARGE_CYCLE")
				&& !request.getParameter("CHARGE_CYCLE").equals(""))
		{
			this.setCHARGE_CYCLE(Integer.parseInt(request
					.getParameter("CHARGE_CYCLE")));
		}
		if (null != request.getParameter("COUNT_DESIRE")
				&& !request.getParameter("COUNT_DESIRE").equals(""))
		{
			this.setCOUNT_DESIRE(Integer.parseInt(request
					.getParameter("COUNT_DESIRE")));
		}
		if (null != request.getParameter("TER_MONTH_MIN")
				&& !request.getParameter("TER_MONTH_MIN").equals(""))
		{
			this.setTER_MONTH_MIN(request.getParameter("TER_MONTH_MIN"));
		}
	}

	public int getAPPPAY_ID()
	{
		return APPPAY_ID;
	}

	public void setAPPPAY_ID(int aPPPAY_ID)
	{
		APPPAY_ID = aPPPAY_ID;
	}

	public int getCOMMERCIAL_ID()
	{
		return COMMERCIAL_ID;
	}

	public void setCOMMERCIAL_ID(int cOMMERCIAL_ID)
	{
		COMMERCIAL_ID = cOMMERCIAL_ID;
	}

	public String getAPPTYPE()
	{
		return APPTYPE;
	}

	public void setAPPTYPE(String aPPTYPE)
	{
		APPTYPE = aPPTYPE;
	}

	public int getACCOUNT_TYPE()
	{
		return ACCOUNT_TYPE;
	}

	public void setACCOUNT_TYPE(int aCCOUNT_TYPE)
	{
		ACCOUNT_TYPE = aCCOUNT_TYPE;
	}

	public String getACCOUNT_NO()
	{
		return ACCOUNT_NO;
	}

	public void setACCOUNT_NO(String aCCOUNT_NO)
	{
		ACCOUNT_NO = aCCOUNT_NO;
	}

	public String getACCOUNT_BANK()
	{
		return ACCOUNT_BANK;
	}

	public void setACCOUNT_BANK(String aCCOUNT_BANK)
	{
		ACCOUNT_BANK = aCCOUNT_BANK;
	}

	public String getACCOUNT_BANK_ID()
	{
		return ACCOUNT_BANK_ID;
	}

	public void setACCOUNT_BANK_ID(String aCCOUNT_BANK_ID)
	{
		ACCOUNT_BANK_ID = aCCOUNT_BANK_ID;
	}

	public String getACCOUNT_PROVINCE()
	{
		return ACCOUNT_PROVINCE;
	}

	public void setACCOUNT_PROVINCE(String aCCOUNT_PROVINCE)
	{
		ACCOUNT_PROVINCE = aCCOUNT_PROVINCE;
	}

	public String getACCOUNT_CITY()
	{
		return ACCOUNT_CITY;
	}

	public void setACCOUNT_CITY(String aCCOUNT_CITY)
	{
		ACCOUNT_CITY = aCCOUNT_CITY;
	}

	public String getACCOUNT_NAME()
	{
		return ACCOUNT_NAME;
	}

	public void setACCOUNT_NAME(String aCCOUNT_NAME)
	{
		ACCOUNT_NAME = aCCOUNT_NAME;
	}

	public String getCONTRACT_FEE()
	{
		return CONTRACT_FEE;
	}

	public void setCONTRACT_FEE(String cONTRACT_FEE)
	{
		CONTRACT_FEE = cONTRACT_FEE;
	}

	public String getEC_ID()
	{
		return EC_ID;
	}

	public void setEC_ID(String eC_ID)
	{
		EC_ID = eC_ID;
	}

	public String getEC_NAME()
	{
		return EC_NAME;
	}

	public void setEC_NAME(String eC_NAME)
	{
		EC_NAME = eC_NAME;
	}

	public int getE_ID()
	{
		return E_ID;
	}

	public void setE_ID(int e_ID)
	{
		E_ID = e_ID;
	}

	public String getTERM_ID1()
	{
		return TERM_ID1;
	}

	public void setTERM_ID1(String tERM_ID1)
	{
		TERM_ID1 = tERM_ID1;
	}

	public String getTERM_ID2()
	{
		return TERM_ID2;
	}

	public void setTERM_ID2(String tERM_ID2)
	{
		TERM_ID2 = tERM_ID2;
	}

	public String getAPPR_MAN()
	{
		return APPR_MAN;
	}

	public void setAPPR_MAN(String aPPR_MAN)
	{
		APPR_MAN = aPPR_MAN;
	}

	public int getAPPR_STATUS()
	{
		return APPR_STATUS;
	}

	public void setAPPR_STATUS(int aPPR_STATUS)
	{
		APPR_STATUS = aPPR_STATUS;
	}

	public Date getAPPR_DATE()
	{
		return APPR_DATE;
	}

	public void setAPPR_DATE(Date aPPR_DATE)
	{
		APPR_DATE = aPPR_DATE;
	}

	public String getAPPR_REMARK()
	{
		return APPR_REMARK;
	}

	public void setAPPR_REMARK(String aPPR_REMARK)
	{
		APPR_REMARK = aPPR_REMARK;
	}

	public int getSTATUS()
	{
		return STATUS;
	}

	public void setSTATUS(int sTATUS)
	{
		STATUS = sTATUS;
	}

	public Date getINPUT_DATE()
	{
		return INPUT_DATE;
	}

	public void setINPUT_DATE(Date iNPUT_DATE)
	{
		INPUT_DATE = iNPUT_DATE;
	}

	public Date getCHANGE_DATE()
	{
		return CHANGE_DATE;
	}

	public void setCHANGE_DATE(Date cHANGE_DATE)
	{
		CHANGE_DATE = cHANGE_DATE;
	}

}
