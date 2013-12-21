package com.oolong.website;

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
 * 关联网站
 * 
 * 关联网站是一组网站地址的集合，在配置广告订单时，允许广告主选择关联网站
 * 
 * @author liumeng
 * @since 2013-12-07
 */
@Entity
@Table(name="T_WEBSITE") 
public class Website
{
	@Id  
    @GeneratedValue(strategy = GenerationType.AUTO)  
	private Long id;
	
	/** 关联网站名称，必需 */
	@NotNull
	@Size(min=1, max=100)
	@Pattern(regexp="[\u4e00-\u9fa5a-zA-Z0-9_-]{2,30}")
	@Column(name="websiteName")  
	private String websiteName;
	
	private long urlCount;
	
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
		return "Website [id=" + id + ", websiteName=" + websiteName
				+ ", urlCount=" + urlCount + ", description=" + description
				+ ", createTime=" + createTime + ", lastUpdateTime="
				+ lastUpdateTime + "]";
	}

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
	}

	public String getWebsiteName()
	{
		return websiteName;
	}

	public void setWebsiteName(String websiteName)
	{
		this.websiteName = websiteName;
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

	public long getLastUpdateTime()
	{
		return lastUpdateTime;
	}

	public void setLastUpdateTime(long lastUpdateTime)
	{
		this.lastUpdateTime = lastUpdateTime;
	}

	public long getUrlCount()
	{
		return urlCount;
	}

	public void setUrlCount(long urlCount)
	{
		this.urlCount = urlCount;
	}
	

}
