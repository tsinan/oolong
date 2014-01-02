package com.oolong.util;

import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 *
 * @author liumeng
 * @since 2013-12-30
 */
public class IpUtil
{

	/**
	 * 转换字符串格式IP地址为Long型
	 * 
	 * @param ipAddressText
	 * @return
	 */
	public static long convertIpAddressFromText(String ipAddressText)
	{
		long address = 0;
		
		byte[] addr;
		try
		{
			addr = InetAddress.getByName(ipAddressText).getAddress();
		}
		catch (UnknownHostException e)
		{
			throw new RuntimeException(e);
		}
		address  = addr[3] & 0xFF;
        address |= ((addr[2] << 8) & 0xFF00);
        address |= ((addr[1] << 16) & 0xFF0000);
        address |= ((addr[0] << 24) & 0xFF000000);
		
		return address;
	}
	
	/**
	 * 计算起止IP地址
	 * 
	 * @param ip
	 * @param maskLength
	 * @return
	 */
	public static long[] computeIpAddressByMask(String ip, int maskLength)
	{
		long[] address = {0,0};
		
		// 根据掩码长度计算掩码地址
		long mask = (0xFFFFFFFF << (32 - maskLength)) & 0xFFFFFFFF;

		// 转换为Long型
		long ipLong = convertIpAddressFromText(ip);
		
		long ipStart = (ipLong & mask) & 0xFFFFFFFF;
		long ipEnd = (ipStart | (0xFFFFFFFF ^ mask)) & 0xFFFFFFFF ;
		
		address[0] = ipStart;
		address[1] = ipEnd;
		return address;
	}
}
