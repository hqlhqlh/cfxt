package demo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import demo.model.Information;
import demo.model.Scoreform;
import demo.model.User;
import demo.service.InformationService;
import demo.service.UserService;

@Controller
@RequestMapping("")
public class InformationController {
	@Autowired
    InformationService informationService;
	@RequestMapping("InfoNotice")
	public String InfoNotice(){
		return "InfoNotice";
	}
    @RequestMapping("InfoNoticeMore")
	public String InfoNoticeMore(){
    	
		return "InfoNoticeMore";
	}
    
    //显示信息标题
    @RequestMapping(value = "/xxtz", method = RequestMethod.GET)
 	public String myinfo(Model model,HttpServletRequest request){
    	List<demo.model.Information> list =informationService.selectAll();			
		model.addAttribute("list",list);
		
		//model.addAttribute("listSearch",listSearch);
		int pages = 5, first = 0;
		int page=1;
		int count = informationService.selectcount();
		int allpage=0;
		if(count%pages==0){
			allpage=count/pages;
		}else{
			allpage=count/pages+1;
		}
		int[] a = new int[allpage];
		for(int i = 0;i < allpage;i++){
			a[i] = i + 1;
			
		}
		model.addAttribute("page",page);
		model.addAttribute("allpage", allpage);
		List<demo.model.Information> list1 = informationService.selectBylimit(first, pages);
		model.addAttribute("list",list1 );
		model.addAttribute("a",a );
		
		return "InfoNotice";
 	} 
    
    @RequestMapping(value = "/checkmore", method = RequestMethod.GET)
 	public String checkmore(Model model,HttpServletRequest request,
 			@RequestParam(value = "xid") int xid)throws Exception{
    	System.out.println(xid);   	
    	Information list =informationService.selectByXid(xid);			
		model.addAttribute("list",list);		
		return "InfoNoticeMore";
 	} 
    
    @RequestMapping(value = "/said0")
    public String page(@RequestParam("ipage") String ipage, Model model) {
    	List<demo.model.Information> listSearch = informationService.selectAll();
		model.addAttribute("list",listSearch);
		int pages = 5, first = 0;
		int page=0;
		if(ipage==null||ipage.equals("")){
			page=0;
		}else if(ipage.equals("max")){
			System.out.println(1);
		}else{
			page=Integer.valueOf(ipage);
		}
		if (page == 1 || page == 0||ipage==null||ipage.equals("")) {
			first = 0;
		} else {
			first = pages * (page - 1);
		}
		int count = informationService.selectcount();
		//System.out.println(count);
		int allpage=0;
		if(count%pages==0){
			allpage=count/pages;
		}else{
			allpage=count/pages+1;
		}
		if(ipage.equals("max")){
			page=allpage;
			first = pages * (page - 1);
		}
		int[] a = new int[allpage];
		for(int i = 0;i < allpage;i++){
			a[i] = i + 1;
			
		}
		model.addAttribute("page",page);
		model.addAttribute("allpage", allpage);
		List<demo.model.Information> listSaid = informationService.selectBylimit(first, pages);
		model.addAttribute("list",listSaid );
		model.addAttribute("a",a );
		return "InfoNotice";
    }
}
