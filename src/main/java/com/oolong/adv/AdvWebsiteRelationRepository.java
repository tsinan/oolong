package com.oolong.adv;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author liumeng
 * @since 2014-1-12
 */
public interface AdvWebsiteRelationRepository extends JpaRepository<AdvWebsiteRelation,Long>
{
	List<AdvWebsiteRelation> findByAdvId(Long advId);
}
