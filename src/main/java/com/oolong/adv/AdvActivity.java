package com.oolong.adv;

/**
 *
 * @author liumeng
 * @since 2013-11-20
 */
public class AdvActivity
{
	private String company;
	
	private String advActivityName;
	
	private String linkman;
	
	private String linkmanPhone;
	
	private String description;

	@Override
	public String toString()
	{
		return "AdvActivity [company=" + company + ", advActivityName="
				+ advActivityName + ", linkman=" + linkman + ", linkmanPhone="
				+ linkmanPhone + ", description=" + description + "]";
	}

	public String getCompany()
	{
		return company;
	}

	public void setCompany(String company)
	{
		this.company = company;
	}

	public String getAdvActivityName()
	{
		return advActivityName;
	}

	public void setAdvActivityName(String advActivityName)
	{
		this.advActivityName = advActivityName;
	}

	public String getLinkman()
	{
		return linkman;
	}

	public void setLinkman(String linkman)
	{
		this.linkman = linkman;
	}

	public String getLinkmanPhone()
	{
		return linkmanPhone;
	}

	public void setLinkmanPhone(String linkmanPhone)
	{
		this.linkmanPhone = linkmanPhone;
	}

	public String getDescription()
	{
		return description;
	}

	public void setDescription(String description)
	{
		this.description = description;
	}
	
	
}
