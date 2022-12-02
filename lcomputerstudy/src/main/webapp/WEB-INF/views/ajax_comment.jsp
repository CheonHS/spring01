<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:if test="${empty list}">댓글이 없습니다.</c:if>
<c:if test="${!empty list}">
   	<c:forEach var="list" items="${list }">
    	<div>
    		<div style="font-size: 0.8em; margin-left:10px; margin-right: 10px; margin-top: 10px;">
    			<c:forEach begin="1" end="${list.cDepth }" step="1">&emsp;</c:forEach>
				${list.cWriter } / ${list.cDateTime }
			</div>
			<c:forEach begin="1" end="${list.cDepth }" step="1">&emsp;</c:forEach>
			<c:if test="${list.cDepth ne 0 }">└</c:if>
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