package com.oolong.global;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import com.oolong.platform.domain.Domain;

/**
 * 免推送地址
 * 
 * @author liumeng
 * @since 2013-12-22
 */
@Entity
@Table(name = "T_FREEPUSH_URL")
public class FreePushUrl extends Domain
{
	/** 关联网站名称，必需 */
	@NotNull
	@Size(min = 1, max = 100)
	@Pattern(regexp = "[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?")
	@Column(name = "url")
	private String url;

	@Override
	public String toString()
	{
		return "WebsiteUrl [url=" + url + ", "+ super.toString() + "]";
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
