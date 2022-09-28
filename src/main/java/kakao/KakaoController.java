package kakao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import user.UserService;

@Controller
public class KakaoController {
	@Autowired
	KakaoService kakaoService;

	@Autowired
	UserService userService;

//	카카오 토큰
	@RequestMapping("/kakaoLogin")
	public String kakaoLogin() {
		return "redirect:https://kauth.kakao.com/oauth/authorize?client_id=" + KakaoInform.REST_API_KEY
				+ "&redirect_uri=" + KakaoInform.REDIRECT_URI + "&response_type=code";
	}

//	카카오 아이디
	@RequestMapping("/kakaoResult")
	public String kakaoResult(@RequestParam String code) {
		String token = kakaoService.getKakaoAccessToken(code);
		String kakaoId = String.valueOf(kakaoService.createKakaoUser(token));
		return kakaoService.loginKakaoUser(kakaoId);
	}
}
