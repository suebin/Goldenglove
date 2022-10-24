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

//	유저조회
	UserDTO selectUser(String id);

//	수정
	void updateUser(UserDTO dto);

//	아이디 찾기
	String findId(UserDTO dto);

//	비밀번호 찾기
	String findPw(UserDTO dto);

//	비밀번호 수정
	void updatePassword(UserDTO dto);

//	팀 가입 승인
	void updateTeamName(HashMap registerInfo);

//	이름조회
	UserDTO selectName(String name);

//	팀명조회
	String selectTeamName(String name);

	UserDTO selectTeamNameId(String id);
}
