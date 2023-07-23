package com.musamanru.goldenglove.penalty;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("PenaltyDAO")
public interface PenaltyDAO {
	PenaltyDTO selectPenaltyTeam(String teamName); 
}
