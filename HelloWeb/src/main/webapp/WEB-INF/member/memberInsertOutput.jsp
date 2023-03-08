<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/sidebar.jsp" %>
<%@ include file="../includes/top.jsp" %>
	<%
		Object obj = request.getAttribute("message"); // Object타입
		String result = (String) obj;
		String uid = (String) request.getAttribute("id"); // String타입
		
	//변수 있는 값을 쓸때 자바영역에서 바로 =쓰고 변수를 쓰면 자동 프린트해줌
	%>
	<p>처리결과 : <%=result %></p>
	<p><%=uid %>님의 가입을 환영합니다!</p>
	
	<p>회원목록으로 이동</p>
	<a href="memberList.do">회원목록</a>

<%@ include file="../includes/footer.jsp" %>