package com.oolong.adv;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.oolong.platform.domain.Domain;

/**
 * 广告订单-关联网站映射关系
 *
 * @author liumeng
 * @since 2014-1-9
 */
@Entity
@Table(name="T_ADV_WEBSITES") 
public class AdvWebsiteRelation extends Domain
{
	
	@Column(name="advId")
	private Long advId;
	
	@Column(name="websiteId")
	private Long websiteId;
	
	public AdvWebsiteRelation()
	{
		super();
	}
	
	public AdvWebsiteRelation(Long advId, Long websiteId)
	{
		super();
		this.advId = advId;
		this.websiteId = websiteId;
	}

	@Override
	public String toString()
	{
		return "AdvWebsiteRelation [advId=" + advId
				+ ", websiteId=" + websiteId + ", "
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

	public Long getWebsiteId()
	{
		return websiteId;
	}

	public void setWebsiteId(Long websiteId)
	{
		this.websiteId = websiteId;
	}
	
	
}
