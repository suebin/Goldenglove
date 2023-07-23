package com.musamanru.goldenglove.ranking;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("RankingService")
public class RankingServiceImpl implements RankingService {
	@Autowired
	RankingDAO dao;
	
	public List<RankingDTO> showRanking() {
		return dao.showRanking();
	}
}
