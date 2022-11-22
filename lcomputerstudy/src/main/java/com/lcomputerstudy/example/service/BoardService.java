package com.lcomputerstudy.example.service;

import java.util.List;
import com.lcomputerstudy.example.domain.Board;

public interface BoardService {
	
	// 게시판 목록
	public List<Board> selectBoardList();
	
	// 게시판 상세
	public Board selectBoardRow(Board row);
	
	// 게시판 작성
	public void writeBoard(Board board);
	
	// 게시판 작성 후 group 설정
	public void groupUpdateBoard(Board board);

	// 게시판 수정
	public void updateBoard(Board board);

	// 게시판 삭제
	public void deleteBoard(Board board);

	// 게시판 답글 전 order 증가
	public void orderUpBoard(Board board);
	
	// 게시판 답글
	public void replyBoard(Board board);

}
