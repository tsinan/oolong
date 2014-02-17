package com.oolong.area;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.oolong.platform.domain.Domain;

/**
 * 区域IP地址段
 *  
 * @author liumeng
 * @since 2013-12-22
 */
@Entity
@Table(name = "T_AREA_IP")
public class IpSegment extends Domain
{
	@Column(name = "areaId")
	private Long areaId;

	/**
	 * ipToIp：起止地址
	 * ipMask：掩码段
	 */
	@NotNull
	@Size(min=1, max=10)
	@Column(name = "ipType",length=10)
	private String ipType;

	@NotNull
	@Size(min=1, max=100)
	@Column(name = "ipStartText",length=100)
	private String ipStartText;
	
	@NotNull
	@Min(1)
	@Max(32)
	@Column(name = "maskLength")
	private int maskLength;

	@Column(name = "ipStart")
	private long ipStart;
	
	@Column(name = "ipEnd")
	private long ipEnd;

	@Override
	public String toString()
	{
		return "IpSegment [areaId=" + areaId + ", ipType="
				+ ipType + ", ipStartText="
				+ ipStartText + ", maskLength=" + maskLength + ", ipStart="
				+ ipStart + ", ipEnd=" + ipEnd + ", "
						+ super.toString() + "]";
	}

	public Long getAreaId()
	{
		return areaId;
	}

	public void setAreaId(Long areaId)
	{
		this.areaId = areaId;
	}

	public String getIpType()
	{
		return ipType;
	}

	public void setIpType(String ipType)
	{
		this.ipType = ipType;
	}

	public String getIpStartText()
	{
		return ipStartText;
	}

	public void setIpStartText(String ipStartText)
	{
		this.ipStartText = ipStartText;
	}

	public int getMaskLength()
	{
		return maskLength;
	}

	public void setMaskLength(int maskLength)
	{
		this.maskLength = maskLength;
	}

	public long getIpStart()
	{
		return ipStart;
	}

	public void setIpStart(long ipStart)
	{
		this.ipStart = ipStart;
	}

	public long getIpEnd()
	{
		return ipEnd;
	}

	public void setIpEnd(long ipEnd)
	{
		this.ipEnd = ipEnd;
	}
		
	
}
