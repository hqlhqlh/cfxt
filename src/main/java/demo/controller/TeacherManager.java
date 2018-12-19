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
public class TeacherManager {
	@Autowired
    ExamService ExamService;
	@Autowired
    UserService UserService;
	@Autowired
	InvigilateService InvigilateService;
	
	@RequestMapping(value = "sInvigilatorInfo", method = RequestMethod.GET)
   	public String sInvigilatorInfo(HttpServletRequest request,Model model){
		String uid = (String)request.getSession().getAttribute("uid");
		List<Invigilate> InvigilateList = InvigilateService.findList();
		List<Invigilate> list = new ArrayList<Invigilate>();
		for(int i =0;i<InvigilateList.size();i++){
			Invigilate Invigilate = InvigilateList.get(i);
			if(uid.equals(Invigilate.getTeacher1id())||
					uid.equals(Invigilate.getTeacher2id())){
				list.add(Invigilate);
			}
		}
		model.addAttribute("list",list);
   		return "sInvigilatorInfo";
   	}
	
	@RequestMapping(value = "sSeatArrange", method = RequestMethod.GET)
   	public String sSeatArrange(HttpServletRequest request,Model model,
   			@RequestParam(value = "roomnum") String roomnum){
		List<Exam> ExamList = ExamService.findList();
		List<Exam> list = new ArrayList<Exam>();
		for(int i =0;i<ExamList.size();i++){
			Exam Exam = ExamList.get(i);
			if(roomnum.equals(Exam.getRoomnum())){
				User user = UserService.selectByIdcard(Exam.getIdcard());
				Exam.setRoomnum(user.getPhoto());
				Exam.setSubject(user.getSex());
				list.add(Exam);
			}
		}
		model.addAttribute("list",list);
   		return "sSeatArrange";
   	}
	
	@RequestMapping(value = "teacherInfo", method = RequestMethod.GET)
   	public String teacherInfo(HttpServletRequest request,Model model){
		int uid = (int)request.getSession().getAttribute("uid");
		model.addAttribute("user",UserService.findOne(uid));
   		return "teacherInfo";
   	}
	
	
    
}
