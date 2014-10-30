package com.dodou.table;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.dodou.inferface.TableBeanInterface;

public class Commercial_Info implements TableBeanInterface
{
	private int COMMERCIAL_ID;
	private String UNIT_NAME = " ";
	private int UNIT_ATTR = 0;
	private String UNIT_ADD = " ";
	private String UNIT_AREA = " ";
	private String COMM_NO = " ";

	private String COMM_NAME = " ";
	private String COMM_AD = " ";
	private String TRADE_NAME = " ";
	private String CONTACT_NAME_1 = " ";
	private String CONTACT_TEL_1 = " ";
	private String CONTACT_NAME_2;
	private String CONTACT_TEL_2;
	private int UNIT_STATUS = 0;
	private String COMM_RATING = "'1'";
	private Date INPUT_DATE = new Date(System.currentTimeMillis());
	private Date CHANGE_DATE = new Date(System.currentTimeMillis());
	private String REMARK_INFO;

	// 新增的信息
	private String COM_SIM_NAME = " ";// VARCHAR(256),
	private String LEGALER_NAME = " "; // VARCHAR(256),
	private String LEGAL_ID_CARD = " ";// ; VARCHAR(256),
	private String UNTI_CODE_CARD;// VARCHAR(256),
	private String TAX_SIGN_CARD;// VARCHAR(256),

	private String CONTACT_EMAIL;// VARCHAR(256),
	private int INPUT_USER_ID;// 录入人员ID

	private String input_name;

	public String getInput_name()
	{
		return input_name;
	}

	public void setInput_name(String input_name)
	{
		this.input_name = input_name;
	}

	/**
	 * 新关系未修改
	 */
	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		// 录入人员ID
		Operman_info info = (Operman_info) request.getSession().getAttribute(
				"man");
		this.setINPUT_USER_ID(info.getDepartid());

		if (null != request.getParameter("COMMERCIAL_ID")
				&& !request.getParameter("COMMERCIAL_ID").equals(""))
		{
			this.setCOMMERCIAL_ID(Integer.parseInt(request
					.getParameter("COMMERCIAL_ID")));
		}

		if (request.getParameter("UNIT_NAME") != null
				&& !request.getParameter("UNIT_NAME").equals(""))
		{
			this.setUNIT_NAME(request.getParameter("UNIT_NAME"));
		}
		// 商户名称
		if (request.getParameter("COMM_NAME") != null
				&& !request.getParameter("COMM_NAME").equals(""))
		{
			this.setCOMM_NAME(request.getParameter("COMM_NAME"));
		}

		if (request.getParameter("UNIT_ADD") != null
				&& !request.getParameter("UNIT_ADD").equals(""))
		{
			this.setUNIT_ADD(request.getParameter("UNIT_ADD"));
		}
		if (request.getParameter("UNIT_AREA") != null
				&& !request.getParameter("UNIT_AREA").equals(""))
		{
			this.setUNIT_AREA(request.getParameter("UNIT_AREA"));
		}
		// 工商执照编码
		if (request.getParameter("COMM_NO") != null
				&& !request.getParameter("COMM_NO").equals(""))
		{
			this.setCOMM_NO(request.getParameter("COMM_NO"));
		}

		if (request.getParameter("COMM_NAME") != null
				&& !request.getParameter("COMM_NAME").equals(""))
		{
			this.setCOMM_NAME(request.getParameter("COMM_NAME"));
		}

		if (request.getParameter("COMM_AD") != null
				&& !request.getParameter("COMM_AD").equals(""))
		{
			this.setCOMM_AD(request.getParameter("COMM_AD"));
		}

