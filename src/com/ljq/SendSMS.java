package com.ljq;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

public class SendSMS {
	public static void main(String[] args) {
		SendSMS.sendSMS("13974909197", "11【通联支付】");
		
	}

	public static boolean sendSMS(String mobile, String content) {
		boolean result = false;
		try {
			String info = "http://pi.noc.cn/SendSMS.aspx?Msisdn=" + mobile
					+ "&SMSContent=短信验证码" + content
					+ "【通联支付】&MSGType=5&ECECCID=301011055&Password=hntonglian";
			// String spec =
			// "http://localhost:8080/testRRC/solrIndex/testAction!test";
			URL url = new URL(info);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setDoInput(true);
			conn.setDoOutput(true);
			conn.setInstanceFollowRedirects(true);
			conn.setRequestProperty("content-type", "text/html");

			conn.connect();// 握手
			OutputStream os = conn.getOutputStream();// 拿到输出流
			// os.write("?path=c:/test.xml&test=2012".getBytes("utf-8"));
			PrintWriter out = new PrintWriter(os);
			out.print("?path=c:/test.xml&test=2012");

			out.flush();
			os.flush();
			out.close();
			os.close();

			InputStream is = conn.getInputStream();// 拿到输入流
			InputStreamReader isr = new InputStreamReader(is);
			BufferedReader br = new BufferedReader(isr);
			String s = br.readLine();
			if (s.startsWith("1|")) {
				result = true;
			}
			 System.out.println(s);

			br.close();
			isr.close();
			is.close();
		} catch (Exception e) {

		}
		return result;
	}
}
