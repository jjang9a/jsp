<%@page import="co.dev.vo.EmpVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employees</title>
</head>
<body>
	<%
	List<EmpVO> list = (List<EmpVO>) request.getAttribute("emp");
	System.out.print(list);
	%>
	<ul>
	<%
		for (EmpVO emp : list){
	%>
		<li>employee id : <%=emp.getId() %>, name : <%=emp.getFirst() + " " + emp.getLast() %>,
		 job : <%=emp.getJob() %>, email : <%=emp.getMail() %></li>
	<%
		}
	%>
	</ul>
</body>
</html>