<%@page import="co.dev.vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EL 연습</title>
</head>
<body>희망로2길 대구광역시 남구
	<%
		request.getAttribute(""); // request : jsp페이지가 서블릿으로 변환되면서 톰캣이 내부적으로 선언하는 변수 = 내장객체
		//request.setAttribute("name", "Hong");
		//response.sendRedirect("jstl.jsp"); // 내장객체. 페이지 재 지정
		session.setAttribute("name", "Hong");
		List<MemberVO> members = new ArrayList<>();
		MemberVO m1 = new MemberVO();
		m1.setId("user1"); m1.setName("사용자1");
		MemberVO m2 = new MemberVO();
		m2.setId("user2"); m2.setName("사용자2");
		members.add(m1);
		members.add(m2);
		
		request.setAttribute("list", members);
		request.getRequestDispatcher("jstl2.jsp").forward(request, response);
	%>
	Literal : ${"string" }<br>
	연산자 : ${3>5 }<br>
			<p>${10-4 }</p>
	파라미터 : <p>${param.p }</p>
</body>
</html>