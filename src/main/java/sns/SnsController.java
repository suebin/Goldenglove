package sns;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import user.UserService;

@Controller
public class SnsController {
	@Autowired
	KakaoService kakaoService;

	@Autowired
	NaverService naverService;

	@Autowired
	UserService userService;

//	카카오 토큰
	@RequestMapping("/kakaoLogin")
	public String kakaoLogin() {
		return "redirect:https://kauth.kakao.com/oauth/authorize?client_id=" + SnsInform.REST_API_KEY + "&redirect_uri="
				+ SnsInform.REDIRECT_URI + "&response_type=code";
	}

//	카카오 아이디
	@RequestMapping("/kakaoResult")
	public String kakaoResult(@RequestParam String code) {
		String token = kakaoService.getKakaoAccessToken(code);
		String kakaoId = String.valueOf(kakaoService.createKakaoUser(token));
		return kakaoService.loginKakaoUser(kakaoId);
	}

//	네이버 코드
	@RequestMapping("/naverLogin")
	public String naverLogin() {
		return "redirect:https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=" + SnsInform.CLIENT_ID
				+ "&state=" + SnsInform.STATE_STRING + "&redirect_uri=" + SnsInform.CALLBACK_URL;
	}

//	네이버 아이디
	@RequestMapping("/naverResult")
	public String naverResult(@RequestParam String code, @RequestParam String state) {
		String token = naverService.getNaverAccessToken(code, state);
		String naverId = naverService.createNaverUser(token);
		return naverService.loginNaverUser(naverId);
	}
}
