package com.cml.zyh;

import java.sql.Timestamp;
import javax.servlet.http.HttpServletRequest;
import com.dodou.util.*;

public class Teminal_info
{
	private String install_comp_date;
	private String host_seq;
	private String key_seq;
	private String equi_type;
	private String equi_tel_no;
	private int is_hurry;
	private String secu_depo;
	private String teminalno;
	private String approval_date;
	private String teminal_busi;
	private int debug_man;
	private int inst_man;
	private int safe_man;
	private String acco_no;
	private int teminal_status;
	private String install_date;
	private String input_date;
	private String change_date;
	private int teminal_info_id;
	private int merchantsno_id;
	private String merchantsno;
	private String installed_man;
	private String installed_tel;
	private String installed_add;
	private String teminal_product;
	private int is_success;
	private String depo_time;

	public String getDepo_time()
	{
		return depo_time;
	}

	public void setDepo_time(String depo_time)
	{
		this.depo_time = depo_time;
	}

	public int getIs_success()
	{
		return is_success;
	}

	public void setIs_success(int is_success)
	{
		this.is_success = is_success;
	}

	// ljn add
	private Integer comm_fee;
	private String comm_fee_time;
	private String recipet_date;
	private Integer serv_fee;
	private String serv_fee_time;
	private String serv_recipet_date;
	private String comm_recipet_date;
	private String demo;
	private String install_end_date;
	private String s_city;
	private String s_county;

	// end

	public String getS_city()
	{
		return s_city;
	}

	public void setS_city(String s_city)
	{
		this.s_city = s_city;
	}

	public String getS_county()
	{
		return s_county;
	}

	public void setS_county(String s_county)
	{
		this.s_county = s_county;
	}

	public String getInstall_end_date()
	{
		return install_end_date;
	}

	public void setInstall_end_date(String install_end_date)
	{
		this.install_end_date = install_end_date;
	}

	public String getDemo()
	{
		return demo;
	}

	public void setDemo(String demo)
	{
		this.demo = demo;
	}

	public String getInstall_comp_date()
	{
		return install_comp_date;
	}

	public void setInstall_comp_date(String install_comp_date)
	{
		this.install_comp_date = install_comp_date;
	}

	public String getHost_seq()
	{
		return host_seq;
	}

	public void setHost_seq(String host_seq)
	{
		this.host_seq = host_seq;
	}

	public String getKey_seq()
	{
		return key_seq;
	}

	public void setKey_seq(String key_seq)
	{
		this.key_seq = key_seq;
	}

	public String getEqui_type()
	{
		return equi_type;
	}

	public void setEqui_type(String equi_type)
	{
		this.equi_type = equi_type;
	}

	public String getEqui_tel_no()
	{
		return equi_tel_no;
	}

	public void setEqui_tel_no(String equi_tel_no)
	{
		this.equi_tel_no = equi_tel_no;
	}

	public int getIs_hurry()
	{
		return is_hurry;
	}

	public void setIs_hurry(int is_hurry)
	{
		this.is_hurry = is_hurry;
	}

	public String getSecu_depo()
	{
		return secu_depo;
	}

	public void setSecu_depo(String secu_depo)
	{
		this.secu_depo = secu_depo;
	}

	public String getTeminalno()
	{
		return teminalno;
	}

	public void setTeminalno(String teminalno)
	{
		this.teminalno = teminalno;
	}

	public String getApproval_date()
	{
		return approval_date;
	}

	public void setApproval_date(String approval_date)
	{
		this.approval_date = approval_date;
	}

	public String getTeminal_busi()
	{
		return teminal_busi;
	}

	public void setTeminal_busi(String teminal_busi)
	{
		this.teminal_busi = teminal_busi;
	}

	public int getDebug_man()
	{
		return debug_man;
	}

	public void setDebug_man(int debug_man)
	{
		this.debug_man = debug_man;
	}

	public int getInst_man()
	{
		return inst_man;
	}

	public void setInst_man(int inst_man)
	{
		this.inst_man = inst_man;
	}

	public int getSafe_man()
	{
		return safe_man;
	}

	public void setSafe_man(int safe_man)
	{
		this.safe_man = safe_man;
	}

	public String getAcco_no()
	{
		return acco_no;
	}

	public void setAcco_no(String acco_no)
	{
		this.acco_no = acco_no;
	}

	public int getTeminal_status()
	{
		return teminal_status;
	}

	public void setTeminal_status(int teminal_status)
	{
		this.teminal_status = teminal_status;
	}

	public String getInstall_date()
	{
		return install_date;
	}

	public void setInstall_date(String install_date)
	{
		this.install_date = install_date;
	}

	public String getInput_date()
	{
		return input_date;
	}

	public void setInput_date(String input_date)
	{
		this.input_date = input_date;
	}

	public String getChange_date()
	{
		return change_date;
	}

	public void setChange_date(String change_date)
	{
		this.change_date = change_date;
	}

