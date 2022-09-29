package sns;

import java.math.BigInteger;
import java.security.SecureRandom;

public class SnsInform {
//	카카오
	public static final String REST_API_KEY = "0a70206b6221222f494d09db31796ca6";
	public static final String REDIRECT_URI = "http://localhost:8080/kakaoResult";

//	네이버
	public static final String CLIENT_ID = "hQVjevjqV0Z3tSL_qTm3";
	public static final String CLIENT_SECRET = "h8W5oRKJ8G";
	public static final String CALLBACK_URL = "http://localhost:8080/naverResult";
	public static final String STATE_STRING = new BigInteger(130, new SecureRandom()).toString();
}