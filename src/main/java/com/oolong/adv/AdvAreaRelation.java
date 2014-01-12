package com.oolong.adv;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 广告订单-区域映射关系
 * 
 * @author liumeng
 * @since 2014-1-9
 */
@Entity
@Table(name="T_ADV_AREAS") 
public class AdvAreaRelation
{
	@Id  
    @GeneratedValue(strategy = GenerationType.AUTO)  
	private Long id;
	
	@Column(name="advId")
	private Long advId;
	
	@Column(name="areaId")
	private Long areaId;

	public AdvAreaRelation(Long advId, Long areaId)
	{
		super();
		this.advId = advId;
		this.areaId = areaId;
	}

	@Override
	public String toString()
	{
		return "AdvAreaRelation [id=" + id + ", advId=" + advId + ", areaId="
				+ areaId + "]";
	}

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
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
