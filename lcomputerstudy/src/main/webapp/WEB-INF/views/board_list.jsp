<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<style>
	table{
		border-collapse: collapse;
		font-size: 0.8em;
		font-weight: bold;
	}
	th, td{
		height: 30px;
	}
	td:nth-child(1) {
		text-align: center;
		width: 50px;
	}
	td:nth-child(2) {
		width: 300px;
	}
	td:nth-child(3) {
		text-align: center;
		width: 100px;
	}
	td:nth-child(4) {
		text-align: center;
		width: 200px;
	}
	select{
		width: 100px;
		text-align: center;
	}
	.bRow{
		border-top: 1px solid gray;
		border-bottom: 1px solid gray;
	}
	.bRow:hover td:nth-child(2){
		text-decoration: underline;
	}
	#tableDiv{
		width: 700px;
		height: 220px;
	}
	#paginationDiv, #searchDiv{
		width: 700px;
		height: 30px;
	}
</style>
<script src="//code.jquery.com/jquery-3.6.1.min.js"></script>
</head>
<body>
	<h1>게시판</h1>
	<hr>
	<div id="tableDiv" align="center">
		<c:if test="${empty list}">게시글이 없습니다.</c:if>
		<c:if test="${!empty list}">
			<table>
				<tr>
					<th colspan="2">제목</th>
					<th>작성자</th>
					<th>작성일</th>
				</tr>
				<c:forEach var="list" items="${list }">
			      	<tr class="bRow"
			      		onclick="location.href='/board/detail?bId=${list.bId}&rownum=${list.rownum}'">
			      		<td>${list.rownum }</td>
			      		<td>
			      			<c:forEach begin="1" end="${list.bDepth }" step="1">&ensp;</c:forEach>
			      			<c:if test="${list.bDepth ne 0 }">└</c:if>
			      			${list.bTitle }
			      		</td>
			      		<td>${list.bWriter }</td>
			      		<td>${list.bDateTime }</td>
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
				<a href="/board?page=${page.prevPage}">◀</a>
			</c:when>
		</c:choose>
		 
		<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}" step="1">
			<c:choose>
				<c:when test="${ page.page eq i }">
					${i}
				</c:when>
				<c:when test="${ page.page ne i }">
						<a href="/board?page=${i}">${i}</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:choose>
			<c:when test="${ page.nextPage le page.lastPage }">
				<a href="/board?page=${page.nextPage}">▶</a>
			</c:when>
			<c:when test="${ page.nextPage ge page.lastPage}">
				&ensp;
			</c:when>
		</c:choose> 
    </div>
    <div align="center" id="searchDiv">
    	<form action="/board">
    		<input type="hidden" name="page" value="${page.page }">
	    	<select name="searchType" id="searchType">
	    		<option value="all">전체</option>
	    		<option value="title">제목</option>
	    		<option value="content">내용</option>
	    		<option value="title+content">제목+내용</option>
	    		<option value="writer">작성자</option>
	    	</select>
	    	<input type="search" name="keyword">
	    	<input type="submit" value="검색">
    	</form>
    </div>
    <br>
	<a href="/board/write">글 작성</a>
	
    <br>
    <a href="/">돌아기기</a>
</body>
</html>