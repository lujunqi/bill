package com.szzt.util;

import java.io.File;

import javax.servlet.http.HttpSession;

public class PhotoUtils
{
	/**
	 * 根据终端图片的id删除图片资源
	 * 
	 * @param session
	 * @param id
	 *            图片id
	 * @param terId
	 *            终端id
	 */
	public void delByTphotoId(HttpSession session, String id, String terId)
	{
		String photo = session.getServletContext().getRealPath("/")
				+ "photo/terminal/" + terId + "/" + id + ".jpg";
		File file = new File(photo);
		if (file.exists())
		{
			file.delete();
		}
	}

	/**
	 * 根据终端id删除该终端下的所有图片
	 * 
	 * @param session
	 * @param id
	 */
	public void delTPhotoByTerminalId(HttpSession session, String id)
	{
		String photo = session.getServletContext().getRealPath("/")
				+ "photo/terminal/" + id;
		File file = new File(photo);
		if (file.exists())
		{
			this.del(file);
		}
	}

	/**
	 * 删除业务的图片
	 * 
	 * @param session
	 * @param id
	 *            图片的ID
	 * @param type
	 */
	public void delPhotos(HttpSession session, String id, String type,
			String appId)
	{
		String photo = session.getServletContext().getRealPath("/") + "photo/"
				+ type + "/" + appId + "/" + id + ".jpg";
		File file = new File(photo);
		if (file.exists())
		{
			file.delete();
		}
	}

	public void delPhotoByApp(HttpSession session, String type, String appId)
	{
		String photo = session.getServletContext().getRealPath("/") + "photo/"
				+ type + "/" + appId;
		File file = new File(photo);
		if (file.exists())
		{
			this.del(file);
		}
	}

	private void del(File directory)
	{
		if (directory.exists())
		{
			File[] files = directory.listFiles();
			for (File f : files)
			{
				if (f.isDirectory())
				{
					this.del(f);
				} else
				{
					f.delete();
				}
			}
			// 删除本目录
			directory.delete();
		}
	}

	public String getName(int index)
	{
		switch (index)
		{
		case 0:
			return "yingyezhizhao.jpg";
		case 1:
			return "jigoudaima.jpg";
		case 2:
			return "shuiyudengji.jpg";
		case 3:
			return "farenshenfenzheng.jpg";
		case 4:
			return "zhucejilu.jpg";
		case 5:
			return "zhanghuxinxi.jpg";
		case 6:
			return "weituoshouquan.jpg";
		case 7:
			return "shanghuzhaopian.jpg";
		case 8:
			return "biangengdang.jpg";
		case 9:
			return "qita.jpg";
		}
		return "weizhi.jpg";
	}
}
