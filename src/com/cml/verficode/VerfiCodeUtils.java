package com.cml.verficode;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

//验证码生成器
public class VerfiCodeUtils
{
	private static List<String> codes = Arrays.asList(Constants.verficode);

	// 获取随机验证码
	public static String getCode(int start)
	{
		Collections.shuffle(codes);
		StringBuffer str = new StringBuffer();
		for (int i = 0; i < 4; i++)
		{
			str.append(codes.get(start++));
		}
		return str.toString();
	}
}
