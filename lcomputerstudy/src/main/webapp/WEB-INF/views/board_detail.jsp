<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시판 상세</title>
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
	#commentWriteDiv{
		
		margin-top: 5px;
		width: 700px;
		height: 60px;
	}
	#commentListDiv{
		border: 1px solid black;
		width: 800px;
	}
	#cContent{
		width: 630px;
		height: 40px;
		border: 1px solid black;
		vertical-align: middle;
	}
	#cContent:focus {
		outline: none;
	}
	.cContentList{
		width: 630px;
		height: 40px;
		border: 1px solid black;
		vertical-align: middle;
	}
	.cContentList:focus{
		outline: none;
	}
</style>
<script src="//code.jquery.com/jquery-3.6.1.min.js"></script>
</head>
<body>
	<h1>게시판 상세</h1>
	<hr>
	<table>
		<tr>
			<th>${row.rownum }</th>
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
	<div id="commentWriteDiv" align="left">
		<form action="/comment/write" method="post">
			<input type="hidden" name="bId" id="bId" value="${row.bId }">
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal" var="principal"/>
				<input type="hidden" name="cWriter" id="cWriter" value="${principal.username }">
			</sec:authorize>
			<textarea name="cContent" id="cContent" rows="2"></textarea>
			<input type="button" value="등록" id="btnCommentWrite" style="height: 40px;">
		</form>
	</div>
	<div id="commentListDiv" align="left">
		<c:if test="${empty list}">댓글이 없습니다.</c:if>
		<c:if test="${!empty list}">
	    	<c:forEach var="list" items="${list }">
		    	<div>
		    		<div style="font-size: 0.8em; margin-left:10px; margin-right: 10px; margin-top: 10px;">
						${list.cWriter } / ${list.cDateTime }
					</div>
					<textarea name="cContent" class="cContentList" rows="2" readonly>${list.cContent }</textarea>
					<input type="button" value="답글" id="btnCommentReply" style="height: 40px;">
					<input type="button" value="수정" id="btnCommentEdit" style="height: 40px;">
					<input type="button" value="삭제" id="btnCommentDelete" style="height: 40px;">
					
		    	</div>
	    	</c:forEach>
	    </c:if>
    </div>
	<a href="/board">목록</a>
</body>
<script>
	$(document).on('click', '#btnCommentWrite', function () {
		let content = $('#cContent').val();
		let bId = $('#bId').val();
		let username = $('#cWriter').val();
		console.log(content);
		console.log(bId);
		console.log(username);
	
		$.ajax({
			  method: "POST",
			  url: "/comment/write",
			  data: { bId: bId, cWriter: username, cContent: content }
		})
		.done(function( msg ) {
		    $('#commentListDiv').html(msg);
		});
	});
</script>
</html>