package demo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import demo.model.Scoreform;
import demo.model.User;
import demo.service.ScoreService;
import demo.service.UserService;

@Controller
@RequestMapping("")
public class ScoreController {
	@Autowired
    UserService UserService;
	@Autowired
    ScoreService scoreService;
   

  //显示我的成绩的信息
  	@RequestMapping(value = "/checkscore", method = RequestMethod.GET)
     	public String checkscore(Model model,HttpServletRequest request){
  		int uid = (int)request.getSession().getAttribute("uid");
  		//System.out.println("用户ID"+uid);
  		HttpServletRequest httprequest = (HttpServletRequest)request;
		HttpSession session = httprequest.getSession();
  		session.setAttribute("idcard",UserService.findOne(uid).getIdcard());
      	User user = UserService.findOne(uid);
      	String idcard = (String)request.getSession().getAttribute("idcard");
      	//System.out.println("身份证"+idcard);
      	List<demo.model.Scoreform> list = (List<Scoreform>) scoreService.selectByIdcard(idcard);	
//      	String [] subject = new String[list.size()];
//      	Date[]testtime = new Date[list.size()];
//      	double [] score = new double[list.size()];
      	//System.out.println(list);
      	model.addAttribute("list",list);
      	return "checkscore";
     	}
}
