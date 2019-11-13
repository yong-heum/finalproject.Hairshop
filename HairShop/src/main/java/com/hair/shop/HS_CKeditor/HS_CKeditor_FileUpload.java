package com.hair.shop.HS_CKeditor;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class HS_CKeditor_FileUpload {

	@RequestMapping(value = "/imgUpload")
	public void imgUpload(HttpServletRequest request, HttpServletResponse response,
			@RequestParam MultipartFile upload) {

		OutputStream out = null;
		PrintWriter printWriter = null;
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		try {

			//파일 저장 해주는애(절대경로)
			String fileName = upload.getOriginalFilename();
			byte[] bytes = upload.getBytes();
			String uploadPath = "C:\\Users\\gg\\Desktop\\용흠\\HairShop\\src\\main\\webapp\\resources\\ckeditor_File\\" + fileName;// 저장경로
//			C:\\Users\\gg\\Desktop\\용흠\\HairShop\\src\\main\\webapp\\resources\\ckeditor_File\\
			
			out = new FileOutputStream(new File(uploadPath));
			out.write(bytes);
			String callback = request.getParameter("CKEditorFuncNum");

			//파일 꺼내오는 애(상대경로)
			printWriter = response.getWriter();
			String fileUrl = "http://localhost:8786/shop/resources/ckeditor_File/" + fileName;// url경로

			printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction(" + callback
					+ ",'" + fileUrl + "','이미지를 업로드 하였습니다.'" + ")</script>");
			printWriter.flush();

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (out != null) {
					out.close();
				}
				if (printWriter != null) {
					printWriter.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return;
	}

}
