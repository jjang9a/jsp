<%@page import="co.dev.vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/sidebar.jsp" %>
<%@ include file="../includes/top.jsp" %>
	<%
	// 자바 영역
		List<MemberVO> list = (List<MemberVO>) request.getAttribute("members"); //list가 가지고 있는 주소값을 반환해줌
		System.out.print(list);
	 %>
	<table class="table">
		<thead>
			<tr>
				<th>id</th><th>name</th><th>pass</th><th>email</th>
			</tr>
		</thead>
		<tbody>
		<%
			for (MemberVO member : list){
		%>
			<tr>
				<td><a href='http://localhost:8081/HelloWeb/memberSearch.do?job=search&id=<%=member.getId() %>'><%=member.getId() %></a></td>
				<td><%=member.getName() %></td>
				<td><%=member.getPasswd() %></td>
				<td><%=member.getMail() %></td>
			</tr>
		<%
			}	
		%>
		</tbody>
	</table>	
	
	<p>멤버 등록 페이지 이동</p>
	<a href="memberInsertForm.do">회원등록 페이지</a>
	
<%@ include file="../includes/footer.jsp" %>