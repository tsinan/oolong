package com.oolong.area;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

/**
 * 区域IP地址段
 *  
 * @author liumeng
 * @since 2013-12-22
 */
@Entity
@Table(name = "T_AREA_IP")
public class IpSegment
{
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(name = "areaId")
	private Long areaId;

	/**
	 * 1：起止地址
	 * 2：掩码段
	 */
	@NotNull
	@Column(name = "ipType")
	private int ipType;

	@Transient
	private String ipTypeName;

	@NotNull
	@Column(name = "ipStartText",length=100)
	private String ipStartText;
	
	@NotNull
	@Column(name = "maskLength")
	private int maskLength;

	@Column(name = "ipStart")
	private long ipStart;
	
	@Column(name = "ipEnd")
	private long ipEnd;

	@Override
	public String toString()
	{
		return "IpSegment [id=" + id + ", areaId=" + areaId + ", ipType="
				+ ipType + ", ipTypeName=" + ipTypeName + ", ipStartText="
				+ ipStartText + ", maskLength=" + maskLength + ", ipStart="
				+ ipStart + ", ipEnd=" + ipEnd + "]";
	}

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
	}

	public Long getAreaId()
	{
		return areaId;
	}

	public void setAreaId(Long areaId)
	{
		this.areaId = areaId;
	}

	public int getIpType()
	{
		return ipType;
	}

	public void setIpType(int ipType)
	{
		this.ipType = ipType;
	}

	public String getIpTypeName()
	{
		return ipTypeName;
	}

	public void setIpTypeName(String ipTypeName)
	{
		this.ipTypeName = ipTypeName;
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
