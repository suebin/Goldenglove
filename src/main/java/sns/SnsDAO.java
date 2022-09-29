package sns;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import user.UserDTO;

@Mapper
@Repository("snsDAO")
public interface SnsDAO {
	UserDTO selectUserKakao(String kakaoId);

	UserDTO selectUserNaver(String naverId);
}
