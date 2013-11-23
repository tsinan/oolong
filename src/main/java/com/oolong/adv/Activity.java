package com.oolong.adv;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;


/**
 *
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

	@Override
	public String toString()
	{
		return "activity [company=" + company + ", activityName="
				+ activityName + ", linkman=" + linkman + ", linkmanPhone="
				+ linkmanPhone + ", description=" + description + "]";
	}

	public String getCompany()
	{
		return company;
	}

	public void setCompany(String company)
	{
		this.company = company;
	}

	public String getActivityName()
	{
		return activityName;
	}

	public void setActivityName(String activityName)
	{
		this.activityName = activityName;
	}

	public String getLinkman()
	{
		return linkman;
	}

	public void setLinkman(String linkman)
	{
		this.linkman = linkman;
	}

	public String getLinkmanPhone()
	{
		return linkmanPhone;
	}

	public void setLinkmanPhone(String linkmanPhone)
	{
		this.linkmanPhone = linkmanPhone;
	}

	public String getDescription()
	{
		return description;
	}

	public void setDescription(String description)
	{
		this.description = description;
	}

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
	}
	
	
}
