package demo.controller;


import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import demo.model.Sign;
import demo.model.Subjects;
import demo.model.User;
import demo.service.SignService;
import demo.service.SubjectsService;
import demo.service.UserService;
@Controller
@RequestMapping("")
public class SignUpManage {
    
	@Autowired
    UserService UserService;
	@Autowired
    SubjectsService SubjectsService;
	@Autowired
	SignService SignService;
	
	//显示报名页面
	@RequestMapping("signUp")
	public String signUp(HttpServletRequest request,Model model){
		int uid = (int)request.getSession().getAttribute("uid"); 
		User user = UserService.findOne(uid);
    	model.addAttribute("user",user);
		//科目列表
		List<Subjects> SubjectsList = SubjectsService.findList();
		model.addAttribute("SubjectsList", SubjectsList);
		//考试地点的list放入listTestPlace的list中
		List<List<String>> listTestPlace = new ArrayList();
		for(int i=0;i <	SubjectsList.size();i++){
			Subjects subjects = SubjectsList.get(i);
			String[] subTextPlaceArr = subjects.getTestplace().split(",");
			List<String> subTestPlace = new ArrayList();
			for(int j=0;j<subTextPlaceArr.length;j++){
				subTestPlace.add(subTextPlaceArr[j]);
			}
			listTestPlace.add(subTestPlace);
    	}
		model.addAttribute("listTestPlace", listTestPlace);
		return "signUp";
	}
	
	//报名信息加入数据库
	@RequestMapping(value = "/Sign", method = RequestMethod.POST)
	@ResponseBody
	 public String Sign(Model model,HttpServletRequest request,
	    		@RequestParam(value = "subject", required = true) int subject,
	    		@RequestParam(value = "testplace", required = true) String testplace
	    		)throws Exception  {
		Date date = new Date();
		int uid = (int)request.getSession().getAttribute("uid");
		User user = UserService.findOne(uid);
		Subjects Subjects = SubjectsService.findOne(subject);
		
		//比较考试时间，考试前一天可报名，否则不可报名
		Calendar calendar = Calendar.getInstance();    
		calendar.setTime(Subjects.getTesttime());    
		calendar.add(Calendar.DAY_OF_WEEK, -1);
		if(date.compareTo(calendar.getTime())>=0){
			 return "1";
		};
		//比较用户IDcard和考试时间，重复则同一时间重复报名考试，返回
		List<Sign> signList =  SignService.findList();
		for(int i=0;i<signList.size();i++){
			if(signList.get(i).getIdcard().equals(user.getIdcard())
				&&signList.get(i).getTesttime().compareTo(Subjects.getTesttime())==0){
				return "2";
			}
		}
		//赋值并插入数据库
		Sign sign = new Sign();
		sign.setIdcard(user.getIdcard());
		sign.setSubject(Subjects.getSubject());
		sign.setTesttime(Subjects.getTesttime());
		sign.setTestplace(testplace);
		sign.setSigntime(date);
		sign.setPrice(Subjects.getPrice());
		sign.setStatus("0");
		SignService.add(sign);
	    return "3";
	 }
	
	//取消报名页面
    @RequestMapping(value = "/cancelSignUp", method = RequestMethod.GET) 
    public String cancelSignUp(Model model,HttpServletRequest request) {
    	int uid = (int)request.getSession().getAttribute("uid");
    	String idCard = UserService.findOne(uid).getIdcard();
    	List<Sign> signList =  SignService.findList();
    	List<Sign> usersignList =  new ArrayList();
    	Date date = new Date();
		for(int i=0;i<signList.size();i++){
			if(signList.get(i).getIdcard().equals(idCard)
				&&signList.get(i).getTesttime().compareTo(date)==1){
				usersignList.add(signList.get(i));
			}
		}
		model.addAttribute("usersignList", usersignList);
		return "cancelSignUp";
	}
   //取消报名
    @RequestMapping(value = "/cancel", method = RequestMethod.POST) 
    @ResponseBody
    public String cancel(Model model,@RequestParam(value = "signid") int signid,
    		HttpServletRequest request,HttpServletResponse response) throws IOException {
    	SignService.findOne(signid);
    	if(SignService.findOne(signid).getStatus().equals("1")){
    		return "对不起！已缴费，无法取消报名。";
    	}
    	SignService.delete(signid);
		return "取消成功";
	}
    
    
   //已报名信息页面
    @RequestMapping(value = "/signList", method = RequestMethod.GET) 
    public String signList(Model model,HttpServletRequest request) {
    	int uid = 1;//(int)request.getSession().getAttribute("uid");
    	String idCard = UserService.findOne(uid).getIdcard();
    	List<Sign> signList =  SignService.findList();
    	List<Sign> usersignList =  new ArrayList();
    	Date date = new Date();
		for(int i=0;i<signList.size();i++){
			if(signList.get(i).getIdcard().equals(idCard)
				&&signList.get(i).getTesttime().compareTo(date)==1){
				usersignList.add(signList.get(i));
			}
		}
		model.addAttribute("list", usersignList);
		return "signList";
	}
    
}