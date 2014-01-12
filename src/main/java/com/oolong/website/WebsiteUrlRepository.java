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
public interface WebsiteUrlRepository extends JpaRepository<WebsiteUrl,Long>
{

	List<WebsiteUrl> findByWebsiteId(Long websiteId, Pageable pageable);
	
	long countByWebsiteId(Long websiteId);
	
	
	List<WebsiteUrl> findByWebsiteIdAndUrlLike(Long websiteId, String urlLike, Pageable pageable);

	long countByWebsiteIdAndUrlLike(Long websiteId, String urlLike);
	
	List<WebsiteUrl> findByUrl(String url);
	
	@Modifying
	@Query("delete from WebsiteUrl u where u.id in ( ?1 )")
	void batchDelete(List<Long> ids);
	
	@Modifying
	@Query("delete from WebsiteUrl u where u.websiteId in ( ?1 )")
	void deleteUrlsByWebsiteId(List<Long> websiteIds);
}
