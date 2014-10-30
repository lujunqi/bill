package com.szzt.util;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

/**
 * 商户号信息存储工具类
 * 
 * @author 陈孟琳
 * 
 */
public class CommercialNoUtils
{
	Map<Integer, String> store = new HashMap<Integer, String>();
	private static final String KEY = "commercialNo";

	/**
	 * 存储商户编号
	 * 
	 * @param appid
	 * @param no
	 * @param session
	 */
	public void store(Integer appid, String no, HttpSession session)
	{
		System.out.println("store:" + appid + ":no" + no);
		checkExist(session);
		// 将商户编号存入缓存
		if (null != no)
		{
			store.put(appid, no);
		}
	}

	private void checkExist(HttpSession session)
	{
		if (null == session.getAttribute(KEY))
		{
			store = new HashMap<Integer, String>();
			session.setAttribute(KEY, store);
		} else
		{
			store = (Map<Integer, String>) session.getAttribute(KEY);
		}
		System.out.println(store.toString());
	}

	/**
	 * 获取session中的商户编号
	 * 
	 * @param id
	 * @param session
	 * @return
	 */
	public String load(Integer id, HttpSession session)
	{
		checkExist(session);
		String no = store.get(id);
		return null == no ? "" : no;
	}
}
