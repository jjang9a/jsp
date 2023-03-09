<%@page import="co.dev.vo.NoticeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../includes/sidebar.jsp" %>
<%@ include file="../includes/top.jsp" %>

${notice }
<% String uid = (String) session.getAttribute("id"); %>

<table class="table">
	
		<tr>
			<td>글번호</td><td><input type="text" name="nid" readonly value="${notice.noticeId }"></td>
			<td>조회수 [<b>${notice.hitCount }</b>] </td>
		</tr>
		<tr>
			<td>제목</td><td colspan=2><input type="text" name="title" value="${notice.noticeTitle }"></td>
		</tr>
		<tr>
			<td>작성자</td><td colspan=2><input type="text" name="writer" value="${notice.noticeWriter }"></td>
		</tr>
		<tr>
			<td>내용</td><td colspan=2><textarea cols="30" rows="5" name="subject">${notice.noticeSubject }</textarea></td>
		</tr>
		<tr>
			<td>파일</td><td>
			<c:choose>
				<c:when test="${notice.attach != null }">
					<input type="text" name="attach" value="${notice.attach }">
				</c:when>
				<c:otherwise>
					<input type="text" name="attach">
				</c:otherwise>
			</c:choose>
		</td></tr>
		<c:if test="uid.equals(${nocite.noticeWriter })">
			<tr>
			<td colspan="4" align="center">
			<button id="modBtn">수정</button>
			<button id="delBtn">삭제</button>
			</td></tr>
		</c:if>

	</table>
	
	<form id="myFrm" action="noticeModify.do">

	</form>
	<script>
		// 수정
		document.querySelector('#modBtn').addEventListener('click', function() {
			let myFrm = document.querySelector('#myFrm');
			let nid = document.querySelector('input[name="nid"]').value;
			let title = document.querySelector('input[name="title"]').value;
			let subject = document.querySelector('textarea[name="subject"]').textContent;

			myFrm.append(document.querySelector('input[name="nid"]'));
			myFrm.append(document.querySelector('input[name="title"]'));
			myFrm.append(document.querySelector('textarea[name="subject"]'));
			console.log(myFrm);

			myFrm.submit();
		});

		// 삭제
		document.querySelector('#delBtn').addEventListener('click', function(){
			let myFrm = document.querySelector('#myFrm');
			//위에 있는 폼의 속성(어트리뷰트)를 변경
			myFrm.action = 'noticeRemove.do'; //myFrm.setAttribute('action', 'noticeRemove.do')
			myFrm.append(document.querySelector('input[name="nid"]'));

			myFrm.submit();
		})
	</script>

<%@ include file="../includes/footer.jsp" %>