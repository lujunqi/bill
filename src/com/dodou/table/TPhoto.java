package com.dodou.table;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TPhoto
{
	private int PHOTO_ID;
	private int TERMINAL_INFO_ID;
	private int APPPAY_TYPE;
	private String UP_DAY;
	private String TYPE;// 图片类型
	private String URL;// url地址

	public int getPHOTO_ID()
	{
		return PHOTO_ID;
	}

	public void setPHOTO_ID(int pHOTO_ID)
	{
		PHOTO_ID = pHOTO_ID;
	}

	public int getTERMINAL_INFO_ID()
	{
		return TERMINAL_INFO_ID;
	}

	public void setTERMINAL_INFO_ID(int tERMINAL_INFO_ID)
	{
		TERMINAL_INFO_ID = tERMINAL_INFO_ID;
	}

	public int getAPPPAY_TYPE()
	{
		return APPPAY_TYPE;
	}

	public void setAPPPAY_TYPE(int aPPPAY_TYPE)
	{
		APPPAY_TYPE = aPPPAY_TYPE;
	}

	public String getUP_DAY()
	{
	    return UP_DAY;
	}

	public void setUP_DAY(String uP_DAY)
	{
		UP_DAY = uP_DAY;
	}

	public String getTYPE()
	{
		return TYPE;
	}

	public void setTYPE(String tYPE)
	{
		TYPE = tYPE;
	}

	public String getURL()
	{
		String url = this.TERMINAL_INFO_ID + "";
		return url;
	}

	public void setURL(String uRL)
	{
		URL = uRL;
	}

}
