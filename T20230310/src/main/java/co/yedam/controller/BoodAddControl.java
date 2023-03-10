package co.yedam.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.yedam.common.Command;
import co.yedam.service.BookService;
import co.yedam.service.BookServiceMybatis;
import co.yedam.vo.BookVO;

public class BoodAddControl implements Command {

	@Override
	public void exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BookVO vo = new BookVO();
		vo.setBookCode(request.getParameter("book_code"));
		vo.setBookTitle(request.getParameter("book_title"));
		vo.setBookAuthor(request.getParameter("book_author"));
		vo.setBookPress(request.getParameter("book_press"));
		vo.setBookDesc(request.getParameter("book_desc"));
		int price = Integer.parseInt(request.getParameter("book_price"));
		System.out.println(price);
		vo.setBookPrice(price);
		
		BookService service = new BookServiceMybatis();
		
		if(service.addBook(vo)) {
			response.sendRedirect("bookList.do");
		}else {
			request.getRequestDispatcher("WEB-INF/book/bookAddForm.jsp").forward(request, response);
		}
	}

}
