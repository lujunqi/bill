package com.dodou.table;

import javax.servlet.http.HttpServletRequest;

public class Commercial_FeeRule 
{
	private String feeRuleId = null;
	
	private String feeRuleName = null;

	public String getFeeRuleId() {
		return feeRuleId;
	}
	
	public void requestGetParameter(HttpServletRequest request)throws Exception
	{
		if (request.getParameter("feeRuleId") != null&& !request.getParameter("feeRuleId").equals("")) {
			this.setFeeRuleId(request.getParameter("feeRuleId"));
		}
		if (request.getParameter("feeRuleName") != null&& !request.getParameter("feeRuleName").equals("")) {
			this.setFeeRuleName(request.getParameter("feeRuleName"));
		}
	}

	public void setFeeRuleId(String feeRuleId) {
		this.feeRuleId = feeRuleId;
	}

	public String getFeeRuleName() {
		return feeRuleName;
	}

	public void setFeeRuleName(String feeRuleName) {
		this.feeRuleName = feeRuleName;
	}
	
}
