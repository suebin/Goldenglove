package com.musamanru.goldenglove.notice;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("noticeServiceImpl")
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	NoticeDAO dao;

	@Override
	public List<NoticeDTO> selectAllNotice() {
		return dao.selectAllNotice();
	};

	@Override
	public NoticeDTO selectNotice(int rowNum) {
		return dao.selectNotice(rowNum);
	};

	@Override
	public int selectCount() {
		return dao.selectCount();
	};
	
	@Override
	public List<NoticeDTO> pagingList(int [] limit) {
		return dao.pagingList(limit);
	}

	@Override
	public List<NoticeDTO> searchList(HashMap map) {
		return dao.searchList(map);
	}

	@Override
	public int searchCount(HashMap searchWord) {
		return dao.searchCount(searchWord);
	};

	@Override
	public void insertNotice(NoticeDTO dto) {
		dao.insertNotice(dto);
		dao.updateRowNum();
	};

	@Override
	public void updateNotice(NoticeDTO dto) {
		dao.updateNotice(dto);
	};

	@Override
	public void deleteNotice(int rowNum) {
		dao.deleteNotice(rowNum);
		dao.updateRowNum();
	};
	
	@Override
	public void updateViewCount(int rowNum) {
		dao.updateViewCount(rowNum);
	};
}
