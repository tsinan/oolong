package com.oolong.adv;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author liumeng
 * @since 2013-11-23
 */
public interface ActivityRepository extends JpaRepository<Activity,Long>
{
	
	List<Activity> findByActivityName(String activityName);
	
	List<Activity> findByActivityNameLike(String activityNameLike, Pageable pageable);

	long countByActivityNameLike(String activityNameLike);
	
//	@Modifying
//	@Query("delete from Activity a where a.id in ( ?1 )")
//	void batchDelete(List<Long> ids);
	
}
