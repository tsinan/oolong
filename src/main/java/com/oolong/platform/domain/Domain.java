package com.oolong.platform.domain;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.MappedSuperclass;

/**
 * 域对象基类
 * 
 * @author liumeng
 * @since 2014-1-31
 */
@MappedSuperclass
@Inheritance(strategy = InheritanceType.JOINED)
public class Domain
{
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(name = "lastUpdateTime")
	private long lastUpdateTime;

	@Override
	public String toString()
	{
		return "id=" + id + ", lastUpdateTime=" + lastUpdateTime;
	}

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
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
