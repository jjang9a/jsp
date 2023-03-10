<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Members</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body>
    

    
        <div class="d-flex" id="wrapper">
            <!-- Sidebar-->
            <div class="border-end bg-white" id="sidebar-wrapper">
                <div class="sidebar-heading border-bottom bg-light">Start Bootstrap</div>
                <div class="list-group list-group-flush">
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="memberList.do">회원목록보기</a>
                    <% String auth = (String) session.getAttribute("auth"); %>
                    <% if(auth != null && auth.equals("Admin")){ %>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="memberInsertForm.do">회원등록 페이지</a>
                    <% } %>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="memberSearchForm.do">회원 조회</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="memberUpdateForm.do">회원정보 수정</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="memberDeleteForm.do">회원 삭제</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="noticeList.do">공지사항목록</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="noticeWriteForm.do">공지사항등록</a>
                </div>
            </div>