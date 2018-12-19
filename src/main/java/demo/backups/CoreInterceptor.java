package demo.backups;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;


/**
 * 核心拦截器，配置request的一些初始值
 * @author Simon
 *
 */
public class CoreInterceptor implements HandlerInterceptor{
	
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		
//		System.out.println("进入拦截器");
//		
//        if(request.getSession().getAttribute("loginName") == null){
//        	request.getSession().setAttribute("backnews","您还没有登录哦（｡ò ∀ ó｡）");
//        	System.out.println(request.getSession().getAttribute("backnews"));
//    		response.sendRedirect("/Login");
//    		return false;
//        }
//        
		return true;
	}

	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}


}
