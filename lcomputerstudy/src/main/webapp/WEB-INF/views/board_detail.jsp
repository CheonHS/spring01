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
	}
	#cContent, .commentReplycContent{
		width: 630px;
		height: 40px;
		border: 1px solid black;
		vertical-align: middle;
	}
	#cContent:focus, .commentReplycContent:focus {
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
		<input type="hidden" name="bId" id="bId" value="${row.bId }">
		<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal" var="principal"/>
			<input type="hidden" name="cWriter" id="cWriter" value="${principal.username }">
		</sec:authorize>
		<textarea name="cContent" id="cContent" rows="2"></textarea>
		<input type="button" value="등록" id="btnCommentWrite" style="height: 40px;">
	</div>
	<div id="commentListDiv" align="left">
		<c:if test="${empty list}">댓글이 없습니다.</c:if>
		<c:if test="${!empty list}">
	    	<c:forEach var="list" items="${list }">
		    	<div>
		    		<div style="font-size: 0.8em; margin-left:10px; margin-right: 10px; margin-top: 10px;">
						${list.cWriter } / ${list.cDateTime }
					</div>
					<c:if test="${list.cDepth ne 0 }">└</c:if>
					<c:forEach begin="1" end="${list.cDepth }" step="1">─</c:forEach>
					<textarea name="cContent" class="cContentList" rows="2" readonly>${list.cContent }</textarea>
					<input type="button" value="답글" class="btnCommentReplyOpen" style="height: 40px;">
					<input type="button" value="취소" class="btnCommentReplyCancel" style="height: 40px; display: none;">
					<sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal" var="principal"/>
							<c:if test="${list.cWriter == principal.username}">
								<input type="button" value="수정" class="btnCommentEdit" style="height: 40px;">
								<input type="button" value="수정완료" class="btnCommentEditPro" style="height: 40px; display: none;" cId="${list.cId }">
								<input type="button" value="수정취소" class="btnCommentEditCancel" style="height: 40px; display: none;">
								
								<input type="button" value="삭제" class="btnCommentDelete" style="height: 40px;" cId="${list.cId }">
							</c:if>
					</sec:authorize>		
		    	</div>
		    	<div class="commentReplyDiv" align="left" style="margin-left: 50px; margin-top: 10px; display: none;">
		    		<input type="hidden" name="bId" class="commentReplybId" value="${list.bId }">
					<sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal" var="principal"/>
						<input type="hidden" name="cWriter" class="commentReplycWriter" value="${principal.username }">
					</sec:authorize>
					<textarea name="cContent" class="commentReplycContent" rows="2"></textarea>
					<input type="button" value="등록" class="btnCommentReply" style="height: 40px;">
					<input type="hidden" name="cGroup" class="cGroup" value="${list.cGroup }">
					<input type="hidden" name="cOrder" class="cGroup" value="${list.cOrder }">
					<input type="hidden" name="cDepth" class="cGroup" value="${list.cDepth }">
		    	</div>
	    	</c:forEach>
	    </c:if>
    </div>
	<a href="/board">목록</a>
</body>
<script>
	//	로그인 확인
	function loginChk(){
		let login = $('#cWriter').val();
		if(login==null){
			location.href='/login';
		}
	};
	
	//	댓글 등록
	$(document).on('click', '#btnCommentWrite', function () {
		loginChk();
		
		let content = $('#cContent').val();
		let bId = $('#bId').val();
		let username = $('#cWriter').val();
	
		$.ajax({
			  method: "POST",
			  url: "/comment/write",
			  data: { bId: bId, cWriter: username, cContent: content }
		})
		.done(function( msg ) {
		    $('#commentListDiv').html(msg);
		});
	});

	// 댓글 답글 창 열기
	$(document).on('click', '.btnCommentReplyOpen', function () {
		loginChk();
		
		$(this).hide();
		$(this).next().next().hide();
		$(this).next().next().next().next().next().hide();
		
		$(this).next().show();
		$(this).parent().next().show();	
	});
	
	//	댓글 답글 창 닫기
	$(document).on('click', '.btnCommentReplyCancel', function () {
		loginChk();
		
		$(this).hide();

		$(this).prev().show();
		$(this).next().show();
		$(this).next().next().next().next().show();
		
		$(this).parent().next().hide();	
	});

	//	댓글 답글 등록
	$(document).on('click', '.btnCommentReply', function () {
		loginChk();
		
		let content = $(this).prev().val();
		let bId = $(this).prev().prev().prev().val();
		let username = $(this).prev().prev().val();
		let group = $(this).next().val();
		let order = $(this).next().next().val();
		let depth = $(this).next().next().next().val();
		
		console.log(content);
		console.log(bId);
		console.log(username);
		console.log(group);
		console.log(order);
		console.log(depth);

		$.ajax({
			  method: "POST",
			  url: "/comment/reply",
			  data: { bId: bId, cWriter: username, cContent: content,
				  	  cGroup: group, cOrder: order, cDepth: depth }
		})
		.done(function( msg ) {
		    $('#commentListDiv').html(msg);
		});
		
	});
	//	댓글 수정 창 열기
	$(document).on('click', '.btnCommentEdit', function () {
		loginChk();
		
		$(this).hide();
		$(this).prev().prev().hide();
		$(this).next().next().next().hide();
		
		$(this).next().show();
		$(this).next().next().show();

		$(this).prev().prev().prev().removeAttr('readonly');

		let content = $(this).prev().prev().prev().val();
		console.log(content);

		//	댓글 수정 창 닫기
		$(document).on('click', '.btnCommentEditCancel', function () {
			console.log(content);
			
			$(this).hide();
			$(this).prev().hide();

			$(this).next().show();
			$(this).prev().prev().show();
			$(this).prev().prev().prev().prev().show();

			$(this).prev().prev().prev().prev().prev().attr('readonly', true);
			$(this).prev().prev().prev().prev().prev().val(content);
		});
		
	});
	//	댓글 수정
	$(document).on('click', '.btnCommentEditPro', function () {
		loginChk();
		
		let content = $(this).prev().prev().prev().prev().val();
		let cId = $(this).attr('cId');
		
		$.ajax({
			  method: "POST",
			  url: "/comment/edit",
			  data: { cId: cId, cContent: content }
		})
		.done(function( msg ) {
		    $('#commentListDiv').html(msg);
		});
		
	});

	//	댓글 삭제
	$(document).on('click', '.btnCommentDelete', function () {
		loginChk();
		
		let cId = $(this).attr('cId');
		
		$.ajax({
			  method: "POST",
			  url: "/comment/delete",
			  data: { cId: cId }
		})
		.done(function( msg ) {
		    $('#commentListDiv').html(msg);
		});
		
	});

	
</script>
</html>