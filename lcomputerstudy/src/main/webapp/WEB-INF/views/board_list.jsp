<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시판</title>
<style>
	table{
		border-collapse: collapse;
	}
	th,td{
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
</style>
</head>
<body>
	<h1>게시판</h1>
	<hr>
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
</body>
</html>