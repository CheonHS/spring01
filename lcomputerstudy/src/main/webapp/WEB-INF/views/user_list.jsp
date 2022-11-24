<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<style>
	td, th{
		text-align: center;
		border: 1px solid black;
	}
	table{
		border-collapse: collapse;
		font-weight: bold;
	}
	td:nth-child(1) {
		width: 50px;
	}
	td:nth-child(2) {
		width: 100px;
	}
	td:nth-child(3) {
		width: 150px;
	}
	td:nth-child(4) {
		width: 250px;
	}
	#tableDiv{
		width: 600px;
		height: 150px;
	}
	#paginationDiv{
		width: 500px;
		height: 30px;
	}
</style>
</head>
<body>
	<h1>회원 목록</h1>
	<hr>
	<div id="tableDiv" align="center">
		<c:if test="${empty list}">회원이 없습니다.</c:if>
		<c:if test="${!empty list}">
			<table>
				<tr>
					<th>No</th>
					<th>ID</th>
					<th>회원이름</th>
					<th>가입일자</th>
				</tr>
				<c:forEach var="list" items="${list }">
			      	<tr class="uRow" onclick="location.href='/admin/userDetail?username=${list.username}'">
			      		<td>${list.rownum }</td>
			      		<td>${list.username }</td>
			      		<td>${list.uName }</td>
			      		<td>${list.uDateTime }</td>
			      	</tr>
		     	</c:forEach>
	     	</table>
     	</c:if>
    </div>
    <div id="paginationDiv" align="center">
    	<c:choose>
			<c:when test="${ page.prevPage lt 5 }">
				&ensp;
			</c:when>
			<c:when test="${ page.prevPage ge 5}">
				<a href="/admin/userList?page=${page.prevPage}">◀</a>
			</c:when>
		</c:choose>
		 
		<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}" step="1">
			<c:choose>
				<c:when test="${ page.page eq i }">
					${i}
				</c:when>
				<c:when test="${ page.page ne i }">
						<a href="/admin/userList?page=${i}">${i}</a>
				</c:when>
			</c:choose>
		</c:forEach>
		
		<c:choose>
			<c:when test="${ page.nextPage le page.lastPage }">
				<a href="/admin/userList?page=${page.nextPage}">▶</a>
			</c:when>
			<c:when test="${ page.nextPage ge page.lastPage}">
				&ensp;
			</c:when>
		</c:choose> 
    </div>
    <br>
    <a href="/admin">돌아기기</a>
</body>
</html>