package sns;

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

import user.UserDTO;

@Service("naverService")
public class NaverService {
	@Autowired
	SnsDAO snsDao;

	public String getNaverAccessToken(String code, String state) {
		String access_token = "";
		String refresh_token = "";
		String reqURL = "https://nid.naver.com/oauth2.0/token";

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
			sb.append("&client_id=" + SnsInform.CLIENT_ID); // TODO REST_API_KEY 입력
			sb.append("&client_secret=" + SnsInform.CLIENT_SECRET); // TODO 인가코드 받은 redirect_uri 입력
			sb.append("&code=" + code);
			sb.append("&state=" + state);
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

			access_token = json.getString("access_token");
			refresh_token = json.getString("refresh_token");

//			System.out.println("access_token : " + access_token);
//			System.out.println("refresh_token : " + refresh_token);

			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return access_token;
	}

	public String createNaverUser(String token) {

		String reqURL = "https://openapi.naver.com/v1/nid/me";
		String id = "";
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
			JSONObject response = json.getJSONObject("response");
			id = response.getString("id");
			br.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
		return id;
	}

	public String loginNaverUser(String naverId) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest();
		HttpSession session = request.getSession();
		UserDTO user = snsDao.selectUserNaver(naverId);

		if (user == null) {
			request.setAttribute("naverId", naverId);
			return "user/snsCheck";
		} else {
			session.setAttribute("loginInfo", user);
			return "main/main";
		}
	}
}
