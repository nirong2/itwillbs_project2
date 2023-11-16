package com.project2.service;

import java.util.List;

import com.project2.domain.UserVO;

public interface UserService {

	
	// 실제로 구현해야 하는 기능 정의
	// 회원가입 동작 실행
	public void insertUser(UserVO vo);

	// 로그인 체크 동작
	public UserVO userLogin(UserVO vo);

	// 회원정보 조회 동작
	public UserVO userInfo(String id);

	// 회원정보 수정 동작
	public void userUpdate(UserVO updateVO);

	// 회원정보 삭제 동작
	public int userDelete(UserVO deleteVO);

	// 회원정보 목록조회 동작
	public List<UserVO> userList();

	// 아이디 중복체크
	public int idCheck(String id);

	// 휴대폰번호 중복체크
	public int phoneCheck(String phone);

	// 회원등급변경
	public UserVO getUserById(String user_id);

	public void updateUserGrade(UserVO userVO);

	// 아이디 찾기
	UserVO findUserByNameAndPhone(String user_name, String user_phone);

<<<<<<< Updated upstream
	//회원수정
	public void updateUser(UserVO vo);
=======
	//비번찾기 
	UserVO findUserByNameAndId(String user_name, String user_id);
	
	//새비번
	void changePassword(String userId, String newPassword);
	
>>>>>>> Stashed changes
	
	// 회원정보 삭제 동작
	//	public void deleteUser(UserVO deleteVO);
	int userDeleteById(String user_id);
}
