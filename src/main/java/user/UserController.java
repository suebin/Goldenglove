package user;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UserController {
	@Autowired
	UserService userService;

//	회원가입
	@RequestMapping("/signup")
	public String signUp(HttpServletRequest request) {
		if (request.getHeader("REFERER") != null) {
			return "user/signUp";
		} else {
			return "main/main";
		}
	}

//	회원가입 후 팀원 등록
	@PostMapping("/signupResult")
	public ModelAndView signupResult(UserDTO dto) {
		userService.insertUser(dto);
		ModelAndView mv = new ModelAndView();
		mv.addObject("name", dto.getName());
		mv.setViewName("team/teamRegistration");
		return mv;
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
		if (request.getHeader("REFERER") != null) {
			return "user/logIn";
		} else {
			return "main/main";
		}
	}

//	로그인 검사
	@ResponseBody
	@PostMapping("/loginCheck")
	public String idCheck(String id, String password, HttpServletRequest request) {
		UserDTO loginInfo = userService.idCheck(id);
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
	@RequestMapping("/test")
	public String test() {
		return "team/teamRegistration";
	}
}
