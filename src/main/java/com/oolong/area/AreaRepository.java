package com.oolong.area;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

/**
 *
 * @author liumeng
 * @since 2013-12-22
 */
public interface AreaRepository extends JpaRepository<Area,Long>
{
	List<Area> findByAreaName(String areaName);
	
	List<Area> findByAreaNameLike(String areaName, Pageable pageable);

	long countByAreaNameLike(String areaName);
	
	
	@Modifying
	@Query("delete from Area a where a.id in ( ?1 )")
	void batchDelete(List<Long> ids);
	
}
