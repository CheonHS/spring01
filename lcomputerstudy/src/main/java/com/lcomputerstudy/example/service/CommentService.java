package com.lcomputerstudy.example.service;

import java.util.List;
import com.lcomputerstudy.example.domain.Comment;

public interface CommentService {

	public List<Comment> selectCommentList();

	public void writeComment(Comment comment);

	public void groupUpdateComment(Comment comment);

}
