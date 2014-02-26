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
public interface AdvAreaRelationRepository extends JpaRepository<AdvAreaRelation,Long>
{
	List<AdvAreaRelation> findByAdvId(Long advId);
	
	long countByAreaId(Long areaId);

	@Modifying
	@Query("delete from AdvAreaRelation aar where aar.advId in ( ?1 )")
	void batchDelete(List<Long> ids);

}
