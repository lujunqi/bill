package com.dodou.table;

/**
 * 用户角色信息对应表
 * 
 * @author 陈孟琳
 * 
 */
public class UserRoleInfo
{
	// 操作员ID
	private int OPERMAN_ID;
	// 职位Id
	private int POST_ID;

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

}
