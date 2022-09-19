package user;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("userService")
public class UserService {
	@Autowired
	UserDAO userDao;

	public void insertUser(UserDTO dto) {
		userDao.insertUser(dto);
	}

	public int duplicateCheck(HashMap<String, String> map) {
		return userDao.duplicateCheck(map);
	}
}
