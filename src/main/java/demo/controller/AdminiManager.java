package demo.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import demo.model.Exam;
import demo.model.Invigilate;
import demo.model.User;
import demo.service.ExamService;
import demo.service.InvigilateService;
import demo.service.UserService;

@Controller	
@RequestMapping("")
public class AdminiManager {
	@Autowired
    ExamService ExamService;
	@Autowired
    UserService UserService;
	@Autowired
	InvigilateService InvigilateService;
	
	
	
	@RequestMapping(value = "AdminiInfo", method = RequestMethod.GET)
   	public String teacherInfo(HttpServletRequest request,Model model){
		int uid = 2;//(int)request.getSession().getAttribute("uid");
		model.addAttribute("user",UserService.findOne(uid));
   		return "AdminiInfo";
   	}
	
	
    
}
