package com.dodou.table;

import javax.servlet.http.HttpServletRequest;

public class Commercial_LqRule 
{
	private String lqRuleId = null;
	
	private String lqRuleName = null;

	public void requestGetParameter(HttpServletRequest request)throws Exception
	{
		if (request.getParameter("lqRuleId") != null&& !request.getParameter("lqRuleId").equals("")) {
			this.setLqRuleId(request.getParameter("lqRuleId"));
		}
		if (request.getParameter("lqRuleName") != null&& !request.getParameter("lqRuleName").equals("")) {
			this.setLqRuleName(request.getParameter("lqRuleName"));
		}
	}

	public String getLqRuleId() {
		return lqRuleId;
	}

	public void setLqRuleId(String lqRuleId) {
		this.lqRuleId = lqRuleId;
	}

	public String getLqRuleName() {
		return lqRuleName;
	}


	public void setLqRuleName(String lqRuleName) {
		this.lqRuleName = lqRuleName;
	}

}
