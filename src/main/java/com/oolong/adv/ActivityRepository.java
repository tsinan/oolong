package com.oolong.adv;

import java.util.Collection;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

/**
 *
 * @author liumeng
 * @since 2013-11-23
 */
public interface ActivityRepository extends JpaRepository<Activity,Long>
{
	List<Activity> findByActivityName(String activityName);

	@Modifying
	@Query("delete from Activity a where a.id in ( ?1 )")
	void batchDelete(List<Long> ids);
	
}
