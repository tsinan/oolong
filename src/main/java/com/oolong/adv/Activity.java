package com.oolong.adv;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;


/**
 * 广告活动
 * 
 * 类似于广告分类，先创建广告活动之后，才能够在活动下面创建广告订单
 * @author liumeng
 * @since 2013-11-20
 */
@Entity
@Table(name="T_ACTIVITY") 
public class Activity
{
	@Id  
    @GeneratedValue(strategy = GenerationType.AUTO)  
	private Long id;
	
	/** 公司名，必需 */
	@NotNull
	@Size(min=1, max=100)
	@Column(name="company")  
	private String company;
	
	/** 广告活动名称，必需 */
	@NotNull
	@Size(min=1, max=100)
	@Pattern(regexp="[\u4e00-\u9fa5a-zA-Z0-9_-]{2,30}")
	@Column(name="activityName")  
	private String activityName;
	
	@NotNull
	@Size(max=100)
	@Column(name="linkman")  
	private String linkman;
	
	@Size(max=100)
	@Column(name="linkmanPhone")  
	private String linkmanPhone;
	
	@Size(max=200)
	@Column(name="description")  
	private String description;

	@Column(name="createTime")  
	private long createTime;
	
	@Column(name="lastUpdateTime")
	private long lastUpdateTime;
	

	@Override
	public String toString()
	{
		return "Activity [id=" + id + ", company=" + company
				+ ", activityName=" + activityName + ", linkman=" + linkman
				+ ", linkmanPhone=" + linkmanPhone + ", description="
				+ description + ", createTime=" + createTime
				+ ", lastUpdateTime=" + lastUpdateTime + "]";
	}

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
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

	public long getLastUpdateTime()
	{
		return lastUpdateTime;
	}

	public void setLastUpdateTime(long lastUpdateTime)
	{
		this.lastUpdateTime = lastUpdateTime;
	}
	
	
}
