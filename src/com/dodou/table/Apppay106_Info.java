package com.dodou.table;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.dodou.inferface.TableBeanInterface;

public class Apppay106_Info implements TableBeanInterface
{
	private String REMARK_INFO;// 备注信息
	private int APPPAY_ID = 1;
	private int COMMERCIAL_ID;// NUMBER not null,
	private String APPTYPE = "106";// CHAR(3) not null,
	private int ACCOUNT_TYPE = 0;// NUMBER not null,
	private String ACCOUNT_NO = " ";// VARCHAR2(128) not null,
	private String ACCOUNT_BANK = " ";// VARCHAR2(128) not null,
	private String ACCOUNT_BANK_ID = " ";// VARCHAR2(20) not null,
	private String ACCOUNT_PROVINCE = " ";// VARCHAR2(20) not null,
	private String ACCOUNT_CITY = " ";// VARCHAR2(40) not null,
	private String ACCOUNT_NAME = " ";// VARCHAR2(10) not null,
	private String FEE_TYPE = " ";// CHAR(1) not null,
	private String FEE_SET = " ";// CHAR(10) not null,
	private String BILL_INFO = " ";// VARCHAR2(256) not null,
	private String EC_ID = " ";
	private String EC_NAME;
	private int E_ID = 0;
	private String UNIT_NO = " ";// CHAR(11) not null, not null,
	private String TERM_ID1 = " ";// CHAR(16) not null,
	private String TERM_ID2 = " ";// CHAR(16) not null,
	private String CREDIT_FLAG = " ";// CHAR(10) not null,
	private String CREDIT_CARD_LIMIT;
	private String CREDIT_M_A_LIMIT;
	private String CREDIT_M_C_LIMIT;
	private String DEBIT_CARD_LIMIT;
	private String DEBIT_M_A_LIMIT;
	private String DEBIT_M_C_LIMIT;
	private String APPR_MAN = " ";
	private int APPR_STATUS;
	private Date APPR_DATE;
	private String APPR_REMARK = " ";
	private int STATUS = 0;
	private Date INPUT_DATE;// DATE not
	private Date CHANGE_DATE;
	private String PSAM_NO;// 16位
	private String TERM_TYPE;
	private String SERIAL;
	
	
	public String getTERM_TYPE() {
	    return TERM_TYPE;
	}

	public void setTERM_TYPE(String tERM_TYPE) {
	    TERM_TYPE = tERM_TYPE;
	}

	public String getSERIAL() {
	    return SERIAL;
	}

	public void setSERIAL(String sERIAL) {
	    SERIAL = sERIAL;
	}

	
	public String getREMARK_INFO()
	{
		return REMARK_INFO;
	}

	public void setREMARK_INFO(String rEMARK_INFO)
	{
		REMARK_INFO = rEMARK_INFO;
	}

	public String getPSAM_NO()
	{
		return PSAM_NO;
	}

	public void setPSAM_NO(String pSAM_NO)
	{
		PSAM_NO = pSAM_NO;
	}

	private String ACCOUNT_BANK_NAME;

	public String getACCOUNT_BANK_NAME()
	{
		return ACCOUNT_BANK_NAME;
	}

