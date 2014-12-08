package com.ljq;

import java.util.ArrayList;
import java.util.List;

public class MyEnum {
	public static List<String[]> commercialTitle = new ArrayList<String[]>();
	public static List<String[]> terminalTitle = new ArrayList<String[]>();

	static {
		terminalTitle.add(new String[] { "MCC", "MMC" });
		terminalTitle.add(new String[] { "标准扣率", "BZKL" });
		terminalTitle.add(new String[] { "地区代码", "DQDM" });
		terminalTitle.add(new String[] { "法人代表", "FRDB" });
		terminalTitle.add(new String[] { "法人身份证", "FRSFZ" });
		terminalTitle.add(new String[] { "开户行", "KHH" });
		terminalTitle.add(new String[] { "客户单位名称", "KHDWMC" });
		terminalTitle.add(new String[] { "签约扣率", "QYKL" });
		terminalTitle.add(new String[] { "商户代码", "SHDM" });
		terminalTitle.add(new String[] { "商户联系人", "SHLXR" });
		terminalTitle.add(new String[] { "商户联系人电话", "SHLXRDH" });
		terminalTitle.add(new String[] { "商户联系人手机", "SHLXRSJ" });
		terminalTitle.add(new String[] { "商户性质", "SHXZ" });
		terminalTitle.add(new String[] { "商户注册地址", "SHZCDZ" });
		terminalTitle.add(new String[] { "是否为法人账户", "SFWFRZH" });
		terminalTitle.add(new String[] { "收单机构代码", "SDJGDM" });
		terminalTitle.add(new String[] { "收单机构类别代码", "SDJGLBDM" });
		terminalTitle.add(new String[] { "收单机构名称", "SDJGMC" });
		terminalTitle.add(new String[] { "推荐人员", "TJRY" });
		terminalTitle.add(new String[] { "推荐支行", "TJZH" });
		terminalTitle.add(new String[] { "终端状态", "ZDZT" });
		terminalTitle.add(new String[] { "终端编号", "ZDBM" });
		terminalTitle.add(new String[] { "押金", "YJ" });
		terminalTitle.add(new String[] { "装机日期", "ZJRQ" });

		/**********************************************/
		commercialTitle.add(new String[] { "MCC", "MCC" });
		commercialTitle.add(new String[] { "商户名称", "SHMC" });
		commercialTitle.add(new String[] { "对外营业名称", "TRADE_NAME" });
		
		commercialTitle.add(new String[] { "标准扣率", "BZKL" });
		commercialTitle.add(new String[] { "地区代码", "DQDM" });
		commercialTitle.add(new String[] { "法人代表", "FRDB" });
		commercialTitle.add(new String[] { "法人身份证", "FRSFZ" });
		commercialTitle.add(new String[] { "开户行", "KHH" });
		commercialTitle.add(new String[] { "客户单位名称", "KHDWMC" });
		commercialTitle.add(new String[] { "签约扣率", "QYKL" });
		commercialTitle.add(new String[] { "商户代码", "SHDM" });
		commercialTitle.add(new String[] { "商户联系人", "SHLXR" });
		commercialTitle.add(new String[] { "商户联系人电话", "SHLXRDH" });
		commercialTitle.add(new String[] { "商户联系人手机", "SHLXRSJ" });
		commercialTitle.add(new String[] { "商户性质", "SHXZ" });
		commercialTitle.add(new String[] { "商户注册地址", "SHZCDZ" });
		commercialTitle.add(new String[] { "是否为法人账户", "SFWFRZH" });
		commercialTitle.add(new String[] { "收单机构代码", "SDJGDM" });
		commercialTitle.add(new String[] { "收单机构类别代码", "SDJGLBDM" });
		commercialTitle.add(new String[] { "收单机构名称", "SDJGMC" });
		commercialTitle.add(new String[] { "推荐人员", "TJRY" });
		commercialTitle.add(new String[] { "推荐支行", "TJZH" });
		commercialTitle.add(new String[] { "终端台数", "ZDTS" });
		commercialTitle.add(new String[] { "装机日期(审批时间)", "SPSJ" });

	}

	
	private List<String[]> list = new ArrayList<String[]>();
	
	
	public void add(String p1,String p2){
		list.add(new String[]{p1,p2});
	}
	public List<String[]> getList(){
		return list;
	}
}
