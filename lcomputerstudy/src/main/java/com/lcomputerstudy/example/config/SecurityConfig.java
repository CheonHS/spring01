package com.lcomputerstudy.example.config;

import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import com.lcomputerstudy.example.service.UserService;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	@Autowired
	private UserService userService;
	
	@Autowired
	private DataSource dataSource;
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		// 인증과 권한
		http
		.authorizeRequests()
		.antMatchers("/user/**").authenticated()
		.antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')")
		.antMatchers("/board/write").authenticated()
		.antMatchers("/comment/**").authenticated()
		.anyRequest().permitAll()
		.and()
		
		// 홈 로그인 설정
		.formLogin()
			.loginPage("/login")
			.loginProcessingUrl("/loginPro")
			.defaultSuccessUrl("/", true)
			.permitAll()
			.and()
		
		// 로그아웃 설정
		.logout()
			.logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
			.logoutSuccessUrl("/")
			.invalidateHttpSession(true)
			.deleteCookies("JSESSIONID", "remember-me")
			.and()
		
		// remember me 설정
		.rememberMe()
			.key("myWeb")
			.rememberMeParameter("remember-me")
			.tokenValiditySeconds(86400)	// 1 day
			.and()
		
		// exceptionHandling
		.exceptionHandling()
			.accessDeniedPage("/denied")
			.and()
		
		// session 관리
		.sessionManagement()
			.sessionCreationPolicy(SessionCreationPolicy.NEVER)
			.invalidSessionUrl("/login")
			.and()
		
		// csrf
		.csrf().disable();
	}
	
	@Bean
	public PersistentTokenRepository PersistentTokenRepository() {
		JdbcTokenRepositoryImpl db = new JdbcTokenRepositoryImpl();
		db.setDataSource(dataSource);
		return db;
		
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userService).passwordEncoder(passwordEncoder());
	}
	
	@Bean
	@Override
	public AuthenticationManager authenticationManagerBean() throws Exception{
		return super.authenticationManagerBean();
	}

}
