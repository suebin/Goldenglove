package user;

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
//	로그인 검사
	public UserDTO idCheck(String id) {
		return userDao.idCheck(id);
	}
}
