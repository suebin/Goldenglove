package com.musamanru.goldenglove.notice;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

@Service("noticeService")
public interface NoticeService {
	List<NoticeDTO> selectAllNotice();
	NoticeDTO selectNotice(int rowNum);
	int selectCount();
	List<NoticeDTO> pagingList(int [] limit);
	List<NoticeDTO> searchList(HashMap map);
	int searchCount(HashMap searchWord);
	void insertNotice(NoticeDTO dto);
	void updateNotice(NoticeDTO dto);
	void deleteNotice(int rowNum);
	void updateViewCount(int rowNum);
}
