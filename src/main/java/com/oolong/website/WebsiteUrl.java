package com.oolong.website;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import com.oolong.platform.domain.Domain;

/**
 * 关联网站地址
 * 
 * 关联网站包含0-N个地址，地址有精确匹配、前缀匹配、包含匹配三种类型
 * 
 * @author liumeng
 * @since 2013-12-07
 */
@Entity
@Table(name = "T_WEBSITE_URL")
public class WebsiteUrl extends Domain
{
	@Column(name = "websiteId")
	private Long websiteId;

	/** accurate:精确匹配;prefix:前缀匹配;contain:包含匹配 */
	@NotNull
	@Size(min = 1, max = 10)
	@Column(name = "urlType", length = 10)
	private String urlType;

	/** URL，必需 */
	@NotNull
	@Size(min = 1, max = 100)
	@Pattern(regexp = "[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?")
	@Column(name = "url")
	private String url;

	@Override
	public String toString()
	{
		return "WebsiteUrl [websiteId=" + websiteId + ", urlType=" + urlType
				+ ", url=" + url + ", " + super.toString() + "]";
	}

	public Long getWebsiteId()
	{
		return websiteId;
	}

	public void setWebsiteId(Long websiteId)
	{
		this.websiteId = websiteId;
	}

	public String getUrlType()
	{
		return urlType;
	}

	public void setUrlType(String urlType)
	{
		this.urlType = urlType;
	}

	public String getUrl()
	{
		return url;
	}

	public void setUrl(String url)
	{
		this.url = url;
	}

}
