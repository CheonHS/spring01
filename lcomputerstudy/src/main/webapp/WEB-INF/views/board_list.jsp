<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
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
	.bRow{
		border-top: 1px solid gray;
		border-bottom: 1px solid gray;
	}
	.bRow:hover td:nth-child(2){
		text-decoration: underline;
	}
	#tableDiv{
		border: 1px solid black;
		width: 700px;
		height: 350px;
	}
	#paginationDiv{
		border: 1px solid black;
		width: 700px;
		height: 30px;
	}
</style>
</head>
<body>
	<h1>게시판</h1>
	<hr>
	<div id="tableDiv">
		<table>
			<tr>
				<th colspan="2">제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
			<c:forEach var="list" items="${list }">
		      	<tr class="bRow" onclick="location.href='/board/detail?bId=${list.bId}'">
		      		<td>${list.rownum }</td>
		      		<td>${list.bTitle }</td>
		      		<td>${list.bWriter }</td>
		      		<td>${list.bDateTime }</td>
		      	</tr>
	     	</c:forEach>
     	</table>
    </div>
    <div id="paginationDiv">
     	
    </div>
    <br>
	<a href="/board/write">글 작성</a>
	
    <br>
    <a href="/">돌아기기</a>

</body>
</html>