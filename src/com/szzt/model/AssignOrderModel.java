package com.szzt.model;

public class AssignOrderModel
{
	private int SAFE_MAN1;
	// 客户信息
	private int COMMERCIAL_ID;
	private String TERM_ID1;
	private int UNIT_ATTR;
	private String CONTACT_NAME_1;
	private String CONTACT_TEL_1;

	// 终端信息
	private String UNIT_INSTALLED_ADD;
	private int TEMINAL_INFO_ID;
	private int compType;
	private String SAFE_MAN;
	// -----
	private int COMP_ID;
	private String COMP_TYPE;
	private String COMP_CONT;// 投诉内容
	private int INPUT_MAN;// 录入人员
	private int OPER_MAN;//
	private String SLOVE_CONT;// 解决反馈
	private String COMP_STATUS;
	private String COMP_DATE;// 投诉时间 timestamp类型
	private String CHANGE_DATE;// 修改时间
	private String UNIT_NAME;

	public String getUNIT_NAME()
	{
		return UNIT_NAME;
	}

	public void setUNIT_NAME(String uNIT_NAME)
	{
		UNIT_NAME = uNIT_NAME;
	}

	public int getCOMP_ID()
	{
		return COMP_ID;
	}

	public void setCOMP_ID(int cOMP_ID)
	{
		COMP_ID = cOMP_ID;
	}

	public String getCOMP_TYPE()
	{
		return COMP_TYPE;
	}

	public void setCOMP_TYPE(String cOMP_TYPE)
	{
		COMP_TYPE = cOMP_TYPE;
	}

	public String getCOMP_CONT()
	{
		return COMP_CONT;
	}

	public void setCOMP_CONT(String cOMP_CONT)
	{
		COMP_CONT = cOMP_CONT;
	}

	public int getINPUT_MAN()
	{
		return INPUT_MAN;
	}

	public void setINPUT_MAN(int iNPUT_MAN)
	{
		INPUT_MAN = iNPUT_MAN;
	}

	public int getOPER_MAN()
	{
		return OPER_MAN;
	}

	public void setOPER_MAN(int oPER_MAN)
	{
		OPER_MAN = oPER_MAN;
	}

	public String getSLOVE_CONT()
	{
		return SLOVE_CONT;
	}

	public void setSLOVE_CONT(String sLOVE_CONT)
	{
		SLOVE_CONT = sLOVE_CONT;
	}

	public String getCOMP_STATUS()
	{
		return COMP_STATUS;
	}

	public void setCOMP_STATUS(String cOMP_STATUS)
	{
		COMP_STATUS = cOMP_STATUS;
	}

	public String getCOMP_DATE()
	{
		return COMP_DATE;
	}

	public void setCOMP_DATE(String cOMP_DATE)
	{
		COMP_DATE = cOMP_DATE;
	}

	public String getCHANGE_DATE()
	{
		return CHANGE_DATE;
	}

	public void setCHANGE_DATE(String cHANGE_DATE)
	{
		CHANGE_DATE = cHANGE_DATE;
	}

	public int getCOMMERCIAL_ID()
	{
		return COMMERCIAL_ID;
	}

	public int getSAFE_MAN1()
	{
		return SAFE_MAN1;
	}

	public void setSAFE_MAN1(int sAFE_MAN1)
	{
		SAFE_MAN1 = sAFE_MAN1;
	}

	public void setCOMMERCIAL_ID(int cOMMERCIAL_ID)
	{
		COMMERCIAL_ID = cOMMERCIAL_ID;
	}

	public String getTERM_ID1()
	{
		return TERM_ID1;
	}

	public void setTERM_ID1(String tERM_ID1)
	{
		TERM_ID1 = tERM_ID1;
	}

	public int getUNIT_ATTR()
	{
		return UNIT_ATTR;
	}

	public void setUNIT_ATTR(int uNIT_ATTR)
	{
		UNIT_ATTR = uNIT_ATTR;
	}

	public String getCONTACT_NAME_1()
	{
		return CONTACT_NAME_1;
	}

	public void setCONTACT_NAME_1(String cONTACT_NAME_1)
	{
		CONTACT_NAME_1 = cONTACT_NAME_1;
	}

	public String getCONTACT_TEL_1()
	{
		return CONTACT_TEL_1;
	}

	public void setCONTACT_TEL_1(String cONTACT_TEL_1)
	{
		CONTACT_TEL_1 = cONTACT_TEL_1;
	}

	public String getUNIT_INSTALLED_ADD()
	{
		return UNIT_INSTALLED_ADD;
	}

	public void setUNIT_INSTALLED_ADD(String uNIT_INSTALLED_ADD)
	{
		UNIT_INSTALLED_ADD = uNIT_INSTALLED_ADD;
	}

	public int getTEMINAL_INFO_ID()
	{
		return TEMINAL_INFO_ID;
	}

	public void setTEMINAL_INFO_ID(int tEMINAL_INFO_ID)
	{
		TEMINAL_INFO_ID = tEMINAL_INFO_ID;
	}

	public int getCompType()
	{
		return compType;
	}

	public void setCompType(int compType)
	{
		this.compType = compType;
	}

	public String getSAFE_MAN()
	{
		return SAFE_MAN;
	}

	public void setSAFE_MAN(String sAFE_MAN)
	{
		SAFE_MAN = sAFE_MAN;
	}

}
