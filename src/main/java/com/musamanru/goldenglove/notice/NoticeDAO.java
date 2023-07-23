package com.musamanru.goldenglove.notice;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("noticeDAO")
public interface NoticeDAO {
	List<NoticeDTO> selectAllNotice();
	NoticeDTO selectNotice(int rowNum);
	int selectCount();
	List<NoticeDTO> pagingList(int [] limit);
	List<NoticeDTO> searchList(HashMap map);
	int searchCount(HashMap searchWord);
	int insertNotice(NoticeDTO dto);
	int updateNotice(NoticeDTO dto);
	int deleteNotice(int rowNum);
	int updateViewCount(int rowNum);
	int updateRowNum();
}
