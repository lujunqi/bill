<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.dao.TPhotoDao"%>
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
		TPhotoDao dao = new TPhotoDao();
		TPhoto photo = new TPhoto();
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
					if (item.getFieldName().equals("id"))
					{
						photo.setTERMINAL_INFO_ID(Integer
								.parseInt(value));
					} else if (item.getFieldName().equals("fileType"))
					{
						//文件类型
						photo.setTYPE(value);
					}
				} else
				{
					int id = dao.insert(photo);
					File parent = new File(FILEPATH, "terminal/"
							+ photo.getTERMINAL_INFO_ID());
					if (!parent.exists())
					{
						parent.mkdirs();
					}
					File photoFile = new File(parent, id + ".jpg");
					item.write(photoFile);
					response.sendRedirect("../insert/attachTPhoto.jsp?id="
							+ photo.getTERMINAL_INFO_ID());
				}
			}
		} catch (Exception e)
		{
			Log.getLogger().error("导入上传文件异常", e);
			e.printStackTrace();
		}
	} catch (Exception e)
	{
		Log.getLogger().error("导入上传文件异常", e);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>

