package com.oolong.website;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

/**
 *
 * @author liumeng
 * @since 2013-12-07
 */
public interface WebsiteRepository extends JpaRepository<Website,Long>
{
	List<Website> findByWebsiteName(String websiteName);
	
	List<Website> findByWebsiteNameLike(String websiteName, Pageable pageable);

	long countByWebsiteNameLike(String websiteName);
	
	
	@Modifying
	@Query("delete from Website a where a.id in ( ?1 )")
	void batchDelete(List<Long> ids);
	
}
