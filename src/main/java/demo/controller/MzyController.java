package demo.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import demo.model.Sign;
import demo.model.User;
import demo.model.Subjects;
import demo.service.UserService;
import demo.service.SignService;
import demo.service.SubjectsService;


@Controller
@RequestMapping("")
public class MzyController {
	@Autowired
	SignService SignService;
	@Autowired
	UserService UserService;
	@Autowired
	SubjectsService SubjectsService;
	
	@RequestMapping("PayInfo")
	public String PayInfo(){
		return "PayInfo";
	}
	
	//显示需要缴费的内容
	@RequestMapping(value = "/PayInfo", method = RequestMethod.GET)
   	public String PayInfo(Model model,HttpServletRequest request){
		int uid = (int)request.getSession().getAttribute("uid");
    	User user = UserService.findOne(uid);
    	List<Sign> signList =  new ArrayList();
    	String idcard = user.getIdcard();
    	for(int i = 0;i<SignService.findList().size();i++){
    		Sign sign = SignService.findList().get(i);
    		if(sign.getIdcard().equals(idcard)){
    			//model.addAttribute("sign",sign);
    			Date tettime = sign.getTesttime();
				Calendar calendar = Calendar.getInstance();    
				calendar.setTime(tettime);    
				calendar.add(Calendar.DAY_OF_WEEK, -1);
				Date jiaofeitime = calendar.getTime();//获取一年前的时间，或者一个月前的时间   
				sign.setTesttime(jiaofeitime);
    			signList.add(sign);
    		}
    	}
    	
    	model.addAttribute("signList",signList);
    	return "PayInfo";
   	}
	
	
	//立即缴费
		@RequestMapping(value = "/pay", method = RequestMethod.POST)
		@ResponseBody
	   	public String pay(Model model,HttpServletRequest request,
	   			@RequestParam(value = "signid") int signid){
			System.out.println(signid + "...");
	    	for(int i = 0;i<SignService.findList().size();i++){
	    		Sign sign = SignService.findList().get(i);
	    		if(sign.getSignid().equals(signid)){
	    			//model.addAttribute("sign",sign);
	    			sign.setStatus("1");
	    			SignService.update(sign);
	    			return "缴费成功";
	    		}
	    	}
	    	
	    	return "缴费失败，重新缴费";
	   	}


}
