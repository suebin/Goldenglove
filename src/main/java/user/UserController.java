package user;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import team.TeamService;

@Controller
public class UserController {
	@Autowired
	UserService userService;

	@Autowired
	TeamService teamService;

//	회원가입
	@RequestMapping("/signup")
	public String signUp(HttpServletRequest request) {
		if (request.getSession().getAttribute("loginInfo") == null) {
			return "user/signUp";
		} else {
			return "main/main";
		}
	}

//	회원가입 완료
	@PostMapping("/signupResult")
	public String signupResult(UserDTO dto) {
		userService.insertUser(dto);
		return "main/main";
	}

//	중복검사
	@ResponseBody
	@RequestMapping("/duplicateCheck")
	public String duplicateCheck(String id, String value) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id.substring(0, id.length() - 9));
		map.put("value", value);
		int checkResult = userService.duplicateCheck(map);

		String result = "입력해주세요.";
		if (checkResult > 0) {
			result = "이미 사용중입니다.";
		} else if (value.length() == 0) {
			result = "입력해주세요.";
		} else {
			result = "사용 가능합니다.";
		}
		return "{\"result\":\"" + result + "\"}";
	}

//	로그인
	@RequestMapping("/login")
	public String login(HttpServletRequest request) {
		if (request.getSession().getAttribute("loginInfo") == null) {
			return "user/logIn";
		} else {
			return "main/main";
		}
	}

//	로그인 검사
	@ResponseBody
	@PostMapping("/loginCheck")
	public String idCheck(String id, String password, HttpServletRequest request) {
		UserDTO loginInfo = userService.selectUser(id);
		String result = "";
		if (loginInfo == null) {
			result = "존재하지 않는 아이디입니다.";
		} else if (!loginInfo.getPassword().equals(password)) {
			result = "아이디와 비밀번호가 일치하지 않습니다.";
		} else if (loginInfo.getPassword().equals(password)) {
			result = "성공";
			HttpSession session = request.getSession();
			session.setAttribute("loginInfo", loginInfo);
		}
		return "{\"result\":\"" + result + "\"}";
	}

//	로그아웃
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "main/main";
	}

//	내정보
	@RequestMapping("/mypage")
	public String mypage(HttpServletRequest request) {
		if (request.getSession().getAttribute("loginInfo") != null) {
			HttpSession session = request.getSession();
			UserDTO user = (UserDTO) session.getAttribute("loginInfo");
			return "mypage/myPage";
		} else {
			return "main/main";
		}
	}

//	내정보 수정 폼
	@RequestMapping("/updateinfo")
	public String updateInfo(HttpServletRequest request) {
		if (request.getSession().getAttribute("loginInfo") != null) {
			return "mypage/updateInfo";
		} else {
			return "main/main";
		}
	}

//	내정보 수정
	@PostMapping("/updateResult")
	public String updateResult(UserDTO dto, HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserDTO loginInfo = (UserDTO) session.getAttribute("loginInfo");
		dto.setId(loginInfo.getId());
		userService.updateUser(dto);
		UserDTO updateInfo = userService.selectUser(dto.getId());
		session.setAttribute("loginInfo", updateInfo);
		return "mypage/myPage";
	}

//	아이디찾기
	@RequestMapping("/findid")
	public String findId() {
		return "user/findId";
	}

	@ResponseBody
	@RequestMapping("findidresult")
	public String findIdResult(UserDTO dto) {
		String id = userService.findId(dto);
		String result = "";
		if (id != null) {
			result = "회원님의 아이디는 " + id + " 입니다.";
		} else {
			result = "입력하신 정보와 일치하는 아이디가 없습니다.";
		}
		return "{\"result\":\"" + result + "\"}";
	}

//	비밀번호찾기
	@RequestMapping("/findpw")
	public String findPw() {
		return "user/findPw";
	}

	@ResponseBody
	@RequestMapping("findpwresult")
	public String findPwResult(UserDTO dto) {
		String pw = userService.findPw(dto);
		String result = "";
		if (pw != null) {
			result = "success";
		} else {
			result = "입력하신 정보와 일치하는 정보가 없습니다.";
		}
		JSONObject json = new JSONObject();
		json.append("result", result);
		json.append("name", dto.getName());
		json.append("id", dto.getId());
		json.append("email", dto.getEmail());
		return json.toString();
	}

//	비밀번호 수정
	@RequestMapping("updatePassword")
	public String updatePassword(UserDTO dto) {
		userService.updatePassword(dto);
		return "main/main";
	}
}
