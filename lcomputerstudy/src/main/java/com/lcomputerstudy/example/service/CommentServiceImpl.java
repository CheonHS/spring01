package com.lcomputerstudy.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lcomputerstudy.example.domain.Comment;
import com.lcomputerstudy.example.mapper.CommentMapper;

@Service("CommentServiceImpl")
public class CommentServiceImpl implements CommentService {
	
	@Autowired
	CommentMapper commentMapper;

	@Override
	public List<Comment> selectCommentList() {
		return commentMapper.selectCommentList();
	}

	@Override
	public void writeComment(Comment comment) {
		commentMapper.writeComment(comment);
		
	}

	@Override
	public void groupUpdateComment(Comment comment) {
		commentMapper.groupUpdateComment(comment);
		
	}

	@Override
	public void replyComment(Comment comment) {
		commentMapper.replyComment(comment);
		
	}

	@Override
	public void editComment(Comment comment) {
		commentMapper.editComment(comment);
		
	}

	@Override
	public void deleteComment(Comment comment) {
		commentMapper.deleteComment(comment);
		
	}

}
