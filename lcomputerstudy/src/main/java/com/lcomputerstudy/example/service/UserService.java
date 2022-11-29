package com.lcomputerstudy.example.service;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;

import com.lcomputerstudy.example.domain.Pagination;
import com.lcomputerstudy.example.domain.User;
public interface UserService extends UserDetailsService{
	
	// 유저 읽기
	public User readUser(String username);
	
	// 유저 생성
	public void createUser(User user);
	
	// 권한 생성
	public void createAuthorities(User user);
	
	// 시큐리티 권한 얻기
	Collection<GrantedAuthority> getAuthorities(String username);

	// 유저 목록
	public List<User> selectUserList(Pagination page);

	public int getCountUser();

	// 관리자 권한 설정
	public void levelUp(User user);

	// 관리자 권한 해제
	public void levelDown(User user);
	
}
