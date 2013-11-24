package com.oolong.adv;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author liumeng
 * @since 2013-11-23
 */
public interface ActivityRepository extends JpaRepository<Activity,Long>
{
	List<Activity> findByActivityName(String activityName);

}
