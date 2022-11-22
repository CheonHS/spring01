<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 수정</title>
<style>
	table{
		width: 700px;
		border-collapse: collapse;
	}
	td{
		border: 1px solid black; 
	}
	textarea{
		width: 690px;
		height: 190px;
		resize: none;
		background-color: white;
		border: none;
	}
</style>
</head>
<body>
	<h1>게시판 수정</h1>
	<hr>
	<form action="/board/updatePro" method="post">
	<input type="hidden" name="bId" value="${row.bId }">
	<table>
		<tr>
			<td width="500px" align="center">
				<input type="text" name="bTitle" placeholder="제목"
				value="${row.bTitle }"
				style="width:488px; border: none;">
			</td>
			<td width="200px" align="center">
				<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal" var="principal"/>
						작성자 : ${principal.username }
				</sec:authorize>
				<input type="hidden" name="bWriter" value="${principal.username }">
			</td>
		
		</tr>
		<tr>
			<td colspan="2">
				<textarea name="bContent" placeholder="내용">${row.bContent }</textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="submit" value="수정">
				<input type="button" value="뒤로가기"
					onclick="location.href='/board/detail?bId=${row.bId}'">
			</td>
		</tr>
	</table>
	</form>
</body>
</html>