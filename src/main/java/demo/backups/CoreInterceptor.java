package demo.backups;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;


/**
 * 核心拦截器，配置request的一些初始值
 * @author WFT
 *
 */
public class CoreInterceptor implements HandlerInterceptor{
	
	/**
	 * @author WFT
	 * @return: 返回值为true 时就会继续调用下一个Interceptor的preHandle 方法
	 */
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		System.out.println("进入拦截器");
        if(request.getSession().getAttribute("loginName") == null){
        	request.getSession().setAttribute("backnews","您还没有登录哦（｡ò ∀ ó｡）");
        	System.out.println(request.getSession().getAttribute("backnews"));
    		response.sendRedirect("/Login");
    		return false;
        }
        
		return true;
	}
	/**
	 * @author WFT
	 * @return: 在请求处理之后，DispatcherServlet进行视图返回渲染之前进行调用，可以在这个方法中对Controller 处理之后的ModelAndView 对象进行操作。
	 */
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
	}
	/**
	 * 进行资源清理
	 * 
	 * @author WFT
	 */
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
	}


}
