package com.oolong.website;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import com.oolong.platform.domain.Domain;

/**
 * 关联网站
 * 
 * 关联网站是一组网站地址的集合，在配置广告订单时，允许广告主选择关联网站
 * 
 * @author liumeng
 * @since 2013-12-07
 */
@Entity
@Table(name = "T_WEBSITE")
public class Website extends Domain
{
	/** 关联网站名称，必需 */
	@NotNull
	@Size(min = 1, max = 100)
	@Pattern(regexp = "[\u4e00-\u9fa5a-zA-Z0-9_-]{2,30}")
	@Column(name = "websiteName", length = 100)
	private String websiteName;

	@Transient
	private long urlCount;

	@Size(max = 200)
	@Column(name = "description")
	private String description;

	@Column(name = "createTime")
	private long createTime;

	@Override
	public String toString()
	{
		return "Website [websiteName=" + websiteName + ", urlCount=" + urlCount
				+ ", description=" + description + ", createTime=" + createTime
				+ ", " + super.toString() + "]";
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

	public long getUrlCount()
	{
		return urlCount;
	}

	public void setUrlCount(long urlCount)
	{
		this.urlCount = urlCount;
	}

}