	public void setACCOUNT_BANK_NAME(String aCCOUNT_BANK_NAME)
	{
		ACCOUNT_BANK_NAME = aCCOUNT_BANK_NAME;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{

		this.setCOMMERCIAL_ID(Integer.parseInt(request
				.getParameter("COMMERCIAL_ID")));

		if (null != request.getParameter("REMARK_INFO")
				&& !request.getParameter("REMARK_INFO").equals(""))
		{
			this.setREMARK_INFO(request.getParameter("REMARK_INFO"));
		}
		if (null != request.getParameter("PSAM_NO")
				&& !request.getParameter("PSAM_NO").equals(""))
		{
			this.setPSAM_NO(request.getParameter("PSAM_NO"));
		}

		if (request.getParameter("ACCOUNT_BANK_NAME") != null
				&& !request.getParameter("ACCOUNT_BANK_NAME").equals(""))
		{
			this.setACCOUNT_BANK_NAME(request.getParameter("ACCOUNT_BANK_NAME"));
		}

		if (request.getParameter("APPTYPE") != null
				&& !request.getParameter("APPTYPE").equals(""))
		{
			this.setAPPTYPE(request.getParameter("APPTYPE"));
		}
		if (request.getParameter("ACCOUNT_TYPE") != null
				&& !request.getParameter("ACCOUNT_TYPE").equals(""))
		{
			this.setACCOUNT_TYPE(Integer.parseInt(request
					.getParameter("ACCOUNT_TYPE")));
		}

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
		}

		if (request.getParameter("ACCOUNT_CITY") != null
				&& !request.getParameter("ACCOUNT_CITY").equals(""))
		{
			this.setACCOUNT_CITY(request.getParameter("ACCOUNT_CITY"));
		}

		if (request.getParameter("ACCOUNT_NAME") != null
				&& !request.getParameter("ACCOUNT_NAME").equals(""))
		{
			this.setACCOUNT_NAME(request.getParameter("ACCOUNT_NAME"));
		}

		if (request.getParameter("FEE_TYPE") != null
				&& !request.getParameter("FEE_TYPE").equals(""))
		{
			this.setFEE_TYPE(request.getParameter("FEE_TYPE"));
		}

		if (request.getParameter("FEE_SET") != null
				&& !request.getParameter("FEE_SET").equals(""))
		{
			this.setFEE_SET(request.getParameter("FEE_SET"));
		}

		if (request.getParameter("BILL_INFO") != null
				&& !request.getParameter("BILL_INFO").equals(""))
		{
			this.setBILL_INFO(request.getParameter("BILL_INFO"));
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

		if (request.getParameter("E_ID") != null
				&& !request.getParameter("E_ID").equals(""))
		{
			this.setE_ID(Integer.parseInt(request.getParameter("E_ID")));
		}

		if (request.getParameter("UNIT_NO") != null
				&& !request.getParameter("UNIT_NO").equals(""))
		{
			this.setUNIT_NO(request.getParameter("UNIT_NO"));
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

		if (request.getParameter("CREDIT_FLAG") != null
				&& !request.getParameter("CREDIT_FLAG").equals(""))
		{
			this.setCREDIT_FLAG(request.getParameter("CREDIT_FLAG"));
		}

		if (request.getParameter("CREDIT_CARD_LIMIT") != null
				&& !request.getParameter("CREDIT_CARD_LIMIT").equals(""))
		{
			this.setCREDIT_CARD_LIMIT(request.getParameter("CREDIT_CARD_LIMIT"));
		}

		if (request.getParameter("CREDIT_M_A_LIMIT") != null
				&& !request.getParameter("CREDIT_M_A_LIMIT").equals(""))
		{
			this.setCREDIT_M_A_LIMIT(request.getParameter("CREDIT_M_A_LIMIT"));
		}

		if (request.getParameter("CREDIT_M_C_LIMIT") != null
				&& !request.getParameter("CREDIT_M_C_LIMIT").equals(""))
		{
			this.setCREDIT_M_C_LIMIT(request.getParameter("CREDIT_M_C_LIMIT"));
		}

		if (request.getParameter("DEBIT_CARD_LIMIT") != null
				&& !request.getParameter("DEBIT_CARD_LIMIT").equals(""))
		{
			this.setDEBIT_CARD_LIMIT(request.getParameter("DEBIT_CARD_LIMIT"));
		}

		if (request.getParameter("DEBIT_M_A_LIMIT") != null
				&& !request.getParameter("DEBIT_M_A_LIMIT").equals(""))
		{
			this.setDEBIT_M_A_LIMIT(request.getParameter("DEBIT_M_A_LIMIT"));
		}

		if (request.getParameter("TERM_ID2") != null
				&& !request.getParameter("TERM_ID2").equals(""))
		{
			this.setTERM_ID2(request.getParameter("TERM_ID2"));
		}
		if (request.getParameter("DEBIT_M_C_LIMIT") != null
				&& !request.getParameter("DEBIT_M_C_LIMIT").equals(""))
		{
			this.setDEBIT_M_C_LIMIT(request.getParameter("DEBIT_M_C_LIMIT"));
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

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		if (request.getParameter("APPR_DATE") != null
				&& !request.getParameter("APPR_DATE").equals(""))
		{
			this.setAPPR_DATE(format.parse(request.getParameter("APPR_DATE")));
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

		if (request.getParameter("INPUT_DATE") != null
				&& !request.getParameter("INPUT_DATE").equals(""))
		{
			this.setINPUT_DATE(format.parse(request.getParameter("INPUT_DATE")));
		}
		if (request.getParameter("CHANGE_DATE ") != null
				&& !request.getParameter("CHANGE_DATE ").equals(""))
		{
			this.setCHANGE_DATE(format.parse(request
					.getParameter("CHANGE_DATE ")));
		}
		
		if (request.getParameter("SERIAL") != null
			&& !request.getParameter("SERIAL").equals(""))
	{
		this.setSERIAL(request
				.getParameter("SERIAL"));
	}
		
		if (request.getParameter("TERM_TYPE") != null
			&& !request.getParameter("TERM_TYPE").equals(""))
	{
		this.setTERM_TYPE(request
				.getParameter("TERM_TYPE"));
	}
		// --------------新增---------
		// if (request.getParameter("IS_DEFAULT") != null
		// && !request.getParameter("IS_DEFAULT").equals(""))
		// {
		// this.setIS_DEFAULT(Integer.parseInt(request
		// .getParameter("IS_DEFAULT")));
		// }
		// this.setBASE(request.getParameter("BASE"));
		// this.setTOP(request.getParameter("TOP"));
		// this.setCHARGE_CYCLE(Integer.parseInt(request
		// .getParameter("CHARGE_CYCLE")));
		// if (null != request.getParameter("COUNT_DESIRE")
		// && !request.getParameter("IS_DEFAULT").equals(""))
		// {
		// this.setCOUNT_DESIRE(Integer.parseInt(request
		// .getParameter("COUNT_DESIRE")));
		// }
		// if (null != request.getParameter("TER_MONTH_MIN")
		// && !request.getParameter("TER_MONTH_MIN").equals(""))
		// {
		// this.setTER_MONTH_MIN(request.getParameter("TER_MONTH_MIN"));
		// }
		String FEE_SET_TOP = request.getParameter("FEE_SET_TOP");

		String base = this.getFEE_SET().replace("%", "").replace("-", "");

		if ("2".equals(this.getFEE_TYPE()))
		{
			this.setFEE_SET(base + "%");
		} else if ("3".equals(this.getFEE_TYPE()))
		{
			if (null != FEE_SET_TOP)
			{
				this.setFEE_SET(base + "%-" + FEE_SET_TOP);
			}
		} else
			this.setFEE_SET(base);
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

	public String getFEE_TYPE()
	{
		return FEE_TYPE;
	}

	public void setFEE_TYPE(String fEE_TYPE)
	{
		FEE_TYPE = fEE_TYPE;
	}

	public String getFEE_SET()
	{
		return FEE_SET;
	}

	public void setFEE_SET(String fEE_SET)
	{
		FEE_SET = fEE_SET;
	}

	public String getBILL_INFO()
	{
		return BILL_INFO;
	}

	public void setBILL_INFO(String bILL_INFO)
	{
		BILL_INFO = bILL_INFO;
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

	public String getUNIT_NO()
	{
		return UNIT_NO;
	}

	public void setUNIT_NO(String uNIT_NO)
	{
		UNIT_NO = uNIT_NO;
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

	public String getCREDIT_FLAG()
	{
		return CREDIT_FLAG;
	}

	public void setCREDIT_FLAG(String cREDIT_FLAG)
	{
		CREDIT_FLAG = cREDIT_FLAG;
	}

	public String getCREDIT_CARD_LIMIT()
	{
		return CREDIT_CARD_LIMIT;
	}

	public void setCREDIT_CARD_LIMIT(String cREDIT_CARD_LIMIT)
	{
		CREDIT_CARD_LIMIT = cREDIT_CARD_LIMIT;
	}

	public String getCREDIT_M_A_LIMIT()
	{
		return CREDIT_M_A_LIMIT;
	}

	public void setCREDIT_M_A_LIMIT(String cREDIT_M_A_LIMIT)
	{
		CREDIT_M_A_LIMIT = cREDIT_M_A_LIMIT;
	}

	public String getCREDIT_M_C_LIMIT()
	{
		return CREDIT_M_C_LIMIT;
	}

	public void setCREDIT_M_C_LIMIT(String cREDIT_M_C_LIMIT)
	{
		CREDIT_M_C_LIMIT = cREDIT_M_C_LIMIT;
	}

	public String getDEBIT_CARD_LIMIT()
	{
		return DEBIT_CARD_LIMIT;
	}

	public void setDEBIT_CARD_LIMIT(String dEBIT_CARD_LIMIT)
	{
		DEBIT_CARD_LIMIT = dEBIT_CARD_LIMIT;
	}

	public String getDEBIT_M_A_LIMIT()
	{
		return DEBIT_M_A_LIMIT;
	}

	public void setDEBIT_M_A_LIMIT(String dEBIT_M_A_LIMIT)
	{
		DEBIT_M_A_LIMIT = dEBIT_M_A_LIMIT;
	}

	public String getDEBIT_M_C_LIMIT()
	{
		return DEBIT_M_C_LIMIT;
	}

	public void setDEBIT_M_C_LIMIT(String dEBIT_M_C_LIMIT)
	{
		DEBIT_M_C_LIMIT = dEBIT_M_C_LIMIT;
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
