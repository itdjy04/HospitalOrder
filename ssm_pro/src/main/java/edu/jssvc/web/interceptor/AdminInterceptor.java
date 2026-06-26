package edu.jssvc.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import edu.jssvc.entity.CommonUser;

/**
 * 管理员权限拦截器
 * 拦截 /admin/** 路径，检查用户是否已登录且为管理员
 *
 * @author itdjy
 * @date 2026年6月23日
 */
public class AdminInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		CommonUser userInfo = (CommonUser) request.getSession().getAttribute("userInfo");
		if (userInfo == null || userInfo.getIsAdmin() != 1) {
			response.sendRedirect(request.getContextPath() + "/admin/login");
			return false;
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
}
