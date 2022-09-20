package user;

import java.util.HashMap;

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

	@RequestMapping("/signup")
	public String signUp() {
		return "user/signUp";
	}

	@PostMapping("/signupResult")
	public ModelAndView signupResult(UserDTO dto) {
		userService.insertUser(dto);
		ModelAndView mv = new ModelAndView();
		mv.addObject("name", dto.getName());
		mv.setViewName("team/teamRegistration");
		return mv;
	}

	@ResponseBody
	@RequestMapping("duplicateCheck")
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

	@RequestMapping("/test")
	public String test() {
		return "team/teamRegistration";
	}
}
