package com.dodou.table;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.dodou.inferface.TableBeanInterface;

public class Terminal_Info implements TableBeanInterface
{
	private int TEMINAL_INFO_ID;
	// 客户id默认使用
	private int COMMERCIAL_ID = 1;
	private String UNIT_INSTALLED_MAN = "";
	private String UNIT_INSTALLED_TEL = "";
	private String UNIT_INSTALLED_CITY = "";
	private String UNIT_INSTALLED_STREET = "";
	private String UNIT_INSTALLED_NAME = "";
	private String UNIT_INSTALLED_ADD = "";
	private int TEMINAL_PRODUCT = 0;
	private int EQUI_TYPE = 0;
	private String SERIAL1;
	private String SERIAL2;
	private int COSTTYPEID = 0;
	private int DEBUG_MAN = 0;
	private int INST_MAN = 0;
	private int SAFE_MAN = 0;
	private int IS_HURRY = 0;
	private Date INSTALL_DATE;
	private Date INSTALL_END_DATE;
	private Date WITHDRAWAL_DATE;
	private Date ARCHIVE_DATE;
	private int INSTALLED_STATUS;
	private Date APPROVAL_DATE;
	private int TEMINAL_STATUS = 1;// 录入的时候默认为1
	private int COMM_TYPE;
	private int IS_BIND;
	private String COMM;
	private Date INPUT_DATE;
	private Date CHANGE_DATE;
	private String REMARK_INFO = "";
	private int E_ID;// 拓展人
	private int IS_OVERLAY;// 叠加便民
	private int term_version ;//菜单版本
	
	private Date CANCEL_TIME;// 撤机时间
	
	

	public Date getCANCEL_TIME()
	{
		return CANCEL_TIME;
	}

	public void setCANCEL_TIME(Date cANCEL_TIME)
	{
		CANCEL_TIME = cANCEL_TIME;
	}

	public int getIS_OVERLAY()
	{
		return IS_OVERLAY;
	}

	public void setIS_OVERLAY(int iS_OVERLAY)
	{
		IS_OVERLAY = iS_OVERLAY;
	}

	public Terminal_Info()
	{
		// TODO Auto-generated constructor stub
	}

	public int getE_ID()
	{
		return E_ID;
	}

