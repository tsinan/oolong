package com.oolong.adv;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

/**
 *
 * @author liumeng
 * @since 2014-1-12
 */
public interface AdvWebsiteRelationRepository extends JpaRepository<AdvWebsiteRelation,Long>
{
	List<AdvWebsiteRelation> findByAdvId(Long advId);
	
	long countByWebsiteId(Long websiteId);
	
	@Modifying
	@Query("delete from AdvWebsiteRelation awr where awr.advId in ( ?1 )")
	void batchDelete(List<Long> ids);

}
