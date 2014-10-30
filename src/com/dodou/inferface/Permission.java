package com.dodou.inferface;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.dodou.table.Operman_info;

/**
 * 权限
 * 
 * @author 陈孟琳
 * 
 */
public interface Permission
{
	public static final String SUPER_AMDIN = "0000";// 超级管理员权限，可以查询所有信息

	public static final String POSTS = "posts";// 岗位
	public static final int EXPAND_POSITION = 1;// 拓展岗
	public static final int OPERAT_POSITION = 2;// 审批岗
	public static final int ASSIGN_POSITION = 3;// 分配岗
	public static final int DEBUG_POSITION = 4;// 调试岗
	public static final int FILE_POSITION = 5;// 归档岗
	public static final int INSTALL_POSITION = 6;// 装机岗
	public static final int CUS_SERVICE_POSITION = 7;// 客服岗
	public static final int SAFE_POSITION = 8;// 维护岗
	public static final int ADMIN_POSITION = 9;// 超级管理员岗
	public static final int LEADER_POSITION = 10;// 领导岗
	public static final int SERIAL_BACK = 11;// 机具回收岗
	public static final int REPORT_EXPORT = 14;// 报表导出岗位

	/**
	 * 给业务信息查询添加权限设置
	 * 
	 * @param posts
	 * @return
	 */
	public String initAppayWhere(List<Integer> posts, Operman_info info);

	/**
	 * session中的用户只有一个指定的权限
	 * 
	 * @param session
	 * @param position
	 * @return true 只有一个指定的权限，false 权限不止一个或没有指定的权限
	 */
	public boolean onlyPosition(HttpSession session, int position);

	/**
	 * 获取当前用户的所有职位
	 * 
	 * @param session
	 * @return
	 */
	public List<Integer> loadPosts(HttpSession session);

	/**
	 * 判断修改业务的权限
	 * 
	 * @param session
	 * @param table
	 * @param id
	 * @return
	 */
	public boolean hasPermission(HttpSession session, String table, int id)
			throws Exception;

	/**
	 * 获取当前在线用户的ID
	 * 
	 * @param session
	 * @return
	 */
	public Operman_info loadCurrentId(HttpSession session);

	/**
	 * 初始化条件查询
	 * 
	 * @param posts
	 * @param commerId
	 *            当前在线用户ID
	 * @return null查询所有信息，否则返回查询限制条件
	 */
	public String initCommercialWhere(List<Integer> posts, Operman_info info);

	/**
	 * 初始化终端权限sql语句
	 * 
	 * @param posts
	 * @param info
	 * @return
	 */
	public String initTerminalWhere(List<Integer> posts, Operman_info info);

	// public String
	/**
	 * 判断是否有操作指定功能的权限
	 * 
	 * @param session
	 * @param permit
	 * @return
	 */
	public boolean hasPermission(HttpSession session, int permit);

}
