package demo.util;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import demo.backups.CoreInterceptor;

@Configuration
public class WebMvcConfig extends WebMvcConfigurerAdapter {
	

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		// TODO Auto-generated method stub
		/*registry.addViewController("/toLogin").setViewName("public/login");//页面跳转控制器
		super.addViewControllers(registry);*/
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new CoreInterceptor())
				.addPathPatterns("/**").excludePathPatterns("/login","/reg","/Login");
		super.addInterceptors(registry);
	}
	
	
}
