package user;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("userDAO")
public interface UserDAO {
//	회원가입
	void insertUser(UserDTO dto);

//	중복검사
	int duplicateCheck(HashMap<String, String> map);

//	로그인 검사
	UserDTO idCheck(String id);
}
