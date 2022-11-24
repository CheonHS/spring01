package com.lcomputerstudy.example.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.security.core.GrantedAuthority;

import com.lcomputerstudy.example.domain.Pagination;
import com.lcomputerstudy.example.domain.User;

@Mapper
public interface UserMapper {
	
   // 유저읽기
   public User readUser(String username);
   
   // 유저생성
   public void createUser(User user);

   // 권한 읽기
   public List<GrantedAuthority> readAuthorities(String username);

   // 권한 생성
   public void createAuthority(User user);

   // 관리자 권한 설정
   public void levelUp(User user);

   // 유저 목록
   public List<User> selectUserList(Pagination page);

   // 유저 개수
   public int getCountUser();

}
