package com.lcomputerstudy.example.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.lcomputerstudy.example.domain.Board;
import com.lcomputerstudy.example.domain.Pagination;
import com.lcomputerstudy.example.mapper.BoardMapper;

@Service("BoardServiceImpl")
public class BoardServiceImpl implements BoardService {
	
	@Autowired BoardMapper boardmapper;

	@Override
	public List<Board> selectBoardList(Pagination page) {
		return boardmapper.selectBoardList(page);
	}

	@Override
	public Board selectBoardRow(Board board) {
		return boardmapper.selectBoardRow(board);
	}

	@Override
	public void writeBoard(Board board) {
		boardmapper.writeBoard(board);
	}
	
	@Override
	public void groupUpdateBoard(Board board) {
		boardmapper.groupUpdateBoard(board);
	}

	@Override
	public void updateBoard(Board board) {
		boardmapper.updateBoard(board);
		
	}

	@Override
	public void deleteBoard(Board board) {
		boardmapper.deleteBoard(board);
		
	}

	@Override
	public void orderUpBoard(Board board) {
		boardmapper.orderUpBoard(board);
		
	}
	
	@Override
	public void replyBoard(Board board) {
		boardmapper.replyBoard(board);
		
	}

	@Override
	public int getCountBoard(Pagination page) {
		return boardmapper.getCountBoard(page);
	}

	@Override
	public void addBoardFile(Board board) {
		boardmapper.addBoardFile(board);
		
	}


	
}
