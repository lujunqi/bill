package com.szzt.model;

/**
 * 业务审批信息 （在终端表显示）
 * 
 * @author 陈孟琳
 * 
 */
public class AppayApproveModel
{

	@Override
	public String toString()
	{
		return "AppayApproveModel [APP_TYPE=" + APP_TYPE + ", TERM_ID1="
				+ TERM_ID1 + ", TERM_ID2=" + TERM_ID2 + ", E_ID=" + E_ID
				+ ", APPR_DATE=" + APPR_DATE + ", APPR_STATUS=" + APPR_STATUS
				+ ",MARCHANT_NAME="+MARCHANT_NAME+"]";
	}

	private int APPPAY_ID;
	private int COMMERCIAL_ID;
	private String APP_TYPE;// 业务名称
	private String MARCHANT_NAME;// 门店名称
	public String getMARCHANT_NAME() {
	    return MARCHANT_NAME;
	}

	public void setMARCHANT_NAME(String mARCHANT_NAME) {
	    MARCHANT_NAME = mARCHANT_NAME;
	}

	private String TERM_ID1;// 商户编号
	private String TERM_ID2;// 终端编号
	private String E_ID;// 拓展人姓名
	private String APPR_DATE;// 审批日期
	private int APPR_STATUS;// 业务状态
	private int isBind;// 是否绑定
	private String more;

	public String getMore()
	{
		return more;
	}

	public void setMore(String more)
	{
		this.more = more;
	}

	public int getIsBind()
	{
		return isBind;
	}

	public void setIsBind(int isBind)
	{
		this.isBind = isBind;
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

	public String getAPP_TYPE()
	{
		return APP_TYPE;
	}

	public void setAPP_TYPE(String aPP_TYPE)
	{
		APP_TYPE = aPP_TYPE;
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

	public String getE_ID()
	{
		return E_ID;
	}

	public void setE_ID(String e_ID)
	{
		E_ID = e_ID;
	}

	public String getAPPR_DATE()
	{
		return APPR_DATE;
	}

	public void setAPPR_DATE(String aPPR_DATE)
	{
		APPR_DATE = aPPR_DATE;
	}

	public int getAPPR_STATUS()
	{
		return APPR_STATUS;
	}

	public void setAPPR_STATUS(int aPPR_STATUS)
	{
		APPR_STATUS = aPPR_STATUS;
	}

}
