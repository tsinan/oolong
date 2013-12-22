package com.oolong.global;

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
public interface FreePushUrlRepository extends JpaRepository<FreePushUrl,Long>
{

	List<FreePushUrl> findByUrlLike(String url, Pageable pageable);

	long countByUrlLike(String url);
	
	List<FreePushUrl> findByUrl(String url);
	
	@Modifying
	@Query("delete from FreePushUrl u where u.id in ( ?1 )")
	void batchDelete(List<Long> ids);
	
	@Modifying
	@Query("delete from FreePushUrl u ")
	void deleteUrls();
}