		if (request.getParameter("CONTACT_NAME_1") != null
				&& !request.getParameter("CONTACT_NAME_1").equals(""))
		{
			this.setCONTACT_NAME_1(request.getParameter("CONTACT_NAME_1"));
		}
		if (request.getParameter("CONTACT_TEL_1") != null
				&& !request.getParameter("CONTACT_TEL_1").equals(""))
		{
			this.setCONTACT_TEL_1(request.getParameter("CONTACT_TEL_1"));
		}
		// ---
		if (request.getParameter("CONTACT_NAME_2") != null
				&& !request.getParameter("CONTACT_NAME_2").equals(""))
		{
			this.setCONTACT_NAME_2(request.getParameter("CONTACT_NAME_2"));
		}
		if (request.getParameter("CONTACT_TEL_2") != null
				&& !request.getParameter("CONTACT_TEL_2").equals(""))
		{
			this.setCONTACT_TEL_2(request.getParameter("CONTACT_TEL_2"));
		}
		// ---
		if (request.getParameter("TRADE_NAME") != null
				&& !request.getParameter("TRADE_NAME").equals(""))
		{
			this.setTRADE_NAME(request.getParameter("TRADE_NAME"));
		}
		if (request.getParameter("REMARK_INFO") != null
				&& !request.getParameter("REMARK_INFO").equals(""))
		{
			this.setREMARK_INFO(request.getParameter("REMARK_INFO"));
		}
		if (request.getParameter("UNIT_ATTR") != null
				&& !request.getParameter("UNIT_ATTR").equals(""))
		{
			this.setUNIT_ATTR(Integer.parseInt(request
					.getParameter("UNIT_ATTR")));
		}
		this.setUNIT_STATUS(1);
		this.setCHANGE_DATE(new Date(System.currentTimeMillis()));
		this.setINPUT_DATE(new Date(System.currentTimeMillis()));
		this.setCOMM_RATING("1");
	}

	public int getINPUT_USER_ID()
	{
		return INPUT_USER_ID;
	}

	public void setINPUT_USER_ID(int iNPUT_USER_ID)
	{
		INPUT_USER_ID = iNPUT_USER_ID;
	}

	public String getCOM_SIM_NAME()
	{
		return COM_SIM_NAME;
	}

	public void setCOM_SIM_NAME(String cOM_SIM_NAME)
	{
		COM_SIM_NAME = cOM_SIM_NAME;
	}

	public String getLEGALER_NAME()
	{
		return LEGALER_NAME;
	}

	public void setLEGALER_NAME(String lEGALER_NAME)
	{
		LEGALER_NAME = lEGALER_NAME;
	}

	public String getLEGAL_ID_CARD()
	{
		return LEGAL_ID_CARD;
	}

	public void setLEGAL_ID_CARD(String lEGAL_ID_CARD)
	{
		LEGAL_ID_CARD = lEGAL_ID_CARD;
	}

	public String getUNTI_CODE_CARD()
	{
		return UNTI_CODE_CARD;
	}

	public void setUNTI_CODE_CARD(String uNTI_CODE_CARD)
	{
		UNTI_CODE_CARD = uNTI_CODE_CARD;
	}

	public String getTAX_SIGN_CARD()
	{
		return TAX_SIGN_CARD;
	}

	public void setTAX_SIGN_CARD(String tAX_SIGN_CARD)
	{
		TAX_SIGN_CARD = tAX_SIGN_CARD;
	}

	public String getCONTACT_EMAIL()
	{
		return CONTACT_EMAIL;
	}

	public void setCONTACT_EMAIL(String cONTACT_EMAIL)
	{
		CONTACT_EMAIL = cONTACT_EMAIL;
	}

	public int getCOMMERCIAL_ID()
	{
		return COMMERCIAL_ID;
	}

	public void setCOMMERCIAL_ID(int cOMMERCIAL_ID)
	{
		COMMERCIAL_ID = cOMMERCIAL_ID;
	}

	public String getUNIT_NAME()
	{
		return UNIT_NAME;
	}

	public void setUNIT_NAME(String uNIT_NAME)
	{
		UNIT_NAME = uNIT_NAME;
	}

	public int getUNIT_ATTR()
	{
		return UNIT_ATTR;
	}

	public void setUNIT_ATTR(int uNIT_ATTR)
	{
		UNIT_ATTR = uNIT_ATTR;
	}

	public String getUNIT_ADD()
	{
		return UNIT_ADD;
	}

	public void setUNIT_ADD(String uNIT_ADD)
	{
		UNIT_ADD = uNIT_ADD;
	}

	public String getUNIT_AREA()
	{
		return UNIT_AREA;
	}

	public void setUNIT_AREA(String uNIT_AREA)
	{
		UNIT_AREA = uNIT_AREA;
	}

	public String getCOMM_NO()
	{
		return COMM_NO;
	}

	public void setCOMM_NO(String cOMM_NO)
	{
		COMM_NO = cOMM_NO;
	}

	public String getCOMM_NAME()
	{
		return COMM_NAME;
	}

	public void setCOMM_NAME(String cOMM_NAME)
	{
		COMM_NAME = cOMM_NAME;
	}

	public String getCOMM_AD()
	{
		return COMM_AD;
	}

	public void setCOMM_AD(String cOMM_AD)
	{
		COMM_AD = cOMM_AD;
	}

	public String getTRADE_NAME()
	{
		return TRADE_NAME;
	}

	public void setTRADE_NAME(String tRADE_NAME)
	{
		TRADE_NAME = tRADE_NAME;
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

	public String getCONTACT_NAME_2()
	{
		return CONTACT_NAME_2;
	}

	public void setCONTACT_NAME_2(String cONTACT_NAME_2)
	{
		CONTACT_NAME_2 = cONTACT_NAME_2;
	}

	public String getCONTACT_TEL_2()
	{
		return CONTACT_TEL_2;
	}

	public void setCONTACT_TEL_2(String cONTACT_TEL_2)
	{
		CONTACT_TEL_2 = cONTACT_TEL_2;
	}

	public int getUNIT_STATUS()
	{
		return UNIT_STATUS;
	}

	public void setUNIT_STATUS(int uNIT_STATUS)
	{
		UNIT_STATUS = uNIT_STATUS;
	}

	public String getCOMM_RATING()
	{
		return COMM_RATING;
	}

	public void setCOMM_RATING(String cOMM_RATING)
	{
		COMM_RATING = cOMM_RATING;
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

	public String getREMARK_INFO()
	{
		return REMARK_INFO;
	}

	public void setREMARK_INFO(String rEMARK_INFO)
	{
		REMARK_INFO = rEMARK_INFO;
	}

}
