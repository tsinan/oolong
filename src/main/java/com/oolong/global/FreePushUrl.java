package com.oolong.global;

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
 * 免推送地址
 * 
 * @author liumeng
 * @since 2013-12-22
 */
@Entity
@Table(name = "T_FREEPUSH_URL")
public class FreePushUrl
{
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	/** 关联网站名称，必需 */
	@NotNull
	@Size(min = 1, max = 100)
	@Pattern(regexp = "[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?")
	@Column(name = "url")
	private String url;

	@Override
	public String toString()
	{
		return "WebsiteUrl [id=" + id + ", url=" + url + "]";
	}

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
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
