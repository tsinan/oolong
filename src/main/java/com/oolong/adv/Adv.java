package com.oolong.adv;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;


/**
 * 广告订单
 * 
 * 
 * @author liumeng
 * @since 2014-1-7
 */
@Entity
@Table(name="T_ADV") 
public class Adv
{
	@Id  
    @GeneratedValue(strategy = GenerationType.AUTO)  
	private Long id;
	
	/** 审核状态 draft:未审核;go:通过;redirect:未通过 */
	@Column(name="status",length=10)
	private String status;
	
	/** 广告活动ID */
	@NotNull
	@Column(name="activityId")  
	private Long activityId;
	
	/** 广告订单名称，必需 */
	@NotNull
	@Size(min=1, max=100)
	@Pattern(regexp="[\u4e00-\u9fa5a-zA-Z0-9_-]{2,30}")
	@Column(name="advName",length=100)  
	private String advName;
	
	/** 生效日期 */
	@NotNull
	@Size(min=1, max=10)
	@Column(name="startDate",length=10)
	private String startDate;
	
	/** 失效日期 */
	@NotNull
	@Size(min=1, max=10)
	@Column(name="endDate",length=10)
	private String endDate;
	
	/** 需求量CPM */
	@NotNull
	@Min(1)
	@Max(99999)
	@Column(name="cpm")
	private Long cpm;
	
	/** 优先级 */
	@NotNull
	@Min(1)
	@Max(9)
	@Column(name="priority")
	private Long priority;
	
	/** 广告物料类型 url：外部链接; file：上传文件 */
	@NotNull
	@Size(min=1, max=10)
	@Column(name="advType",length=10)
	private String advType;
	
	/** 外部URL地址 */
	@NotNull
	@Size(min=1, max=100)
	@Column(name="advUrl",length=100)
	private String advUrl;
	
	/** 上传文件路径 */
	@NotNull
	@Size(min=0, max=100)
	@Column(name="advFile",length=100)
	private String advFile;
		

	/** 推广类型 normal:普通; accurate:精准 */
	@NotNull
	@Size(min=1, max=10)
	@Column(name="spreadType",length=10)
	private String spreadType;
	
	/** 关联网站 1:N */
	@Transient
	private List<String> website;
	
	/** 推送范围 global:全局; area:分区域 */
	@NotNull
	@Size(min=1, max=10)
	@Column(name="scope",length=10)
	private String scope;
	
	/** 推送区域 1:N */
	@Transient
	private List<String> areas;
	
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
		return "Adv [id=" + id + ", status=" + status + ", activityId="
				+ activityId + ", advName=" + advName + ", startDate="
				+ startDate + ", endDate=" + endDate + ", cpm=" + cpm
				+ ", priority=" + priority + ", advType=" + advType
				+ ", advUrl=" + advUrl + ", advFile=" + advFile
				+ ", spreadType=" + spreadType + ", website=" + website
				+ ", scope=" + scope + ", areas=" + areas + ", description="
				+ description + ", createTime=" + createTime
				+ ", lastUpdateTime=" + lastUpdateTime + "]";
	}

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
	}

	public String getStatus()
	{
		return status;
	}

	public void setStatus(String status)
	{
		this.status = status;
	}

	public Long getActivityId()
	{
		return activityId;
	}

	public void setActivityId(Long activityId)
	{
		this.activityId = activityId;
	}

	public String getAdvName()
	{
		return advName;
	}

	public void setAdvName(String advName)
	{
		this.advName = advName;
	}

	public String getStartDate()
	{
		return startDate;
	}

	public void setStartDate(String startDate)
	{
		this.startDate = startDate;
	}

	public String getEndDate()
	{
		return endDate;
	}

	public void setEndDate(String endDate)
	{
		this.endDate = endDate;
	}

	public Long getCpm()
	{
		return cpm;
	}

	public void setCpm(Long cpm)
	{
		this.cpm = cpm;
	}

	public Long getPriority()
	{
		return priority;
	}

	public void setPriority(Long priority)
	{
		this.priority = priority;
	}

	public String getAdvType()
	{
		return advType;
	}

	public void setAdvType(String advType)
	{
		this.advType = advType;
	}

	public String getAdvUrl()
	{
		return advUrl;
	}

	public void setAdvUrl(String advUrl)
	{
		this.advUrl = advUrl;
	}
	

	public String getAdvFile()
	{
		return advFile;
	}

	public void setAdvFile(String advFile)
	{
		this.advFile = advFile;
	}

	public String getSpreadType()
	{
		return spreadType;
	}

	public void setSpreadType(String spreadType)
	{
		this.spreadType = spreadType;
	}

	public List<String> getWebsite()
	{
		return website;
	}

	public void setWebsite(List<String> website)
	{
		this.website = website;
	}

	public String getScope()
	{
		return scope;
	}

	public void setScope(String scope)
	{
		this.scope = scope;
	}

	public List<String> getAreas()
	{
		return areas;
	}

	public void setAreas(List<String> areas)
	{
		this.areas = areas;
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
	

}
