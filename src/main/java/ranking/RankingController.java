package ranking;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class RankingController {
	@Autowired
	@Qualifier("RankingService")
	RankingServiceImpl service;

	@RequestMapping("/ranking")
	public ModelAndView showRanking() {
		List<RankingDTO> list = service.showRanking();
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);
		mv.setViewName("ranking/ranking");
		return mv;
	}

	@ResponseBody
	@RequestMapping("/mainRanking")
	public List<RankingDTO> showMainRanking() {
		List<RankingDTO> list = service.showRanking();
		return list;
	}
}
