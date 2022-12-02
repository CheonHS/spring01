package com.lcomputerstudy.example.service;

import java.util.List;

import com.lcomputerstudy.example.domain.Comment;

public interface CommentService {

	public List<Comment> selectCommentList(int bId);

	public void writeComment(Comment comment);

	public void groupUpdateComment(Comment comment);

	public void replyComment(Comment comment);

	public void editComment(Comment comment);

	public void deleteComment(Comment comment);

}
