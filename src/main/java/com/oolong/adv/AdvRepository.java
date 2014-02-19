package com.oolong.adv;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

/**
 *
 * @author liumeng
 * @since 2014-1-7
 */
public interface AdvRepository extends JpaRepository<Adv,Long>
{
	List<Adv> findByAdvName(String advName);
	
	List<Adv> findByAdvNameLike(String advNameLike, Pageable pageable);

	long countByAdvNameLike(String advNameLike);
	
	long countByActivityId(long activityId);
	
	@Modifying
	@Query("delete from Adv a where a.id in ( ?1 )")
	void batchDelete(List<Long> ids);
	
//	@Query("select count(a.id) from Adv a where a.activityId in ( ?1 )")
//	long countByActivityIds(List<Long> ids);
}
