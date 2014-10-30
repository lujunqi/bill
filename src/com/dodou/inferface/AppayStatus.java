package com.dodou.inferface;

/**
 * 业务状态
 * 
 * @author 陈孟琳
 * 
 */
public interface AppayStatus
{
	int INPUT = 0;
	int NOT_ALLOW = 1;// 入网驳回中
	int ALLOW = 2;// 审批通过
	int NEW_TER = 3;// 新增终端审批中
	int APPAY_UPDATE = 4;// 修改审批中
	int NEW_TER_NOT_ALLOW = 5;// 新增终端修改驳回中
	int APPAY_UPDATE_NOW_ALLOW = 6;// 修改帐号驳回中
}
