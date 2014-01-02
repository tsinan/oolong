package com.oolong.website;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

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
public class WebsiteUrl
{
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(name = "websiteId")
	private Long websiteId;

	@NotNull
	@Column(name = "urlType")
	private int urlType;

	@Transient
	private String urlTypeName;

	/** 关联网站名称，必需 */
	@NotNull
	@Size(min = 1, max = 100)
	@Pattern(regexp = "[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?")
	@Column(name = "url")
	private String url;

	@Override
	public String toString()
	{
		return "WebsiteUrl [id=" + id + ", websiteId=" + websiteId
				+ ", urlType=" + urlType + ", url=" + url + "]";
	}

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
	}

	public Long getWebsiteId()
	{
		return websiteId;
	}

	public void setWebsiteId(Long websiteId)
	{
		this.websiteId = websiteId;
	}

	public int getUrlType()
	{
		return urlType;
	}

	public void setUrlType(int urlType)
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

	public String getUrlTypeName()
	{
		return urlTypeName;
	}

	public void setUrlTypeName(String urlTypeName)
	{
		this.urlTypeName = urlTypeName;
	}

}
