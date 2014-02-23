package com.oolong.platform.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;

/**
 * 
 * @author liumeng
 * @since 2014-1-12
 */
public class TextUtil
{
	/**
	 * 解析输入字符串，处理编码转换
	 * 
	 * @param inputText
	 * @return
	 */
	public static String parseTextFromInput(String inputText)
	{
		if (inputText == null)
		{
			return "";
		}
		
		return decodeURIComposite(inputText).trim();

//		String result = "";
//		try
//		{
//			result = new String(inputText.getBytes("iso-8859-1"), "utf-8");
//		}
//		catch (UnsupportedEncodingException e)
//		{
//			// do nothing...
//		}
//		return result.trim();
	}
	
	public static String encodeURIComposite(String toEncode)
	{
		String encoded = "";
		if(toEncode == null || toEncode.length() == 0)
		{
			return encoded;
		}
		
		try
		{
			encoded = URLEncoder.encode(toEncode, "UTF-8");
		}
		catch (UnsupportedEncodingException e)
		{
		}
		return encoded.trim();
	}
	
	public static String decodeURIComposite(String toDecode)
	{
		String decoded = "";
		if(toDecode == null || toDecode.length() ==0)
		{
			return decoded;
		}
		
		try
		{
			decoded = URLDecoder.decode(toDecode, "UTF-8");
		}
		catch (UnsupportedEncodingException e)
		{
		}
		return decoded.trim();
	}

	public static String buildLikeText(String inputText)
	{
		// 在页面encode两次，容器默认进行一次decode，所以此处只decode一次即可
		String parsedText = decodeURIComposite(inputText);
		if (parsedText.length() > 0)
		{
			return "%" + parsedText + "%";
		}
		else
		{
			return parsedText;
		}
	}

	/**
	 * @param page
	 * @param pageSize
	 * @param sortOrder
	 * @param sortColumn
	 * @param defaultSortColumn
	 * @return
	 */
	public static Pageable parsePageableObj(Integer page, Integer pageSize,
			String sortOrder, String sortColumn, String defaultSortColumn)
	{
		if(page == null)
		{
			page = Integer.valueOf(0);
		}
		
		if(pageSize == null)
		{
			pageSize = Integer.valueOf(15);
		}
		
		Direction direction = Direction.fromStringOrNull(sortOrder) != null ? Direction
				.fromString(sortOrder) : Direction.DESC;
				
		if(sortColumn != null && sortColumn.length() > 0)
		{
			return new PageRequest(page, pageSize, direction, sortColumn, defaultSortColumn);
		}
		else
		{
			return new PageRequest(page, pageSize, direction, defaultSortColumn);
		}
	}
	
	public static Date parseDateFromInput(String inputText)
	{
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-mm-dd");
		try
		{
			return sf.parse(inputText);
		}
		catch (ParseException e)
		{
			return null;
		}
	}
	
}
