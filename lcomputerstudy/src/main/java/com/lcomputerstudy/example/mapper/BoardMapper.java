package com.lcomputerstudy.example.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.lcomputerstudy.example.domain.Board;
import com.lcomputerstudy.example.domain.Pagination;

@Mapper
public interface BoardMapper {
	public List<Board> selectBoardList(Pagination page);

	public Board selectBoardRow(Board board);

	public void writeBoard(Board board);
	
	public void groupUpdateBoard(Board board);

	public void updateBoard(Board board);

	public void deleteBoard(Board board);

	public void orderUpBoard(Board board);
	
	public void replyBoard(Board board);

	public int getCountBoard(Pagination page);

	public void addBoardFile(Board board);

}
