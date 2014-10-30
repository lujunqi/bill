package com.szzt.dao;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dodou.db.DatabaseAccess;
import com.dodou.table.Operman_info;
import com.szzt.util.Md5Util;

public class LoginOut
{
	private DatabaseAccess acc = new DatabaseAccess();

	public void release() throws Exception
	{
		acc.release();
	}

	public boolean login(String username, String password, HttpSession session)
			throws Exception
	{
		if (null == username || null == password)
		{
			return false;
		}
		// password = this.toMD5(password);
		String sql = "select * from OPERMAN_INFO where ACCOUT='" + username
				+ "' and OPER_PASS='" + Md5Util.md5(password)
				+ "' and OPER_STATUS=1";
		System.out.println("登录。。。" + sql);
		ResultSet set = acc.executeQuery(sql);
		if (set.next())
		{
			Operman_info opera = new Operman_info();
			opera.setOperman_id(set.getInt("OPERMAN_ID"));
			opera.setOperman_name(set.getString("OPERMAN_NAME"));
			opera.setOper_address(set.getString("OPER_ADDRESS"));
			opera.setAccout(set.getString("ACCOUT"));
			session.setAttribute("man", opera);
			session.setAttribute("posts", this.loadPosts(opera.getOperman_id()));
			set.close();
			this.release();
			return true;
		} else
		{
			set.close();
			this.release();
		}
		return false;
	}

	private List<Integer> loadPosts(int id) throws Exception
	{
		List<Integer> posts = new ArrayList<Integer>();
		String sql = "select POST_ID from USE_ROLE_INFO where OPERMAN_ID=" + id;
		ResultSet set = acc.executeQuery(sql);
		while (set.next())
		{
			System.out.println("岗位ID:" + set.getInt(1));
			posts.add(set.getInt(1));
		}
		return posts;
	}

	public static void main(String[] args) throws NoSuchAlgorithmException,
			UnsupportedEncodingException
	{
		LoginOut out = new LoginOut();
		System.out.println(out.toMD5("123456"));
		MessageDigest md = MessageDigest.getInstance("MD5");
		md.update("123456".getBytes());
		byte b[] = md.digest();
		int i;
		StringBuffer buf = new StringBuffer("");
		for (int offset = 0; offset < b.length; offset++)
		{
			i = b[offset];
			if (i < 0)
				i += 256;
			if (i < 16)
				buf.append("0");
			buf.append(Integer.toHexString(i));
		}
		System.out.println("result: " + buf.toString());
	}

	private String toMD5(String password) throws NoSuchAlgorithmException,
			UnsupportedEncodingException
	{
		MessageDigest md = MessageDigest.getInstance("MD5");
		byte[] bytes = md.digest(password.getBytes("utf8"));
		StringBuilder ret = new StringBuilder(bytes.length << 1);
		for (int i = 0; i < bytes.length; i++)
		{
			ret.append(Character.forDigit((bytes[i] >> 4) & 0xf, 16));
			ret.append(Character.forDigit(bytes[i] & 0xf, 16));
		}
		return ret.toString();
	}
}
