package com.oolong.area;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import com.oolong.platform.domain.Domain;

/**
 * 区域
 * 
 * @author liumeng
 * @since 2013-12-22
 */
@Entity
@Table(name = "T_AREA")
public class Area extends Domain
{

	/** 区域名称，必需 */
	@NotNull
	@Size(min = 1, max = 100)
	@Pattern(regexp = "[\u4e00-\u9fa5a-zA-Z0-9_-]{2,30}")
	@Column(name = "areaName", length = 100)
	private String areaName;

	@Transient
	private long ipCount;

	@Size(max = 200)
	@Column(name = "description")
	private String description;

	@Column(name = "createTime")
	private long createTime;

	@Override
	public String toString()
	{
		return "Area [areaName=" + areaName + ", ipCount=" + ipCount
				+ ", description=" + description + ", createTime=" + createTime
				+ ", " + super.toString() + "]";
	}

	public String getAreaName()
	{
		return areaName;
	}

	public void setAreaName(String areaName)
	{
		this.areaName = areaName;
	}

	public String getDescription()
	{
		return description;
	}

	public void setDescription(String description)
	{
		this.description = description;
	}

	public long getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(long createTime)
	{
		this.createTime = createTime;
	}
	
	public long getIpCount()
	{
		return ipCount;
	}

	public void setIpCount(long ipCount)
	{
		this.ipCount = ipCount;
	}

}
