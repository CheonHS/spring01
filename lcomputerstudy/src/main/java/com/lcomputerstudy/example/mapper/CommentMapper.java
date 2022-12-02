package com.lcomputerstudy.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.lcomputerstudy.example.domain.Board;
import com.lcomputerstudy.example.domain.Comment;

@Mapper
public interface CommentMapper {

	public List<Comment> selectCommentList(int bId);

	public void writeComment(Comment comment);

	public void groupUpdateComment(Comment comment);

	public void replyComment(Comment comment);

	public void editComment(Comment comment);

	public void deleteComment(Comment comment);

}
