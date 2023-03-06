<%@page import="co.dev.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/sidebar.jsp" %>
<%@ include file="../includes/top.jsp" %>
	<h3>회원 삭제 조회(memberDelete.jsp)</h3>
	<%
		MemberVO member = (MemberVO) request.getAttribute("vo");
		String message = (String) request.getAttribute("message");
		if(message != null){
	%>
		<p><%=message %></p>
	<%
		}
	%>
	<form action="memberSearch.do">
		<input type="hidden" name="job" value="delete">
		찾을ID : <input type="text" name="id">
		<input type="submit" value="찾기">
	</form>
	
	<p></p>
	<h3>회원 삭제 정보</h3>
	<%
		if(member != null){
	%>
	<form action="memberDelete.do">
		ID : <input type="text" name="id" value="<%=member.getId() %>" readonly><br>
		<input type="submit" value="삭제">
	</form>
	<%
		}
	%>
<%@ include file="../includes/footer.jsp" %>