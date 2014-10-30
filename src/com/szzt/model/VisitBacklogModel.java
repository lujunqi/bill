package com.szzt.model;

import java.util.Date;

import com.dodou.table.Teminal_info_visit_call;

/**
 * 回访待办业务模型对象
 * 
 * @author 陈孟琳
 * 
 */
public class VisitBacklogModel extends Teminal_info_visit_call
{
	// 中间表
	private int COMMERCIAL_ID;// NUMBER not null,
	private int TEMINAL_INFO_ID;// NUMBER not null,
	private String TERM_ID1;// 商户编号
	private String TERM_ID2;// 终端编号
	// 客户表
	private String UNIT_NAME;
	private String UNIT_AREA;

	private int is_hurry;
	private int TEMINAL_INFO_VISIT_CALL_ID;
	private Date APPROVAL_DATE;
	private String DEMO;
	private String SAFE_MAN;
	private String typeUndo = "待回访";

	public String getTypeUndo()
	{
		return typeUndo;
	}

	public String getSAFE_MAN()
	{
		return SAFE_MAN;
	}

	public void setSAFE_MAN(String sAFE_MAN)
	{
		SAFE_MAN = sAFE_MAN;
	}

	public int getTEMINAL_INFO_VISIT_CALL_ID()
	{
		return TEMINAL_INFO_VISIT_CALL_ID;
	}

	public void setTEMINAL_INFO_VISIT_CALL_ID(int tEMINAL_INFO_VISIT_CALL_ID)
	{
		TEMINAL_INFO_VISIT_CALL_ID = tEMINAL_INFO_VISIT_CALL_ID;
	}

	public int getIs_hurry()
	{
		return is_hurry;
	}

	public void setIs_hurry(int is_hurry)
	{
		this.is_hurry = is_hurry;
	}

	public void setTypeUndo(String typeUndo)
	{
		this.typeUndo = typeUndo;
	}

	public int getCOMMERCIAL_ID()
	{
		return COMMERCIAL_ID;
	}

	public void setCOMMERCIAL_ID(int cOMMERCIAL_ID)
	{
		COMMERCIAL_ID = cOMMERCIAL_ID;
	}

	public int getTEMINAL_INFO_ID()
	{
		return TEMINAL_INFO_ID;
	}

	public void setTEMINAL_INFO_ID(int tEMINAL_INFO_ID)
	{
		TEMINAL_INFO_ID = tEMINAL_INFO_ID;
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

	public String getUNIT_NAME()
	{
		return UNIT_NAME;
	}

	public void setUNIT_NAME(String uNIT_NAME)
	{
		UNIT_NAME = uNIT_NAME;
	}

	public String getUNIT_AREA()
	{
		return UNIT_AREA;
	}

	public void setUNIT_AREA(String uNIT_AREA)
	{
		UNIT_AREA = uNIT_AREA;
	}

	public Date getAPPROVAL_DATE()
	{
		return APPROVAL_DATE;
	}

	public void setAPPROVAL_DATE(Date aPPROVAL_DATE)
	{
		APPROVAL_DATE = aPPROVAL_DATE;
	}

	public String getDEMO()
	{
		return DEMO;
	}

	public void setDEMO(String dEMO)
	{
		DEMO = dEMO;
	}

}
