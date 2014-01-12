package com.oolong.adv;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 广告订单-关联网站映射关系
 *
 * @author liumeng
 * @since 2014-1-9
 */
@Entity
@Table(name="T_ADV_WEBSITES") 
public class AdvWebsiteRelation
{
	@Id  
    @GeneratedValue(strategy = GenerationType.AUTO)  
	private Long id;
	
	@Column(name="advId")
	private Long advId;
	
	@Column(name="websiteId")
	private Long websiteId;


	public AdvWebsiteRelation(Long advId, Long websiteId)
	{
		super();
		this.advId = advId;
		this.websiteId = websiteId;
	}

	@Override
	public String toString()
	{
		return "AdvWebsiteRelation [id=" + id + ", advId=" + advId
				+ ", websiteId=" + websiteId + "]";
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

	public Long getWebsiteId()
	{
		return websiteId;
	}

	public void setWebsiteId(Long websiteId)
	{
		this.websiteId = websiteId;
	}
	
	
}
