package notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

@Controller
public class NoticeController {
	@Autowired
	@Qualifier("noticeServiceImpl")
	NoticeServiceImpl service;
	
	// 공지 목록
	@RequestMapping(value= {"/notice", "/noticeSearch"})
	public ModelAndView selectNotice(@RequestParam(value="page", defaultValue="1") int page, HttpServletRequest request, String opt, String searchWord) {
		String requestUrl = (String) request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
		ModelAndView mv = new ModelAndView();
		int totalCount = 0;
		
		if (requestUrl.equals("/notice")) {
			List<NoticeDTO> pagingList = service.pagingList(new int[] {(page-1) * 10, 10});
			totalCount = service.selectCount();
			mv.addObject("pagingList", pagingList);
			
		} else if (requestUrl.equals("/noticeSearch")) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("opt", opt);
			map.put("searchWord", searchWord);
			map.put("page", new int[] {(page-1) * 10, 10});
			
			List<NoticeDTO> searchList = service.searchList(map);
			totalCount = service.searchCount(map);
			mv.addObject("pagingList", searchList);
			mv.addObject("searchMap", map);
		}
		
		mv.addObject("totalCount", totalCount);
		mv.addObject("requestUrl", requestUrl);
		mv.setViewName("notice/noticeList");
		return mv;
	};

	
	// 공지 작성
	@GetMapping("/noticeWrite")
	public String writeNotice(NoticeDTO dto) {
		return "/notice/noticeWrite";
	};

	@PostMapping("/noticeWrite")
	public String insertNotice(NoticeDTO dto) {
		service.insertNotice(dto);
		return "redirect:/notice";
	};

	
	// 공지 상세페이지
	@RequestMapping("/noticeDetail")
	public ModelAndView detailNotice(int rowNum) {
		ModelAndView mv = new ModelAndView();

		service.updateViewCount(rowNum);
		NoticeDTO list = service.selectNotice(rowNum);
		mv.addObject("list", list);
		
		int prevRowNum = rowNum - 1; 
		int nextRowNum = rowNum + 1; 
		int totalCount = service.selectCount();
		
		if(prevRowNum != 0) {
			String prevTitle = service.selectNotice(prevRowNum).getTitle();
			mv.addObject("prevTitle", prevTitle);
		} else {
			mv.addObject("prevTitle", "이전 글이 없습니다");
		}

		if(nextRowNum != totalCount + 1) {
			String nextTitle = service.selectNotice(nextRowNum).getTitle();
			mv.addObject("nextTitle", nextTitle);
		} else {
			mv.addObject("nextTitle", "다음 글이 없습니다");
		}

		mv.addObject("totalCount", totalCount);
		mv.setViewName("notice/noticeDetail");
		return mv;
	};

	
	// 공지 수정
	@GetMapping("/noticeUpdate")
	public ModelAndView getDetailNotice(int rowNum) {
		NoticeDTO list = service.selectNotice(rowNum);
		ModelAndView mv = new ModelAndView();
		mv.addObject("updateDetail", list);
		mv.setViewName("notice/noticeUpdate");
		return mv;
	};

	@PostMapping("/noticeUpdate")
	public String updateNotice(NoticeDTO dto) {
		service.updateNotice(dto);
		return "redirect:/noticeDetail?rowNum=" + dto.rowNum;
	};
	
	
	// 공지 삭제
	@RequestMapping("/noticeDelete")
	public String deleteNotice(int rowNum) {
		service.deleteNotice(rowNum);
		return "redirect:/notice";
	};
}
