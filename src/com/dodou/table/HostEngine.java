package com.dodou.table;

public class HostEngine
{
	private String term_id1;
	private String term_id2;
	private String equi_type;
	private String UNIT_INSTALLED_STREET;
	private String Unit_Installed_Add;
	private String teminal_status;
	private int teminal_info_id;
	private int commercial_id;
	
	

	public int getCommercial_id()
	{
		return commercial_id;
	}

	public void setCommercial_id(int commercial_id)
	{
		this.commercial_id = commercial_id;
	}

	public int getTeminal_info_id()
	{
		return teminal_info_id;
	}

	public void setTeminal_info_id(int teminal_info_id)
	{
		this.teminal_info_id = teminal_info_id;
	}

	public String getTerm_id1()
	{
		return term_id1;
	}

	public void setTerm_id1(String term_id1)
	{
		this.term_id1 = term_id1;
	}

	public String getTerm_id2()
	{
		return term_id2;
	}

	public void setTerm_id2(String term_id2)
	{
		this.term_id2 = term_id2;
	}

	public String getEqui_type()
	{
		return equi_type;
	}

	public void setEqui_type(String equi_type)
	{
		this.equi_type = equi_type;
	}

	public String getUNIT_INSTALLED_STREET()
	{
		return UNIT_INSTALLED_STREET;
	}

	public void setUNIT_INSTALLED_STREET(String uNIT_INSTALLED_STREET)
	{
		UNIT_INSTALLED_STREET = uNIT_INSTALLED_STREET;
	}

	public String getUnit_Installed_Add()
	{
		return Unit_Installed_Add;
	}

	public void setUnit_Installed_Add(String unit_Installed_Add)
	{
		Unit_Installed_Add = unit_Installed_Add;
	}

	public String getTeminal_status() {
		return teminal_status;
	}

	public void setTeminal_status(String teminal_status) {
		this.teminal_status = teminal_status;
	}

}
