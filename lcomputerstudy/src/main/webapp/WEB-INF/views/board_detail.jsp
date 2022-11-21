<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
	table{
		width: 700px;
		border-collapse: collapse;
	}
	th, td{
		border: 1px solid black; 
	}
	th:nth-child(1) {
		width: 50px;
	}
	th:nth-child(2) {
		width: 200px;
	}
	th:nth-child(3) {
		width: 100px;
	}
	textarea {
		width: 690px;
		height: 190px;
		resize: none;
		background-color: white;
		border: none;
	}
	#contentTd{
		height: 200px;
	}
</style>
</head>
<body>
	<h1>게시판 상세</h1>
	<hr>
	<table>
		<tr>
			<th></th>
			<th>${row.bTitle }</th>
			<th>${row.bWriter}</th>
		</tr>
		<tr>
			<td colspan="3" id="contentTd">
				<textarea readonly disabled>${row.bContent }</textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<a href="/board/reply?bId=${row.bId }">답글</a>
				<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal" var="principal"/>
					<c:if test="${row.bWriter == principal.username}">
						<a href="/board/update?bId=${row.bId }">수정</a>
						<a href="/board/delete?bId=${row.bId }">삭제</a>
					</c:if>
				</sec:authorize>
				
			</td>
			<td align="center"><b>${row.bDateTime }</b></td>
		</tr>
	</table>
	<a href="/board">목록</a>
</body>
</html>