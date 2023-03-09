<%@page import="org.apache.coyote.RequestGroupInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jstl.jsp</title>
</head>
<body>
	<h3>jstl.jsp page</h3>
	<%
		String name = (String) application.getAttribute("name");
		String n = "Hong";
		
		if(n != null){
			System.out.println("name : "+ n);
		}else{
			System.out.println("m은 null입니다");
		}
	
	%>
	<p>name : <%=name %></p>
	<p>name : ${name }</p> <!-- request에서 먼저 찾아본 후 없으면 session에서 찾음. 그래도 없으면 application으로 -->
	
	<p>Members : ${list }</p>
	
	<c:set value="Hong" var="m"></c:set>
	<c:out value="${m }"></c:out>
	
	<c:if test="${m != null }">
		<p>m의 값은 null이 아닙니다. <c:out value="${m }"></c:out></p>
	</c:if>	
	
	<c:choose>
		<c:when test="${m != null }">
			<p>m은 null이 아닙니다</p>
		</c:when>
		<c:otherwise>
			<p>m은 null입니다</p>
		</c:otherwise>
	</c:choose>
	
	<c:set var="score" value="85"></c:set>
	
	<c:choose>
		<c:when test="${score >= 90 }">
			<p>A학점입니다</p>
		</c:when>
		<c:when test="${score >= 80 }">
			<p>B학점입니다</p>
		</c:when>
		<c:when test="${score >= 70 }">
			<p>C학점입니다</p>
		</c:when>
		<c:otherwise>
			<p>D학점입니다</p>
		</c:otherwise>
	</c:choose>
</body>
</html>