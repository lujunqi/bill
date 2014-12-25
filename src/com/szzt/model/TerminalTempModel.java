package com.szzt.model;

import java.util.Date;

/**
 * 终端与中间表信息级联查询
 * 
 * @author 陈孟琳
 * 
 */
public class TerminalTempModel
{
	private String UNIT_INSTALLED_MAN;
	private String UNIT_INSTALLED_TEL;
	private String UNIT_INSTALLED_CITY;
	private String UNIT_INSTALLED_STREET;
	private int TEMINAL_STATUS;
	private String TERM_ID1;
	private String TERM_ID2;
	private String TERM_ID3;
	private String TERM_ID4;
	private String MORE;
	private int TEMINAL_INFO_ID;
	
	private Date INPUT_DATE;
	private int EQUI_TYPE;
	private int term_version;
	
	
	public Date getINPUT_DATE()
	{
		return INPUT_DATE;
	}

	public void setINPUT_DATE(Date iNPUT_DATE)
	{
		INPUT_DATE = iNPUT_DATE;
	}

	public int getEQUI_TYPE()
	{
		return EQUI_TYPE;
	}

	public void setEQUI_TYPE(int eQUI_TYPE)
	{
		EQUI_TYPE = eQUI_TYPE;
	}

	public String getTERM_ID3()
	{
		return TERM_ID3;
	}

	public void setTERM_ID3(String tERM_ID3)
	{
		TERM_ID3 = tERM_ID3;
	}

	public String getTERM_ID4()
	{
		return TERM_ID4;
	}

	public void setTERM_ID4(String tERM_ID4)
	{
		TERM_ID4 = tERM_ID4;
	}

	private String UNIT_INSTALLED_ADD;
	

	public String getUNIT_INSTALLED_ADD()
	{
		return UNIT_INSTALLED_ADD;
	}

	public void setUNIT_INSTALLED_ADD(String uNIT_INSTALLED_ADD)
	{
		UNIT_INSTALLED_ADD = uNIT_INSTALLED_ADD;
	}

	public String getMORE()
	{
		MORE = "<a href='../insert/terminalInsert.jsp?show=1&terminalId="
				+ this.getTEMINAL_INFO_ID() + "'>详情</a>)";
		return MORE;
	}

	public int getTEMINAL_INFO_ID()
	{
		return TEMINAL_INFO_ID;
	}

	public void setTEMINAL_INFO_ID(int tEMINAL_INFO_ID)
	{
		TEMINAL_INFO_ID = tEMINAL_INFO_ID;
	}

	public void setMORE(String mORE)
	{
		MORE = mORE;
	}

	public String getUNIT_INSTALLED_MAN()
	{
		return UNIT_INSTALLED_MAN;
	}

	public void setUNIT_INSTALLED_MAN(String uNIT_INSTALLED_MAN)
	{
		UNIT_INSTALLED_MAN = uNIT_INSTALLED_MAN;
	}

	public String getUNIT_INSTALLED_TEL()
	{
		return UNIT_INSTALLED_TEL;
	}

	public void setUNIT_INSTALLED_TEL(String uNIT_INSTALLED_TEL)
	{
		UNIT_INSTALLED_TEL = uNIT_INSTALLED_TEL;
	}

	public String getUNIT_INSTALLED_CITY()
	{
		return UNIT_INSTALLED_CITY;
	}

	public void setUNIT_INSTALLED_CITY(String uNIT_INSTALLED_CITY)
	{
		UNIT_INSTALLED_CITY = uNIT_INSTALLED_CITY;
	}

	public String getUNIT_INSTALLED_STREET()
	{
		return UNIT_INSTALLED_STREET;
	}

	public void setUNIT_INSTALLED_STREET(String uNIT_INSTALLED_STREET)
	{
		UNIT_INSTALLED_STREET = uNIT_INSTALLED_STREET;
	}

	public int getTEMINAL_STATUS()
	{
		return TEMINAL_STATUS;
	}

	public void setTEMINAL_STATUS(int tEMINAL_STATUS)
	{
		TEMINAL_STATUS = tEMINAL_STATUS;
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

	public int getTerm_version() {
		return term_version;
	}

	public void setTerm_version(int term_version) {
		this.term_version = term_version;
	}

}
