package demo.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import demo.model.User;
import demo.service.UserService;
import demo.util.MD5;
import demo.util.SendVerificationCode;;

@Controller
@RequestMapping("")
public class UserController {
    
	@Autowired
    UserService UserService;
	
    @RequestMapping("login")
	public String login(){
		return "login";
	}
    @RequestMapping("reg")
	public String reg(){
		return "reg";
	}
    //资源拦截
    @RequestMapping("/Login")
	public String login(Model model,HttpServletRequest request){
		model.addAttribute("backnews",request.getSession().getAttribute("backnews"));
		return "login";
	}
    //用户登录判断，并转向不同页面
    @RequestMapping(value = "/Login", method = RequestMethod.POST)
    public String login(Model model,HttpServletRequest request,
    		@RequestParam(value = "phone", required = true) String phone,
    		@RequestParam(value = "password", required = true) String password,
    		@RequestParam(value = "status", required = true) int status) throws Exception  {
    	//设置用户的session
    	HttpServletRequest httprequest = (HttpServletRequest)request;
		HttpSession session = httprequest.getSession();
		
    	for(int i=0;i<	UserService.findList().size();i++){
    		User user = UserService.findList().get(i);
    		if(user.getPhone().equals(phone)&&
    				MD5.verify(password, user.getPassword())&&
    				user.getStatus()==status){
    			session.setAttribute("uid",user.getUid()); 
    			request.getSession().setAttribute("loginName",phone);
    			if(status==0){
    				String uidcard = user.getIdcard();
    				if(uidcard.equals("")||uidcard==null){
    					return "perfectmsg";
    				}
    				return "studentMain";
    			}else if(status==1){
    				return "ls";
    			}else if(status==2){
    				return "gly";
    			}
    		}	
    	}
    	model.addAttribute("errmsg","用户名或密码错误");
    	return "login";
    }
    
    //注册时，发送手机验证码
    @RequestMapping(value = "/RegPhone", method = RequestMethod.POST)
    @ResponseBody
    public String regPhone(@RequestParam(value = "phone") String phone) throws Exception {
    	for(int i=0;i<	UserService.findList().size();i++){
    		User user = UserService.findList().get(i);
    		if(user.getPhone().equals(phone)){
    			return "1";
    		}	
    	}
    	String s = SendVerificationCode.getCode(phone);
    	return s;
    }
    
    //注册用户，加入数据库
    @RequestMapping(value = "/RegUser", method = RequestMethod.POST)
    @ResponseBody
    public String regUser(HttpServletRequest request,
    		@RequestParam(value = "phone") String phone,
    		@RequestParam(value = "password") String password) throws Exception {
    	User user =new User();	
    	user.setPhone(phone);
    	user.setPassword(MD5.md5(password));
    	user.setUsername("");
    	user.setIdcard("");
    	user.setEmail("");
    	user.setSex("");
    	user.setNation("");
    	user.setNativeplace("");
    	user.setEdu("");
    	user.setPhoto("");
    	user.setStatus(0);
    	UserService.add(user);
    	HttpServletRequest httprequest = (HttpServletRequest)request;
		HttpSession session = httprequest.getSession();
		session.setAttribute("uid",UserService.selectByPhone(phone).getUid());
		return "1";
    }
    
}