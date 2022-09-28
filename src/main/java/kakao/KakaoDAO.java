package kakao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import user.UserDTO;

@Mapper
@Repository("kakaoDAO")
public interface KakaoDAO {
	UserDTO selectUser(String kakaoId);
}
