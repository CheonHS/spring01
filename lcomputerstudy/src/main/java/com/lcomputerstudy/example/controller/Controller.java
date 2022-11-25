package com.lcomputerstudy.example.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lcomputerstudy.example.domain.Board;
import com.lcomputerstudy.example.domain.Comment;
import com.lcomputerstudy.example.domain.Pagination;
import com.lcomputerstudy.example.domain.User;
import com.lcomputerstudy.example.service.BoardService;
import com.lcomputerstudy.example.service.CommentService;
import com.lcomputerstudy.example.service.UserService;

@org.springframework.stereotype.Controller
public class Controller {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired UserService userservice;
	@Autowired BoardService boardservice;
	@Autowired CommentService commentservice;
	
	Pagination pagination = null;
	
	@RequestMapping("/")
	public String home(Model model) {		
		return "/index";
	}
	
	@RequestMapping("/beforeSignUp")
	public String beforeSignUp() {
		return "/signup";
	}

	@RequestMapping("/signup")
	public String singup(User user) {
		// 비밀번호 암호화
		String encodedPassword = new BCryptPasswordEncoder().encode(user.getPassword());
		
		// 유저 데이터 세팅
		user.setPassword(encodedPassword);
		user.setAccountNonExpired(true);
		user.setEnabled(true);
		user.setAccountNonLocked(true);
		user.setCredentialsNonExpired(true);
		user.setAuthorities(AuthorityUtils.createAuthorityList("ROLE_USER"));   

		
		// 유저 생성
		userservice.createUser(user);
		
		// 유저 권한 생성
		userservice.createAuthorities(user);
		
		return "/login";
	}
	
	@RequestMapping(value="/login")
		public String beforeLogin(Model model) {
			return "/login";
	}

	@Secured({"ROLE_USER"})
	@RequestMapping(value="/user/info")
		public String userInfo(Model model) {
			return "/user_info";
	}
	
	@RequestMapping(value="/denied")
		public String denied(Model model) {
			return "/denied";
	}
	
	@RequestMapping(value="/user/levelUp")
	public String levelUp(@RequestParam("uId") String uId, Model model) {
		User user = new User();
		user.setUsername(uId);
		userservice.levelUp(user);
		return "/user_info";
}
	//	admin
	
	@Secured({"ROLE_ADMIN"})
	@RequestMapping(value="/admin")
		public String admin(Model model) {
			return "/admin";
	}
	@Secured({"ROLE_ADMIN"})
	@RequestMapping(value="/admin/userList")
	public String userList(@ModelAttribute Pagination page, Model model) {
		
		pagination = new Pagination();
		if(Integer.toString(page.getPage())!="") {
			pagination.setPage(page.getPage());
		}
		pagination.setCount(userservice.getCountUser());
		pagination.init();
		
		List<User> list = userservice.selectUserList(pagination);
		
		model.addAttribute("page", pagination);
		model.addAttribute("list", list);
		logger.debug("debug");
		logger.info("info");
		logger.error("error");
	
		return "/user_list";
	}

	
	//	board
	
	@RequestMapping(value="/board")
	public String boardList(@ModelAttribute Pagination page, Model model) {
		
		pagination = new Pagination();
		if(Integer.toString(page.getPage())!="") {
			pagination.setPage(page.getPage());
		}
		pagination.setCount(boardservice.getCountBoard());
		pagination.init();
		
		List<Board> list = boardservice.selectBoardList(pagination);
		
		model.addAttribute("page", pagination);
		model.addAttribute("list", list);
		logger.debug("debug");
		logger.info("info");
		logger.error("error");
		return "/board_list";
	}
	
	@RequestMapping(value="/board/detail")
//	public String boardDetail(@RequestParam("bId") String bId, Model model) {
	public String boardDetail(@ModelAttribute Board board, Model model) {
		Board row = boardservice.selectBoardRow(board);
		row.setRownum(board.getRownum());
		model.addAttribute("row", row);
		
		List<Comment> list = commentservice.selectCommentList();
		model.addAttribute("list", list);
		return "/board_detail";
	}
	
	@Secured({"ROLE_USER", "ROLE_ADMIN"})
	@RequestMapping(value="/board/write")
	public String boardWrite(Model model) {
		return "/board_write";
	}
	
	@RequestMapping(value="/board/writePro")
	public String boardWritePro(Board board, Model model) {
		boardservice.writeBoard(board);
		boardservice.groupUpdateBoard(board);
		return boardDetail(board, model);
	}
	
	@RequestMapping(value="/board/update")
	public String boardUpdate(@RequestParam("bId") String bId, Model model) {
		Board row = new Board();
		row.setbId(Integer.parseInt(bId));
		row = boardservice.selectBoardRow(row);
		model.addAttribute("row", row);
		return "/board_update";
	}
	
	@RequestMapping(value="/board/updatePro")
	public String boardUpdatePro(Board board, Model model) {
		boardservice.updateBoard(board);
		return boardDetail(board, model);
	}
	
	@RequestMapping(value="/board/delete")
	public String boardDelete(@ModelAttribute Board board, Model model) {
		boardservice.deleteBoard(board);
		pagination = new Pagination();
		return boardList(pagination, model);
	}
	
	@RequestMapping(value="/board/reply")
	public String boardReply(@ModelAttribute Board board, Model model) {
		Board row = boardservice.selectBoardRow(board);
		model.addAttribute("row", row);
		return "/board_reply";
	}
	
	@RequestMapping(value="/board/replyPro")
	public String boardReplyPro(Board board, Model model) {
		boardservice.orderUpBoard(board);
		boardservice.replyBoard(board);
		return boardDetail(board, model);
	}
	
	//	comment	
	
	@RequestMapping(value="/comment/write")
	public String commentWrite(Comment comment, Model model) {
		commentservice.writeComment(comment);
		commentservice.groupUpdateComment(comment);
		
		List<Comment> list = commentservice.selectCommentList();
		model.addAttribute("list", list);
		return "/ajax_comment";
	}
	
}
