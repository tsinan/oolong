package com.oolong.platform.web;
//package com.oolong.web;
//
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import com.oolong.web.exception.UnknownResourceException;
//
//import javax.servlet.http.HttpServletRequest;
//
///**
// * Default controller that exists to return a proper REST response for unmapped
// * requests.
// */
//@Controller
//public class DefaultController
//{
//
//	@RequestMapping("/**")  // 这里需要通过content-type或者其他手段排除css等非json资源
//	public void unmappedRequest(HttpServletRequest request)
//	{
//		String uri = request.getRequestURI();
//		throw new UnknownResourceException("There is no resource for path "
//				+ uri);
//	}
//}
