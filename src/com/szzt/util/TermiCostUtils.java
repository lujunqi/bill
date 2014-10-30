package com.szzt.util;

import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;

import com.dodou.table.TemiCost;

/**
 * 机具费用表参数设置
 * 
 * @author 陈孟琳
 * 
 */
public class TermiCostUtils
{
	public TemiCost[] getTermiCosts(HttpServletRequest request, int terminalId)
			throws Exception
	{
		TemiCost[] costs = new TemiCost[3];
		for (int i = 0; i < 3; i++)
		{
			costs[i] = this.toCost(String.valueOf(i), request);
			costs[i].setTEMINAL_INFO_ID(terminalId);
		}
		return costs;
	}

	private TemiCost toCost(String index, HttpServletRequest request)
			throws Exception
	{
		TemiCost t = new TemiCost();
		if (null != request.getParameter("COSTTYPEID" + index)
				&& request.getParameter("COSTTYPEID" + index).trim().length() > 0)
		{
			t.setCOSTTYPEID(Integer.parseInt(request.getParameter("COSTTYPEID"
					+ index)));
		}
		if (null != request.getParameter("COST_NAME" + index)
				&& request.getParameter("COST_NAME" + index).trim().length() > 0)
		{
			t.setCOST_NAME(request.getParameter("COST_NAME" + index));
		}
		if (null != request.getParameter("COST_TYPE" + index)
				&& request.getParameter("COST_TYPE" + index).trim().length() > 0)
		{
			t.setCOST_TYPE(Integer.parseInt(request.getParameter("COST_TYPE"
					+ index)));
		}
		if (null != request.getParameter("STATUS" + index)
				&& request.getParameter("STATUS" + index).trim().length() > 0)
		{
			t.setSTATUS(Integer.parseInt(request.getParameter("STATUS" + index)));
		}
		if (null != request.getParameter("CYCLE" + index)
				&& request.getParameter("CYCLE" + index).trim().length() > 0)
		{
			t.setCYCLE(Integer.parseInt(request.getParameter("CYCLE" + index)));
		}
		if (null != request.getParameter("COSTNUMBER" + index)
				&& request.getParameter("COSTNUMBER" + index).trim().length() > 0)
		{
			t.setCOSTNUMBER(request.getParameter("COSTNUMBER" + index));
		}
		if (null != request.getParameter("MONEY" + index)
				&& request.getParameter("MONEY" + index).trim().length() > 0)
		{
			t.setMONEY(request.getParameter("MONEY" + index));
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

		if (null != request.getParameter("STARTDATE" + index)
				&& request.getParameter("STARTDATE" + index).trim().length() > 0)
		{
			t.setSTARTDATE(format.parse(request.getParameter("STARTDATE"
					+ index)));
		}
		if (null != request.getParameter("FINALDATE" + index)
				&& request.getParameter("FINALDATE" + index).trim().length() > 0)
		{
			t.setFINALDATE(format.parse(request.getParameter("FINALDATE"
					+ index)));
		}
		if (null != request.getParameter("REFUNDDATE" + index)
				&& request.getParameter("REFUNDDATE" + index).trim().length() > 0)
		{
			t.setREFUNDDATE(format.parse(request.getParameter("REFUNDDATE"
					+ index)));
		}

		return t;

	}
}
