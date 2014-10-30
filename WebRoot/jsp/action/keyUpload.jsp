<%@page import="org.apache.commons.fileupload.*"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%
	try
	{
		Log.getLogger().info("开始导入文件........");
		//String FILEPATH = "/home/tandan/apache-tomcat-6.0.33/webapps/nws/key";
		String FILEPATH = application.getRealPath("/report");
		try
		{
			DiskFileUpload fu = new DiskFileUpload();
			// 设置最大文件尺寸，这里是4MB    
			fu.setSizeMax(4194304);
			// 设置缓冲区大小，这里是4kb    
			fu.setSizeThreshold(4096);
			// 设置临时目录：    
			fu.setRepositoryPath(FILEPATH + File.separator);
			// 得到所有的文件：    
			List fileItems = fu.parseRequest(request);
			Iterator i = fileItems.iterator();
			String fileName = "";
			// 依次处理每一个文件：    
			while (i.hasNext())
			{
				FileItem item = (FileItem) i.next();
				if (item.isFormField())
				{
					//fileName = item.getName();
					//fileName = fileName.substring(fileName.lastIndexOf("\\") + 1, fileName.length());
				} else
				{
					fileName = item.getName();
					fileName = fileName.substring(
							fileName.lastIndexOf("\\") + 1,
							fileName.length());
					Log.getLogger().info(
							"导入文件地址:" + FILEPATH + File.separator
									+ fileName);
					//item.write(new File(FILEPATH, fileName));
					//Thread.sleep(1000);
					///*****************************************************//
					BufferedReader br = new BufferedReader(
							new InputStreamReader(item.getInputStream()));
					String str = null;
					StringBuffer sb = new StringBuffer();
					while ((str = br.readLine()) != null)
					{
						if (str.equals(""))
							continue;
						String array[] = str.split("	");
						if (array.length == 2)
						{
							Teminal_info_keyDao teminal_info_keyDao = new Teminal_info_keyDao();
							Teminal_info_key teminal_info_key = new Teminal_info_key();
							teminal_info_key.setHost_no(array[0]);
							teminal_info_key.setArea(Integer
									.valueOf(array[1]));
							teminal_info_key.setIn_time(UtilTime
									.getOtherFormat2String(
											"yyyy-MM-dd hh:mm:ss",
											new java.util.Date()));
							teminal_info_key.setStatus(1);
							teminal_info_keyDao
									.insert(teminal_info_key);
						}
					}
					br.close();
				}
			}
		} catch (Exception e)
		{
			Log.getLogger().error("导入上传文件异常", e);
			e.printStackTrace();
		}
	} catch (Exception e)
	{
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>
