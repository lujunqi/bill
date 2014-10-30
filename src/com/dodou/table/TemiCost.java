package com.dodou.table;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.dodou.inferface.TableBeanInterface;

/**
 * 机具费用对象
 * 
 * @author 陈孟琳
 * 
 */
public class TemiCost implements TableBeanInterface
{
	private int COSTTYPEID;
	private int TEMINAL_INFO_ID;
	private String COST_NAME;
	private int COST_TYPE;// 费用类型
	private String COSTNUMBER;
	private String MONEY;
	private int CYCLE;
	private Date STARTDATE;
	private Date FINALDATE;
	private Date REFUNDDATE;
	private int STATUS=1;

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{

	}

	public int getCOSTTYPEID()
	{
		return COSTTYPEID;
	}

	public void setCOSTTYPEID(int cOSTTYPEID)
	{
		COSTTYPEID = cOSTTYPEID;
	}

	public int getTEMINAL_INFO_ID()
	{
		return TEMINAL_INFO_ID;
	}

	public void setTEMINAL_INFO_ID(int tEMINAL_INFO_ID)
	{
		TEMINAL_INFO_ID = tEMINAL_INFO_ID;
	}

	public String getCOST_NAME()
	{
		return COST_NAME;
	}

	public void setCOST_NAME(String cOST_NAME)
	{
		COST_NAME = cOST_NAME;
	}

	public int getCOST_TYPE()
	{
		return COST_TYPE;
	}

	public void setCOST_TYPE(int cOST_TYPE)
	{
		COST_TYPE = cOST_TYPE;
	}

	public String getCOSTNUMBER()
	{
		return COSTNUMBER;
	}

	public void setCOSTNUMBER(String cOSTNUMBER)
	{
		COSTNUMBER = cOSTNUMBER;
	}

	public String getMONEY()
	{
		return MONEY;
	}

	public void setMONEY(String mONEY)
	{
		MONEY = mONEY;
	}

	public int getCYCLE()
	{
		return CYCLE;
	}

	public void setCYCLE(int cYCLE)
	{
		CYCLE = cYCLE;
	}

	public Date getSTARTDATE()
	{
		return STARTDATE;
	}

	public void setSTARTDATE(Date sTARTDATE)
	{
		STARTDATE = sTARTDATE;
	}

	public Date getFINALDATE()
	{
		return FINALDATE;
	}

	public void setFINALDATE(Date fINALDATE)
	{
		FINALDATE = fINALDATE;
	}

	public Date getREFUNDDATE()
	{
		return REFUNDDATE;
	}

	public void setREFUNDDATE(Date rEFUNDDATE)
	{
		REFUNDDATE = rEFUNDDATE;
	}

	public int getSTATUS()
	{
		return STATUS;
	}

	public void setSTATUS(int sTATUS)
	{
		STATUS = sTATUS;
	}

	@Override
	public String toString()
	{
		return "TemiCost [COSTTYPEID=" + COSTTYPEID + ", TEMINAL_INFO_ID="
				+ TEMINAL_INFO_ID + ", COST_NAME=" + COST_NAME + ", COST_TYPE="
				+ COST_TYPE + ", COSTNUMBER=" + COSTNUMBER + ", MONEY=" + MONEY
				+ ", CYCLE=" + CYCLE + ", STARTDATE=" + STARTDATE
				+ ", FINALDATE=" + FINALDATE + ", REFUNDDATE=" + REFUNDDATE
				+ ", STATUS=" + STATUS + "]";
	}

}
