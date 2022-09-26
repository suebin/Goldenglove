package ranking;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("RankingDAO")
public interface RankingDAO {
	List<RankingDTO> showRanking(); 
}
