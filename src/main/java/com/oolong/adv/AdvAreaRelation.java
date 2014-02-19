package com.oolong.adv;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.oolong.platform.domain.Domain;

/**
 * 广告订单-区域映射关系
 * 
 * @author liumeng
 * @since 2014-1-9
 */
@Entity
@Table(name = "T_ADV_AREAS")
public class AdvAreaRelation extends Domain
{

	@Column(name = "advId")
	private Long advId;

	@Column(name = "areaId")
	private Long areaId;

	public AdvAreaRelation()
	{
		super();
	}
	
	public AdvAreaRelation(Long advId, Long areaId)
	{
		super();
		this.advId = advId;
		this.areaId = areaId;
	}

	@Override
	public String toString()
	{
		return "AdvAreaRelation [advId=" + advId + ", areaId=" + areaId + ", "
				+ super.toString() + "]";
	}

	public Long getAdvId()
	{
		return advId;
	}

	public void setAdvId(Long advId)
	{
		this.advId = advId;
	}

	public Long getAreaId()
	{
		return areaId;
	}

	public void setAreaId(Long areaId)
	{
		this.areaId = areaId;
	}

}
