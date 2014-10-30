package com.dodou.table;

import javax.servlet.http.HttpServletRequest;

import com.dodou.inferface.TableBeanInterface;

/**
 * 操作员信息
 * 
 * @author 陈孟琳
 * 
 */
public class OperaManInfo implements TableBeanInterface
{
	private int OPERMAN_ID;
	private int POST_ID;
	private String OPERMAN_NAME;// 人员姓名
	private String OPER_PASS;// 密码
	private String OPER_COMP;// 岗位
	private int OPER_STATUS;
	private String OPER_ADDRESS;// 地区
	private String DEPA_NAME;// 部门名称
	private String ACCOUT;// 账号
	private int DEPARTID;// 部门ID
	private String BANK_ACCOUNT;//银行账号
	public int getOPERMAN_ID()
	{
		return OPERMAN_ID;
	}
	public void setOPERMAN_ID(int oPERMAN_ID)
	{
		OPERMAN_ID = oPERMAN_ID;
	}
	public int getPOST_ID()
	{
		return POST_ID;
	}
	public void setPOST_ID(int pOST_ID)
	{
		POST_ID = pOST_ID;
	}
	public String getOPERMAN_NAME()
	{
		return OPERMAN_NAME;
	}
	public void setOPERMAN_NAME(String oPERMAN_NAME)
	{
		OPERMAN_NAME = oPERMAN_NAME;
	}
	public String getOPER_PASS()
	{
		return OPER_PASS;
	}
	public void setOPER_PASS(String oPER_PASS)
	{
		OPER_PASS = oPER_PASS;
	}
	public String getOPER_COMP()
	{
		return OPER_COMP;
	}
	public void setOPER_COMP(String oPER_COMP)
	{
		OPER_COMP = oPER_COMP;
	}
	public int getOPER_STATUS()
	{
		return OPER_STATUS;
	}
	public void setOPER_STATUS(int oPER_STATUS)
	{
		OPER_STATUS = oPER_STATUS;
	}
	public String getOPER_ADDRESS()
	{
		return OPER_ADDRESS;
	}
	public void setOPER_ADDRESS(String oPER_ADDRESS)
	{
		OPER_ADDRESS = oPER_ADDRESS;
	}
	public String getDEPA_NAME()
	{
		return DEPA_NAME;
	}
	public void setDEPA_NAME(String dEPA_NAME)
	{
		DEPA_NAME = dEPA_NAME;
	}
	public String getACCOUT()
	{
		return ACCOUT;
	}
	public void setACCOUT(String aCCOUT)
	{
		ACCOUT = aCCOUT;
	}
	public int getDEPARTID()
	{
		return DEPARTID;
	}
	public void setDEPARTID(int dEPARTID)
	{
		DEPARTID = dEPARTID;
	}
	public String getBANK_ACCOUNT()
	{
		return BANK_ACCOUNT;
	}
	public void setBANK_ACCOUNT(String bANK_ACCOUNT)
	{
		BANK_ACCOUNT = bANK_ACCOUNT;
	}
	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		
	}
	

}
