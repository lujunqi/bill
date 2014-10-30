package com.dodou.inferface;

import com.dodou.table.Terminal_Info;

/**
 * 终端工作流程接口
 * 
 * @author 陈孟琳
 * 
 */
public interface TerminalWorkFlow
{
	public static final int INPUT_OK = 1;// 录入完成
	public static final int OPERATE_Ok = 2;// 审批完成
	public static final int DEBUG_Ok = 4;// 调试完成
	public static final int ASSIGN_Ok = 5;// 分配完成
	public static final int CANCEL_OK = 6;// 撤销完成
	public static final int WAITING = 7;//
	public static final int FILE_Ok = 13;// 归档完成

	public static final int ZHENG_GAI = 15;// 整改状态

	/**
	 * 审批
	 * 
	 * @param info
	 * @throws Exception
	 */
	public void operate(Terminal_Info info) throws Exception;

	/**
	 * 未调试，将终端状态改为归档状态
	 * 
	 * @param id
	 * @throws Exception
	 */
	public void notDebug(int id, int operator_id) throws Exception;

	/**
	 * 待归档
	 * 
	 * @param id
	 * @throws Exception
	 */
	public void waitingFile(int id) throws Exception;

	/**
	 * 待调试
	 * 
	 * @param id
	 * @throws Exception
	 */
	public void waitingDebug(int id) throws Exception;

	/**
	 * 等待
	 * 
	 * @param terminal
	 * @throws Exception
	 */
	public boolean waitingTerminal(Terminal_Info terminal) throws Exception;

	/**
	 * 撤机
	 * 
	 * @param terminal
	 * @throws Exception
	 */
	public boolean cancelTerminal(Terminal_Info terminal) throws Exception;

	/**
	 * 归档
	 * 
	 * @param terminal
	 * @throws Exception
	 */
	public boolean fileTerminal(Terminal_Info terminal) throws Exception;

	/**
	 * 终端调试完成
	 * 
	 * @param terminal
	 * @throws Exception
	 */
	public boolean debugTerminal(Terminal_Info terminal) throws Exception;

	/**
	 * 终端分配
	 * 
	 * @param terminal
	 * @throws Exception
	 */
	public boolean assign(Terminal_Info terminal) throws Exception;
}
