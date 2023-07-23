package com.musamanru.goldenglove.penalty;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("penaltyService")
public class PenaltyService {
	@Autowired
	PenaltyDAO dao;
	
	public PenaltyDTO selectPenaltyTeam(String teamName) {
		return dao.selectPenaltyTeam(teamName);
	}
}
