package com.oolong.global;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import com.oolong.platform.domain.Domain;
import com.oolong.platform.util.TimeUtil;

/**
 * 区域配置（全局配置）
 * 
 * @author liumeng
 * @since 2013-12-21
 */
@Entity
@Table(name = "T_GLOBALCONFIG")
public class GlobalConfig extends Domain
{
	// 间隔每_分钟推送
	@NotNull
	@Min(1)
	@Max(60)
	@Column(name = "pushInterval")
	private long pushInterval;

	// 每天最多推送_次
	@NotNull
	@Min(0)
	@Max(1440)
	@Column(name = "pushTimesPerDay")
	private long pushTimesPerDay;

	// 不限次数推送
	@NotNull
	@Column(name = "noLimitPushTimes")
	private boolean noLimitPushTimes;

	public static GlobalConfig buildDefaultGlobalConfig()
	{
		GlobalConfig globalConfig = new GlobalConfig();
		globalConfig.setPushInterval(5); // 默认5分钟
		globalConfig.setPushTimesPerDay(0); // 默认不限制
		globalConfig.setNoLimitPushTimes(true);
		globalConfig.setLastUpdateTime(TimeUtil.getServerTimeSecond());

		return globalConfig;
	}

	@Override
	public String toString()
	{
		return "GlobalConfig [pushInterval=" + pushInterval
				+ ", pushTimesPerDay=" + pushTimesPerDay
				+ ", noLimitPushTimes=" + noLimitPushTimes + ", "
				+ super.toString() + "]";
	}

	public long getPushInterval()
	{
		return pushInterval;
	}

	public void setPushInterval(long pushInterval)
	{
		this.pushInterval = pushInterval;
	}

	public long getPushTimesPerDay()
	{
		return pushTimesPerDay;
	}

	public void setPushTimesPerDay(long pushTimesPerDay)
	{
		this.pushTimesPerDay = pushTimesPerDay;
	}

	public boolean isNoLimitPushTimes()
	{
		return noLimitPushTimes;
	}

	public void setNoLimitPushTimes(boolean noLimitPushTimes)
	{
		this.noLimitPushTimes = noLimitPushTimes;
	}

}
