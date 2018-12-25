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
import demo.util.SendVerificationCode;
import org.apache.log4j.Logger;
/**
 * 用户登录注册控制类
 * 
 * @author: HQL
 * @className:
 * @packageName: demo.controller;
 **/
@Controller
@RequestMapping("")
public class UserController {
	
	private Logger log4j = Logger.getLogger(UserController.class);
	
	@Autowired
    UserService userService;
	
    @RequestMapping("login")
	public String login(){
		return "login";
	}
    @RequestMapping("reg")
	public String reg(){
		return "reg";
	}
    /**
	* 资源拦截
	* 
	* @author:  HQL
	* @methodsName: login
	* @param:  model 前台传参
	*/
    @RequestMapping("/Login")
	public String login(Model model,HttpServletRequest request){
		model.addAttribute("backnews",request.getSession().getAttribute("backnews"));
		return "login";
	}
    /**
   	* 管理员添加用户
   	* 
   	* @author:  HQL
   	* @methodsName: AddUser
   	* @param:  username 用户名
   	* @param:  password 密码
   	* @param:  phone 电话
   	* @param:  IDcard 身份证
   	* @param:  qx 权限
   	* @throws:　Exception
   	*/
    @RequestMapping(value = "/AddUser", method = RequestMethod.POST)
    public String addUser(Model model,HttpServletRequest request,
    		@RequestParam(value = "username", required = true) String username,
    		@RequestParam(value = "password", required = true) String password,
    		@RequestParam(value = "phone", required = true) String phone,
    		@RequestParam(value = "idcard", required = true) String idcard,
    		@RequestParam(value = "qx", required = true) int qx) throws Exception{
    	User user =new User();	
    	user.setPhone(phone);
    	user.setPassword(MD5.md5(password));
    	user.setUsername(username);
    	user.setIdcard(idcard);
    	user.setEmail("");
    	user.setSex("");
    	user.setNation("");
    	user.setNativeplace("");
    	user.setEdu("");
    	user.setPhoto("");
    	user.setStatus(qx);
    	userService.add(user);
		//model.addAttribute("backnews",request.getSession().getAttribute("backnews"));
		return "AddUser";
	}

    /**
	* 用户登录判断，并转向不同页面
	* 
	* @author:  HQL
	* @methodsName: login
	* @param:  phone 电话
	* @param:  password 密码
	* @param:  status 权限
	* @param:  model 前台传参
	* @throws:　Exception
	*/
    @RequestMapping(value = "/Login", method = RequestMethod.POST)
    public String login(Model model,HttpServletRequest request,
    		@RequestParam(value = "phone", required = true) String phone,
    		@RequestParam(value = "password", required = true) String password,
    		@RequestParam(value = "status", required = true) int status) throws Exception  {
    	/**
		 * 设置用户的session
		 */
    	HttpServletRequest httprequest = (HttpServletRequest)request;
		HttpSession session = httprequest.getSession();
		/**
		 * 与数据库比对，判断跳转的页面
		 */
    	for(int i=0;i<	userService.findList().size();i++){
    		User user = userService.findList().get(i);
    		if(user.getPhone().equals(phone)&&
    				MD5.verify(password, user.getPassword())&&
    				user.getStatus()==status){
    			session.setAttribute("uid",user.getUid());
    			session.setAttribute("userName",user.getUsername());
    			request.getSession().setAttribute("loginName",phone);
    			if(status==0){
    				String uidcard = user.getIdcard();
    				if(uidcard.equals("")||uidcard==null){
    					return "perfectmsg";
    				}
    				return "studentMain";
    			}else if(status==1){
    				return "teacherMain";
    			}else if(status==2){
    				return "AdminMain";
    			}
    		}	
    	}
    	model.addAttribute("errmsg","用户名或密码错误");
    	return "login";
    }
    /**
	* 注册时，发送手机验证码
	* 
	* @author:  HQL
	* @methodsName: regPhone
	* @param:  phone 电话
	*/
    @RequestMapping(value = "/RegPhone", method = RequestMethod.POST)
    @ResponseBody
    public String regPhone(@RequestParam(value = "phone") String phone) throws Exception {
    	for(int i=0;i<	userService.findList().size();i++){
    		User user = userService.findList().get(i);
    		if(user.getPhone().equals(phone)){
    			return "1";
    		}	
    	}
    	String s = SendVerificationCode.getCode(phone);
    	return s;
    }
    /**
	* 注册用户，加入数据库
	* 
	* @author:  HQL
	* @methodsName: regUser
	* @param:  phone 电话
	* @param:  password 密码
	* @throws：Exception
	*/
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
    	userService.add(user);
    	HttpServletRequest httprequest = (HttpServletRequest)request;
		HttpSession session = httprequest.getSession();
		session.setAttribute("uid",userService.selectByPhone(phone).getUid());
		return "1";
    }
    
}