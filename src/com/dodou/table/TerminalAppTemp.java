package com.dodou.table;

import javax.servlet.http.HttpServletRequest;

import com.dodou.inferface.TableBeanInterface;

/**
 * 业务终端对应信息表
 * 
 * @author 陈孟琳
 * 
 */
public class TerminalAppTemp implements TableBeanInterface
{
	private int COMMERCIAL_ID;// NUMBER not null,
	private int TEMINAL_INFO_ID;// NUMBER not null,
	private String APPTYPE;// CHAR(3) not null,
	private String APP_NAME;// VARCHAR(20),
	private String TERM_ID1;// CHAR(16) not null,
	private String TERM_ID2;// CHAR(16),
	private String TERM_ID3;// CHAR(16) not null,
	private String TERM_ID4;// CHAR(16),
	private String MENU_VER;// CHAR(8) not null,
	private String APPDATA_NAME;// VARCHAR(20) not null,
	private int STATUS;// NUMBER not null,
	private int APPPAY_ID;

	public int getAPPPAY_ID()
	{
		return APPPAY_ID;
	}

	public void setAPPPAY_ID(int aPPPAY_ID)
	{
		APPPAY_ID = aPPPAY_ID;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{

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

	public String getAPPTYPE()
	{
		return APPTYPE;
	}

	public void setAPPTYPE(String aPPTYPE)
	{
		APPTYPE = aPPTYPE;
	}

	@Override
	public String toString()
	{
		return "TerminalAppTemp [COMMERCIAL_ID=" + COMMERCIAL_ID
				+ ", TEMINAL_INFO_ID=" + TEMINAL_INFO_ID + ", APPTYPE="
				+ APPTYPE + ", APP_NAME=" + APP_NAME + ", TERM_ID1=" + TERM_ID1
				+ ", TERM_ID2=" + TERM_ID2 + ", TERM_ID3=" + TERM_ID3
				+ ", TERM_ID4=" + TERM_ID4 + ", MENU_VER=" + MENU_VER
				+ ", APPDATA_NAME=" + APPDATA_NAME + ", STATUS=" + STATUS
				+ ", APPPAY_ID=" + APPPAY_ID + "]";
	}

	public String getAPP_NAME()
	{
		return APP_NAME;
	}

	public void setAPP_NAME(String aPP_NAME)
	{
		APP_NAME = aPP_NAME;
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

	public String getMENU_VER()
	{
		return MENU_VER;
	}

	public void setMENU_VER(String mENU_VER)
	{
		MENU_VER = mENU_VER;
	}

	public String getAPPDATA_NAME()
	{
		return APPDATA_NAME;
	}

	public void setAPPDATA_NAME(String aPPDATA_NAME)
	{
		APPDATA_NAME = aPPDATA_NAME;
	}

	public int getSTATUS()
	{
		return STATUS;
	}

	public void setSTATUS(int sTATUS)
	{
		STATUS = sTATUS;
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

}
