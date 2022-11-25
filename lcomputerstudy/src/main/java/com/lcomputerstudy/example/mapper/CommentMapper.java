package com.lcomputerstudy.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.lcomputerstudy.example.domain.Comment;

@Mapper
public interface CommentMapper {

	public List<Comment> selectCommentList();

	public void writeComment(Comment comment);

	public void groupUpdateComment(Comment comment);

}
