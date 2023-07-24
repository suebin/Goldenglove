package com.musamanru.goldenglove.user;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("userService")
public class UserService {
	@Autowired
	UserDAO userDao;

//	회원가입
	public void insertUser(UserDTO dto) {
		userDao.insertUser(dto);
	}

//	중복검사
	public int duplicateCheck(HashMap<String, String> map) {
		return userDao.duplicateCheck(map);
	}

//	유저조회
	public UserDTO selectUser(String id) {
		return userDao.selectUser(id);
	}

//	수정
	public void updateUser(UserDTO dto) {
		userDao.updateUser(dto);
	}

//	아이디 찾기
	public String findId(UserDTO dto) {
		return userDao.findId(dto);
	}

//	비밀번호 찾기
	public String findPw(UserDTO dto) {
		return userDao.findPw(dto);
	}

//	비밀번호 수정
	public void updatePassword(UserDTO dto) {
		userDao.updatePassword(dto);
	}

//	팀 가입 승인
	public void updateTeamName(HashMap registerInfo) {
		userDao.updateTeamName(registerInfo);
	}

//	이름조회
	public UserDTO selectName(String name) {
		return userDao.selectName(name);
	}

//	팀명조회
	public String selectTeamName(String name) {
		return userDao.selectTeamName(name);
	}

//	회원탈퇴
	public void deleteUser(String id) {
		userDao.deleteUser(id);
	}
}
