<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/sidebar.jsp" %>
<%@ include file="../includes/top.jsp" %>
	<% String msg = (String) request.getAttribute("message"); %>
	<%
		if(msg != null){
	%>
		<p><%=msg %></p>
	<%
		}
	%>
	<a href="memberList.do">목록 이동</a>
<%@ include file="../includes/footer.jsp" %>