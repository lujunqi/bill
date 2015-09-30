<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.dao.PhotoDao"%>
<%@page import="com.szzt.util.PhotoUtils"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@ include file="../../import.jsp"%>
<%
	try
	{
		Permission per = new PositionPermessionImpl();
		if (!per.hasPermission(session, Permission.EXPAND_POSITION))
		{
			response.sendRedirect("../insert/error.jsp");
			return;
		}
		System.out.print("------------------------\n");
		Log.getLogger().info("开始导入文件........");
		PhotoDao dao = new PhotoDao();
		Photo photo = new Photo();
		String FILEPATH = application.getRealPath("/") + "photo";
		PhotoUtils utils = new PhotoUtils();
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
					String value = new String(item.getString()
							.getBytes("iso8859-1"), "utf-8");

					// 如果item是正常的表单域
					if (item.getFieldName().equals("apptype"))
					{
						photo.setAPPPAY_TYPE(Integer.parseInt(value));

					} else if (item.getFieldName().equals("id"))
					{
						photo.setAPPPAY_ID(Integer.parseInt(value));

					} else if (item.getFieldName().equals("fileType"))
					{
						//文件类型
						photo.setTYPE(value);
					}
				} else
				{
					int id = dao.insert(photo);
					String filePath = photo.getURL();
					File parent = new File(FILEPATH, filePath);
					if (!parent.exists())
					{
						parent.mkdirs();
					}
					File photoFile = new File(parent, id + ".jpg");
					System.out.print("文件是否存在？" + photoFile.exists());
					item.write(photoFile);
					response.sendRedirect("../insert/attachPhoto.jsp?type="
							+ photo.getAPPPAY_TYPE()
							+ "&id="
							+ photo.getAPPPAY_ID());
				}
			}
		} catch (Exception e)
		{
			Log.getLogger().error("导入上传文件异常", e);
			e.printStackTrace();
		}
		dao.release();
	} catch (Exception e)
	{
		Log.getLogger().error("导入上传文件异常", e);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>

