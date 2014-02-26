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
public interface IpSegmentRepository extends JpaRepository<IpSegment, Long>
{

	List<IpSegment> findByAreaId(Long areaId, Pageable pageable);

	long countByAreaId(Long areaId);
	
	@Query("select ip from IpSegment ip where ip.areaId = ?1 and ip.ipStart <= ?2 and ip.ipEnd >= ?2")
	List<IpSegment> findByAreaIdAndIpAddr(Long areaId, Long ipAddr, Pageable pageable);
	
	@Query("select count(ip) from IpSegment ip where ip.areaId = ?1 and ip.ipStart <= ?2 and ip.ipEnd >= ?2")
	long countByAreaIdAndIpAddr(Long areaId, Long ipAddr);

	@Query("select ip from IpSegment ip where (ip.ipStart <= ?1 and ip.ipEnd >= ?1) or (ip.ipStart <= ?2 and ip.ipEnd >= ?2) or (ip.ipStart > ?1 and ip.ipEnd < ?2)")
	List<IpSegment> findConflictsByIpAddress(long ipStart, long ipEnd);

	@Modifying
	@Query("delete from IpSegment i where i.id in ( ?1 )")
	void batchDelete(List<Long> ids);

	@Modifying
	@Query("delete from IpSegment i where i.areaId=?1")
	void deleteByAreaId(Long areaId);
}
