package com.lcomputerstudy.example.service;

import java.util.List;
import com.lcomputerstudy.example.domain.Board;

public interface BoardService {
	public List<Board> selectBoardList();
	
	public Board selectBoardRow(Board row);

	public void writeBoard(Board board);

	public void updateBoard(Board board);

	public void deleteBoard(Board board);
	
}
