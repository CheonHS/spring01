package com.lcomputerstudy.example.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.lcomputerstudy.example.domain.Board;

@Mapper
public interface BoardMapper {
	public List<Board> selectBoardList();

	public Board selectBoardRow(Board board);

	public void writeBoard(Board board);

	public void updateBoard(Board board);

	public void deleteBoard(Board board);
}
