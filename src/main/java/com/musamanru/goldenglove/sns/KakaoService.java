package com.musamanru.goldenglove.sns;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.musamanru.goldenglove.user.UserDTO;

@Service("kakaoService")
public class KakaoService {
	@Autowired
	SnsDAO snsDao;

	public String getKakaoAccessToken(String code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";

		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			// POST 요청을 위해 기본값이 false인 setDoOutput을 true로
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			// POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=" + SnsInform.REST_API_KEY); // TODO REST_API_KEY 입력
			sb.append("&redirect_uri=" + SnsInform.REDIRECT_URI); // TODO 인가코드 받은 redirect_uri 입력
			sb.append("&code=" + code);
			bw.write(sb.toString());
			bw.flush();

			// 결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
//			System.out.println("responseCode : " + responseCode);

			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
//			System.out.println("response body : " + result);

			// JSON파싱 객체 생성
			JSONObject json = new JSONObject(result);

			access_Token = json.getString("access_token");
			refresh_Token = json.getString("refresh_token");

//			System.out.println("access_token : " + access_Token);
//			System.out.println("refresh_token : " + refresh_Token);

			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return access_Token;
	}

	public long createKakaoUser(String token) {

		String reqURL = "https://kapi.kakao.com/v2/user/me";
		long id = 0;
		// access_token을 이용하여 사용자 정보 조회
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			conn.setRequestProperty("Authorization", "Bearer " + token); // 전송할 header 작성, access_token전송

			// 결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
//			System.out.println("responseCode : " + responseCode);

			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
//			System.out.println("response body : " + result);
			JSONObject json = new JSONObject(result);
			id = json.getLong("id");
			br.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
		return id;
	}

	public String loginKakaoUser(String kakaoId) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest();
		HttpSession session = request.getSession();
		UserDTO user = snsDao.selectUserKakao(kakaoId);

		if (user == null) {
			request.setAttribute("kakaoId", kakaoId);
			return "com/musamanru/goldenglove/user/snsCheck";
		} else {
			session.setAttribute("loginInfo", user);
			return "main/main";
		}
	}
}