	public int getTeminal_info_id()
	{
		return teminal_info_id;
	}

	public void setTeminal_info_id(int teminal_info_id)
	{
		this.teminal_info_id = teminal_info_id;
	}

	public int getMerchantsno_id()
	{
		return merchantsno_id;
	}

	public void setMerchantsno_id(int merchantsno_id)
	{
		this.merchantsno_id = merchantsno_id;
	}

	public String getMerchantsno()
	{
		return merchantsno;
	}

	public void setMerchantsno(String merchantsno)
	{
		this.merchantsno = merchantsno;
	}

	public String getInstalled_man()
	{
		return installed_man;
	}

	public void setInstalled_man(String installed_man)
	{
		this.installed_man = installed_man;
	}

	public String getInstalled_tel()
	{
		return installed_tel;
	}

	public void setInstalled_tel(String installed_tel)
	{
		this.installed_tel = installed_tel;
	}

	public String getInstalled_add()
	{
		return installed_add;
	}

	public void setInstalled_add(String installed_add)
	{
		this.installed_add = installed_add;
	}

	public String getTeminal_product()
	{
		return teminal_product;
	}

	public void setTeminal_product(String teminal_product)
	{
		this.teminal_product = teminal_product;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		if (request.getParameter("install_comp_date") != null
				&& !request.getParameter("install_comp_date").equals(""))
		{
			this.setInstall_comp_date(request.getParameter("install_comp_date"));
		}
		if (request.getParameter("host_seq") != null
				&& !request.getParameter("host_seq").equals(""))
		{
			this.setHost_seq(request.getParameter("host_seq"));
		}
		if (request.getParameter("key_seq") != null
				&& !request.getParameter("key_seq").equals(""))
		{
			this.setKey_seq(request.getParameter("key_seq"));
		}
		if (request.getParameter("equi_type") != null
				&& !request.getParameter("equi_type").equals(""))
		{
			this.setEqui_type(request.getParameter("equi_type"));
		}
		if (request.getParameter("equi_tel_no") != null
				&& !request.getParameter("equi_tel_no").equals(""))
		{
			this.setEqui_tel_no(request.getParameter("equi_tel_no"));
		}
		if (request.getParameter("is_hurry") != null
				&& !request.getParameter("is_hurry").equals(""))
		{
			this.setIs_hurry(Integer.parseInt(request.getParameter("is_hurry")));
		}
		if (request.getParameter("secu_depo") != null
				&& !request.getParameter("secu_depo").equals(""))
		{
			this.setSecu_depo(request.getParameter("secu_depo"));
		}
		if (request.getParameter("teminalno") != null
				&& !request.getParameter("teminalno").equals(""))
		{
			this.setTeminalno(request.getParameter("teminalno"));
		}
		if (request.getParameter("approval_date") != null
				&& !request.getParameter("approval_date").equals(""))
		{
			this.setApproval_date(request.getParameter("approval_date"));
		}
		if (request.getParameter("teminal_busi") != null
				&& !request.getParameter("teminal_busi").equals(""))
		{
			this.setTeminal_busi(request.getParameter("teminal_busi"));
		}
		if (request.getParameter("debug_man") != null
				&& !request.getParameter("debug_man").equals(""))
		{
			this.setDebug_man(Integer.parseInt(request
					.getParameter("debug_man")));
		}
		if (request.getParameter("inst_man") != null
				&& !request.getParameter("inst_man").equals(""))
		{
			this.setInst_man(Integer.parseInt(request.getParameter("inst_man")));
		}
		if (request.getParameter("safe_man") != null
				&& !request.getParameter("safe_man").equals(""))
		{
			this.setSafe_man(Integer.parseInt(request.getParameter("safe_man")));
		}
		if (request.getParameter("acco_no") != null
				&& !request.getParameter("acco_no").equals(""))
		{
			this.setAcco_no(request.getParameter("acco_no"));
		}
		if (request.getParameter("teminal_status") != null
				&& !request.getParameter("teminal_status").equals(""))
		{
			this.setTeminal_status(Integer.parseInt(request
					.getParameter("teminal_status")));
		}
		if (request.getParameter("install_date") != null
				&& !request.getParameter("install_date").equals(""))
		{
			this.setInstall_date(request.getParameter("install_date"));
		}
		if (request.getParameter("input_date") != null
				&& !request.getParameter("input_date").equals(""))
		{
			this.setInput_date(request.getParameter("input_date"));
		}
		if (request.getParameter("change_date") != null
				&& !request.getParameter("change_date").equals(""))
		{
			this.setChange_date(request.getParameter("change_date"));
		}
		if (request.getParameter("teminal_info_id") != null
				&& !request.getParameter("teminal_info_id").equals(""))
		{
			this.setTeminal_info_id(Integer.parseInt(request
					.getParameter("teminal_info_id")));
		}
		if (request.getParameter("merchantsno_id") != null
				&& !request.getParameter("merchantsno_id").equals(""))
		{
			this.setMerchantsno_id(Integer.parseInt(request
					.getParameter("merchantsno_id")));
		}
		if (request.getParameter("merchantsno") != null
				&& !request.getParameter("merchantsno").equals(""))
		{
			this.setMerchantsno(request.getParameter("merchantsno"));
		}
		if (request.getParameter("installed_man") != null
				&& !request.getParameter("installed_man").equals(""))
		{
			this.setInstalled_man(request.getParameter("installed_man"));
		}
		if (request.getParameter("installed_tel") != null
				&& !request.getParameter("installed_tel").equals(""))
		{
			this.setInstalled_tel(request.getParameter("installed_tel"));
		}
		if (request.getParameter("installed_add") != null
				&& !request.getParameter("installed_add").equals(""))
		{
			this.setInstalled_add(request.getParameter("installed_add"));
		}
		if (request.getParameter("teminal_product") != null
				&& !request.getParameter("teminal_product").equals(""))
		{
			this.setTeminal_product(request.getParameter("teminal_product"));
		}

		// ljn add

		if (request.getParameter("comm_fee") != null
				&& !request.getParameter("comm_fee").equals(""))
		{
			this.setComm_fee(Integer.parseInt(request.getParameter("comm_fee")));
		}
		if (request.getParameter("comm_fee_time") != null
				&& !request.getParameter("comm_fee_time").equals(""))
		{
			this.setComm_fee_time(request.getParameter("comm_fee_time"));
		}
		if (request.getParameter("comm_recipet_date") != null
				&& !request.getParameter("comm_recipet_date").equals(""))
		{
			this.setComm_recipet_date(request.getParameter("comm_recipet_date"));
		}
		if (request.getParameter("recipet_date") != null
				&& !request.getParameter("recipet_date").equals(""))
		{
			this.setRecipet_date(request.getParameter("recipet_date"));
		}
		if (request.getParameter("install_end_date") != null
				&& !request.getParameter("install_end_date").equals(""))
		{
			this.setInstall_end_date(request.getParameter("install_end_date"));
		}
		if (request.getParameter("depo_time") != null
				&& !request.getParameter("depo_time").equals(""))
		{
			this.setDepo_time(request.getParameter("depo_time"));
		}

		if (request.getParameter("serv_fee") != null
				&& !request.getParameter("serv_fee").equals(""))
		{
			this.setServ_fee(Integer.parseInt(request.getParameter("serv_fee")));
		}
		if (request.getParameter("serv_fee_time") != null
				&& !request.getParameter("serv_fee_time").equals(""))
		{
			this.setServ_fee_time(request.getParameter("serv_fee_time"));
		}
		if (request.getParameter("serv_recipet_date") != null
				&& !request.getParameter("serv_recipet_date").equals(""))
		{
			this.setServ_recipet_date(request.getParameter("serv_recipet_date"));
		}
		if (request.getParameter("demo") != null
				&& !request.getParameter("demo").equals(""))
		{
			this.setDemo(request.getParameter("demo"));
		}
		if (request.getParameter("s_city") != null
				&& !request.getParameter("s_city").equals(""))
		{
			this.setS_city(request.getParameter("s_city"));
		}
		if (request.getParameter("s_county") != null
				&& !request.getParameter("s_county").equals(""))
		{
			this.setS_county(request.getParameter("s_county"));
		}
		if (request.getParameter("is_success") != null
				&& !request.getParameter("is_success").equals(""))
		{
			this.setIs_success(Integer.parseInt(request
					.getParameter("is_success")));
		}
	}

