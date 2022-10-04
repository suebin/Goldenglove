package chatbot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ChatbotController {
	@Autowired
	@Qualifier("chatbotService")
	ChatbotServiceImpl service;
	
	@ResponseBody
	@RequestMapping("/chatbot")
	public String startChatbot(String request, String event) {
		String response = "";
		
		response = service.startChatbot(request, event);
		
		return response;
	}
}