	public void setE_ID(int e_ID)
	{
		E_ID = e_ID;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		System.out.println("=---------------------------终端客户ID-----"
				+ request.getParameter("COMMERCIAL_ID"));
		System.out.println("客户备注：" + request.getParameter("COMM"));
		// 注入客户的ID信息
		this.setCOMMERCIAL_ID(Integer.parseInt(request
				.getParameter("COMMERCIAL_ID")));

		if (request.getParameter("TEMINAL_INFO_ID") != null
				&& !request.getParameter("TEMINAL_INFO_ID").equals(""))
		{
			this.setTEMINAL_INFO_ID(Integer.parseInt(request
					.getParameter("TEMINAL_INFO_ID")));
		}
		if (request.getParameter("term_version") != null
				&& !request.getParameter("term_version").equals(""))
		{
			this.setTerm_version(Integer.parseInt(request
					.getParameter("term_version")));
		}

		if (request.getParameter("REMARK_INFO") != null
				&& !request.getParameter("UNIT_INSTALLED_MAN").equals(""))
		{
			this.REMARK_INFO = request.getParameter("REMARK_INFO");
		}
		if (request.getParameter("UNIT_INSTALLED_MAN") != null
				&& !request.getParameter("UNIT_INSTALLED_MAN").equals(""))
		{
			this.setUNIT_INSTALLED_MAN(request
					.getParameter("UNIT_INSTALLED_MAN"));
		}
		if (request.getParameter("UNIT_INSTALLED_TEL") != null
				&& !request.getParameter("UNIT_INSTALLED_TEL").equals(""))
		{
			this.setUNIT_INSTALLED_TEL(request
					.getParameter("UNIT_INSTALLED_TEL"));
		}
		if (request.getParameter("UNIT_INSTALLED_CITY") != null
				&& !request.getParameter("UNIT_INSTALLED_CITY").equals(""))
		{
			this.setUNIT_INSTALLED_CITY(request
					.getParameter("UNIT_INSTALLED_CITY"));
		}
		if (request.getParameter("UNIT_INSTALLED_STREET") != null
				&& !request.getParameter("UNIT_INSTALLED_STREET").equals(""))
		{
			this.setUNIT_INSTALLED_STREET(request
					.getParameter("UNIT_INSTALLED_STREET"));
		}
		if (request.getParameter("UNIT_INSTALLED_ADD") != null
				&& !request.getParameter("UNIT_INSTALLED_ADD").equals(""))
		{
			this.setUNIT_INSTALLED_ADD(request
					.getParameter("UNIT_INSTALLED_ADD"));
		}

		if (request.getParameter("TEMINAL_PRODUCT") != null
				&& !request.getParameter("TEMINAL_PRODUCT").equals(""))
		{
			this.setTEMINAL_PRODUCT(Integer.parseInt(request
					.getParameter("TEMINAL_PRODUCT")));
		}

		if (request.getParameter("EQUI_TYPE") != null
				&& !request.getParameter("EQUI_TYPE").equals(""))
		{
			this.setEQUI_TYPE(Integer.parseInt(request
					.getParameter("EQUI_TYPE")));
		}

		if (request.getParameter("IS_HURRY") != null
				&& !request.getParameter("IS_HURRY").equals(""))
		{
			this.setIS_HURRY(Integer.parseInt(request.getParameter("IS_HURRY")));
		}

		if (request.getParameter("COMM_TYPE") != null
				&& !request.getParameter("COMM_TYPE").equals(""))
		{
			this.setCOMM_TYPE(Integer.parseInt(request
					.getParameter("COMM_TYPE")));
		}
		if (request.getParameter("IS_BIND") != null
				&& !request.getParameter("IS_BIND").equals(""))
		{
			this.setIS_BIND(Integer.parseInt(request.getParameter("IS_BIND")));
		}

		if (request.getParameter("COMM") != null
				&& !request.getParameter("COMM").equals(""))
		{
			this.setCOMM(request.getParameter("COMM"));
		}

		if (request.getParameter("SERIAL1") != null
				&& !request.getParameter("SERIAL1").equals(""))
		{
			this.setSERIAL1(request.getParameter("SERIAL1"));
		}
		if (request.getParameter("SERIAL2") != null
				&& !request.getParameter("SERIAL2").equals(""))
		{
			this.setSERIAL2(request.getParameter("SERIAL2"));
		}

		// 机具调试人整形数据？？？？？？？？？？？？？
		if (request.getParameter("DEBUG_MAN") != null
				&& !request.getParameter("DEBUG_MAN").equals(""))
		{
			this.setDEBUG_MAN(Integer.parseInt(request
					.getParameter("DEBUG_MAN")));
		}
		if (request.getParameter("INST_MAN") != null
				&& !request.getParameter("INST_MAN").equals(""))
		{
			this.setINST_MAN(Integer.parseInt(request.getParameter("INST_MAN")));
		}

		if (request.getParameter("SAFE_MAN") != null
				&& !request.getParameter("SAFE_MAN").equals(""))
		{
			this.setSAFE_MAN(Integer.parseInt(request.getParameter("SAFE_MAN")));
		}
		if (request.getParameter("INSTALLED_STATUS") != null
				&& !request.getParameter("INSTALLED_STATUS").equals(""))
		{
			this.setINSTALLED_STATUS(Integer.parseInt(request
					.getParameter("INSTALLED_STATUS")));
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

		if (request.getParameter("INSTALL_DATE") != null
				&& !request.getParameter("INSTALL_DATE").equals(""))
		{
			this.setINPUT_DATE(format.parse(request
					.getParameter("INSTALL_DATE")));
		}
		if (request.getParameter("INSTALL_END_DATE") != null
				&& !request.getParameter("INSTALL_END_DATE").equals(""))
		{
			this.setINSTALL_END_DATE(format.parse(request
					.getParameter("INSTALL_END_DATE")));
		}
		// -----------------新增的-----------
		if (request.getParameter("E_ID") != null
				&& !request.getParameter("E_ID").equals(""))
		{
			this.setE_ID(Integer.parseInt(request.getParameter("E_ID")));
		}
		if (request.getParameter("IS_OVERLAY") != null
				&& !request.getParameter("IS_OVERLAY").equals(""))
		{
			this.setIS_OVERLAY(Integer.parseInt(request
					.getParameter("IS_OVERLAY")));
		}
	}

	public int getTEMINAL_INFO_ID()
	{
		return TEMINAL_INFO_ID;
	}

	public void setTEMINAL_INFO_ID(int tEMINAL_INFO_ID)
	{
		TEMINAL_INFO_ID = tEMINAL_INFO_ID;
	}

	public int getCOMMERCIAL_ID()
	{
		return COMMERCIAL_ID;
	}

	public void setCOMMERCIAL_ID(int cOMMERCIAL_ID)
	{
		COMMERCIAL_ID = cOMMERCIAL_ID;
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

	public String getUNIT_INSTALLED_NAME()
	{
		return UNIT_INSTALLED_NAME;
	}

	public void setUNIT_INSTALLED_NAME(String uNIT_INSTALLED_NAME)
	{
		UNIT_INSTALLED_NAME = uNIT_INSTALLED_NAME;
	}

	public String getUNIT_INSTALLED_ADD()
	{
		return UNIT_INSTALLED_ADD;
	}

	public void setUNIT_INSTALLED_ADD(String uNIT_INSTALLED_ADD)
	{
		UNIT_INSTALLED_ADD = uNIT_INSTALLED_ADD;
	}

	public int getTEMINAL_PRODUCT()
	{
		return TEMINAL_PRODUCT;
	}

	public void setTEMINAL_PRODUCT(int tEMINAL_PRODUCT)
	{
		TEMINAL_PRODUCT = tEMINAL_PRODUCT;
	}

	public int getEQUI_TYPE()
	{
		return EQUI_TYPE;
	}

	public void setEQUI_TYPE(int eQUI_TYPE)
	{
		EQUI_TYPE = eQUI_TYPE;
	}

	public String getSERIAL1()
	{
		return SERIAL1;
	}

	public void setSERIAL1(String sERIAL1)
	{
		SERIAL1 = sERIAL1;
	}

	public String getSERIAL2()
	{
		return SERIAL2;
	}

	public void setSERIAL2(String sERIAL2)
	{
		SERIAL2 = sERIAL2;
	}

	public int getCOSTTYPEID()
	{
		return COSTTYPEID;
	}

	public void setCOSTTYPEID(int cOSTTYPEID)
	{
		COSTTYPEID = cOSTTYPEID;
	}

	public int getDEBUG_MAN()
	{
		return DEBUG_MAN;
	}

	public void setDEBUG_MAN(int dEBUG_MAN)
	{
		DEBUG_MAN = dEBUG_MAN;
	}

	public int getINST_MAN()
	{
		return INST_MAN;
	}

	public void setINST_MAN(int iNST_MAN)
	{
		INST_MAN = iNST_MAN;
	}

	public int getSAFE_MAN()
	{
		return SAFE_MAN;
	}

	public void setSAFE_MAN(int sAFE_MAN)
	{
		SAFE_MAN = sAFE_MAN;
	}

	public int getIS_HURRY()
	{
		return IS_HURRY;
	}

	public void setIS_HURRY(int iS_HURRY)
	{
		IS_HURRY = iS_HURRY;
	}

	public Date getINSTALL_DATE()
	{
		return INSTALL_DATE;
	}

	public void setINSTALL_DATE(Date iNSTALL_DATE)
	{
		INSTALL_DATE = iNSTALL_DATE;
	}

	public Date getINSTALL_END_DATE()
	{
		return INSTALL_END_DATE;
	}

	public void setINSTALL_END_DATE(Date iNSTALL_END_DATE)
	{
		INSTALL_END_DATE = iNSTALL_END_DATE;
	}

	public Date getWITHDRAWAL_DATE()
	{
		return WITHDRAWAL_DATE;
	}

	public void setWITHDRAWAL_DATE(Date wITHDRAWAL_DATE)
	{
		WITHDRAWAL_DATE = wITHDRAWAL_DATE;
	}

	public Date getARCHIVE_DATE()
	{
		return ARCHIVE_DATE;
	}

	public void setARCHIVE_DATE(Date aRCHIVE_DATE)
	{
		ARCHIVE_DATE = aRCHIVE_DATE;
	}

	public int getINSTALLED_STATUS()
	{
		return INSTALLED_STATUS;
	}

	public void setINSTALLED_STATUS(int iNSTALLED_STATUS)
	{
		INSTALLED_STATUS = iNSTALLED_STATUS;
	}

	public Date getAPPROVAL_DATE()
	{
		return APPROVAL_DATE;
	}

	public void setAPPROVAL_DATE(Date aPPROVAL_DATE)
	{
		APPROVAL_DATE = aPPROVAL_DATE;
	}

	public int getTEMINAL_STATUS()
	{
		return TEMINAL_STATUS;
	}

	public void setTEMINAL_STATUS(int tEMINAL_STATUS)
	{
		TEMINAL_STATUS = tEMINAL_STATUS;
	}

	public int getCOMM_TYPE()
	{
		return COMM_TYPE;
	}

	public void setCOMM_TYPE(int cOMM_TYPE)
	{
		COMM_TYPE = cOMM_TYPE;
	}

	public int getIS_BIND()
	{
		return IS_BIND;
	}

	public void setIS_BIND(int iS_BIND)
	{
		IS_BIND = iS_BIND;
	}

	public String getCOMM()
	{
		return COMM;
	}

	public void setCOMM(String cOMM)
	{
		COMM = cOMM;
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

	public int getTerm_version() {
		return term_version;
	}

	public void setTerm_version(int term_version) {
		this.term_version = term_version;
	}

}