	public Integer getComm_fee()
	{
		return comm_fee;
	}

	public void setComm_fee(Integer comm_fee)
	{
		this.comm_fee = comm_fee;
	}

	public String getComm_fee_time()
	{
		return comm_fee_time;
	}

	public void setComm_fee_time(String comm_fee_time)
	{
		this.comm_fee_time = comm_fee_time;
	}

	public String getComm_recipet_date()
	{
		return comm_recipet_date;
	}

	public void setComm_recipet_date(String comm_recipet_date)
	{
		this.comm_recipet_date = comm_recipet_date;
	}

	public String getRecipet_date()
	{
		return recipet_date;
	}

	public void setRecipet_date(String recipet_date)
	{
		this.recipet_date = recipet_date;
	}

	public Integer getServ_fee()
	{
		return serv_fee;
	}

	public void setServ_fee(Integer serv_fee)
	{
		this.serv_fee = serv_fee;
	}

	public String getServ_fee_time()
	{
		return serv_fee_time;
	}

	public void setServ_fee_time(String serv_fee_time)
	{
		this.serv_fee_time = serv_fee_time;
	}

	public String getServ_recipet_date()
	{
		return serv_recipet_date;
	}

	public void setServ_recipet_date(String serv_recipet_date)
	{
		this.serv_recipet_date = serv_recipet_date;
	}

	// end
}
