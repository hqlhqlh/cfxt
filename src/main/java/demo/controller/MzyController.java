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

import demo.model.Pass;
import demo.model.Sign;
import demo.model.User;
import demo.model.Subjects;
import demo.service.UserService;
import demo.service.SignService;
import demo.service.SubjectsService;
import demo.service.PassService;

/**
 * 缴费信息类
 * 
 * @author: MZY
 * @className: MzyController
 * @packageName: demo.controller
 **/
@Controller
@RequestMapping("")
public class MzyController {
	@Autowired
	SignService SignService;
	@Autowired
	UserService UserService;
	@Autowired
	SubjectsService SubjectsService;
	@Autowired
	PassService PassService;
	
	
	@RequestMapping("PayInfo")
	public String PayInfo(){
		return "PayInfo";
	}
	
	@RequestMapping("sGradeRevision")
	public String sGradeRevision(){
		return "sGradeRevision";
	}
	
	/**
	* 显示需要缴费的内容
	* 
	* @author:  MZY
	* @methodsName: PayInfo
	* @param:  request HttpServletRequest类，获取session
	* @param:  model 前台传参
	*/
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
	
	/**
	* 立即缴费
	* 
	* @author:  MZY
	* @methodsName: pay
	* @param:  signid 报名记录的id
	* @param:  model 前台传参
	*/
	@RequestMapping(value = "/pay", method = RequestMethod.POST)
	@ResponseBody
   	public String pay(Model model,@RequestParam(value = "signid") int signid){
		//System.out.println(signid + "...");
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
	/**
	* 显示所有学生考试成绩
	* 
	* @author:  MZY
	* @methodsName: sGradeRevision
	* @param:  model 前台传参
	*/	
	@RequestMapping(value = "/sGradeRevision", method = RequestMethod.GET)
   	public String sGradeRevision(Model model){
    	List<Pass> passList =  new ArrayList();
    	for(int i = 0;i<PassService.findList().size();i++){
    		Pass pass = PassService.findList().get(i);
    		passList.add(pass);
    	}
    	model.addAttribute("passList",passList);
    	return "sGradeRevision";
   	}
	/**
	* 修改某一考生的成绩
	* 
	* @author:  MZY
	* @methodsName: changeScore
	* @param:  newscore 心得成绩
	* @param:  pid pass表的id
	* @param:  model 前台传参
	*/
	@RequestMapping(value = "/changeScore", method = RequestMethod.POST)
	@ResponseBody
   	public String changeScore(Model model,HttpServletRequest request,
   			@RequestParam(value = "newscore") double newscore,
   			@RequestParam(value = "pid") int pid){
		
		System.out.println("11111");
    	List<Pass> passList =  new ArrayList();
    	for(int i = 0;i<PassService.findList().size();i++){
    		Pass pass = PassService.findList().get(i);
    		if(pass.getPid().equals(pid)){
    			System.out.println(pass.getScore());
    			System.out.println(newscore);
    			pass.setScore(newscore);
    			PassService.update(pass);
    			return "修改成功";
    		}
    	}
    	
    	return "修改失败";
   	}

}
