package com.oolong.adv;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import com.oolong.platform.domain.Domain;


/**
 * 广告活动
 * 
 * 类似于广告分类，先创建广告活动之后，才能够在活动下面创建广告订单
 * @author liumeng
 * @since 2013-11-20
 */
@Entity
@Table(name="T_ACTIVITY") 
public class Activity extends Domain
{
	/** 广告活动名称，必需 */
	@NotNull
	@Size(min=1, max=100)
	@Pattern(regexp="[\u4e00-\u9fa5a-zA-Z0-9_-]{2,30}")
	@Column(name="activityName",length=100)  
	private String activityName;
	
	/** 公司名 */
	@NotNull
	@Size(max=100)
	@Column(name="company",length=100)  
	private String company;
	
	@NotNull
	@Size(max=100)
	@Column(name="linkman",length=100)  
	private String linkman;
	
	@Size(max=100)
	@Column(name="linkmanPhone",length=100)  
	private String linkmanPhone;
	
	@Size(max=200)
	@Column(name="description")  
	private String description;

	@Column(name="createTime")  
	private long createTime;
	
	@Override
	public String toString()
	{
		return "Activity [company=" + company
				+ ", activityName=" + activityName + ", linkman=" + linkman
				+ ", linkmanPhone=" + linkmanPhone + ", description="
				+ description + ", createTime=" + createTime
				+ ", "+ super.toString() + "]";
	}

	public String getCompany()
	{
		return company;
	}

	public void setCompany(String company)
	{
		this.company = company.trim();
	}

	public String getActivityName()
	{
		return activityName;
	}

	public void setActivityName(String activityName)
	{
		this.activityName = activityName.trim();
	}

	public String getLinkman()
	{
		return linkman;
	}

	public void setLinkman(String linkman)
	{
		this.linkman = linkman.trim();
	}

	public String getLinkmanPhone()
	{
		return linkmanPhone;
	}

	public void setLinkmanPhone(String linkmanPhone)
	{
		this.linkmanPhone = linkmanPhone.trim();
	}

	public String getDescription()
	{
		return description;
	}

	public void setDescription(String description)
	{
		this.description = description.trim();
	}

	public long getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(long createTime)
	{
		this.createTime = createTime;
	}

	
}
