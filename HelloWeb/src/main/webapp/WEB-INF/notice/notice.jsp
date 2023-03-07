<%@page import="co.dev.vo.NoticeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/sidebar.jsp" %>
<%@ include file="../includes/top.jsp" %>

<% NoticeVO vo = (NoticeVO) request.getAttribute("notice"); %>


<table class="table">
	<tr>
	<th>글번호</th><td><%=vo.getNoticeId() %></td><th>작성일</th><td><%=vo.getCreateDate() %></td>
	</tr>
	<tr>
	<th>제목</th><td colspan="3"><%=vo.getNoticeTitle() %></td>
	</tr>
	<tr>
	<th>작성자</th><td><%=vo.getNoticeWriter() %></td><th>조회수</th><td><%=vo.getHitCount() %></td>
	</tr>
	<td colspan="4"><%=vo.getNoticeSubject() %></td>
	<tr>
	<th colspan="3">첨부파일</th><td>
<% if(vo.getAttach() != null){ %><%=vo.getAttach() %>
<% }else { %> 첨부파일 없음
<% } %>
	

</table>

<%-- <table class="table">
	
		<tr>
			<td>글번호</td><td><input type="text" name="nid" readonly value="<%=vo.getNoticeId() %>"></td>
		</tr>
		<tr>
			<td>제목</td><td><input type="text" name="title" value="<%=vo.getNoticeTitle() %>"></td>
		</tr>
		<tr>
			<td>작성자</td><td><input type="text" name="writer" value="<%=vo.getNoticeWriter() %>"></td>
		</tr>
		<tr>
			<td>내용</td><td><textarea cols="30" rows="5" name="subject"><%=vo.getNoticeSubject() %></textarea></td>
		</tr>
		<tr>
			<td>파일</td><td>
			<% <if (vo.getAttach() != null){ %>
				<input type="text" name="attach" value="<%=vo.getAttach() %>">
			<% } else{ %>
				<input type="text" name="attach" value="">
			<% } %>
		</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			<input type="submit" value="저장">
			</td>
		</tr>
	</table> --%>



<%@ include file="../includes/footer.jsp" %>