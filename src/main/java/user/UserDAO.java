package user;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("userDAO")
public interface UserDAO {
	void insertUser(UserDTO dto);

	int duplicateCheck(HashMap<String, String> map);
}
