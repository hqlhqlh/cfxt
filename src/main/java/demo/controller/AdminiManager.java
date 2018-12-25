package demo.controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
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
import demo.model.Subjects;
import demo.service.ExamService;
import demo.service.InvigilateService;
import demo.service.ScoreService;
import demo.service.SubjectsService;
import demo.service.UserService;
/**
 * 管理员的控制类
 * 
 * @author: HQL
 * @className: AdminiManager
 * @packageName: demo.controller;
 **/
@Controller	
@RequestMapping("")
public class AdminiManager {
	@Autowired
    ScoreService ScoreService;
	@Autowired
    UserService UserService;
	@Autowired
	InvigilateService InvigilateService;
	@Autowired
    SubjectsService SubjectsService;
	@Autowired
    ExamService ExamService;
	
	/**
	* subject和testPlace的二级联动方法 ，并将数据传至前台
	* 
	* @author:  HQL
	* @methodsName: subjectTestplace
	* @param:  model 前台传参
	*/
	public void subjectTestplace(Model model){
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
	}
	
	/**
	* admin的个人信息
	* 
	* @author:  HQL
	* @methodsName: admInfo
	* @param:  request HttpServletRequest对象，获取Session的值
	* @param:  model 前台传参
	*/	
	@RequestMapping(value = "AdminiInfo", method = RequestMethod.GET)
   	public String admInfo(HttpServletRequest request,Model model){
		int uid = (int)request.getSession().getAttribute("uid");
		model.addAttribute("user",UserService.findOne(uid));
   		return "AdminiInfo";
   	}
	
	/**
	* admin的主页
	* 
	* @author:  HQL
	* @methodsName: AdminMain
	* 
	*/	
	@RequestMapping(value = "AdminMain", method = RequestMethod.GET)
   	public String AdminMain(){
   		return "AdminMain";
   	}
	/**
	* 考试安排
	* 
	* @author:  HQL
	* @methodsName: Arrangement
	* @param:  model 前台传参
	*/
	@RequestMapping(value = "Arrangement", method = RequestMethod.GET)
   	public String Arrangement(Model model){
		subjectTestplace(model);//科目列表
		return "Arrangement";
   	}
	
	/**
	* 安排考试，准考证生成
	* 
	* @author:  HQL
	* @methodsName: Arr
	* @param:  subject 科目
	* @param:  testplace 考试地点
	* @param:  model 前台传参
	*/
	@RequestMapping(value = "Arr", method = RequestMethod.POST)
   	public String Arr(Model model,
   			@RequestParam(value = "subject") String subject,
   			@RequestParam(value = "school") String testplace){
		subjectTestplace(model);
		String [] t = testplace.split(",");
		testplace = t[0];
		List<Exam> ExamList= ExamService.findList();
		List<Exam> list= new ArrayList<Exam>();
		for(int i =0;i<ExamList.size();i++){
			/**
			 * 考试课目和考试地点进行比对
			 * 若一致则放入list中
			 */
			if(ExamList.get(i).getSubject().equals(subject)
					&&ExamList.get(i).getTestplace().equals(testplace)){
				list.add(ExamList.get(i));
			}
			
		}
		int room = 1;//设考场的初始值位1
		int seatnum = 1;//设座位号的初始值位1
		for(int i =0;i<list.size();i++){
			/**
			 * 讲数字改为3位数格式
			 */
			DecimalFormat decimalFormat = new DecimalFormat("000");
			String numFormatStr = decimalFormat.format(seatnum);
			list.get(i).setSeatnum(numFormatStr);
			
			seatnum++;
			/**
			 * 一个考场30个人，若大于30则到下一个考场，重置座位号为1
			 */
			if(seatnum>30){
				room += 1;
				seatnum=1;
			}
			
			DecimalFormat decimalFormat2 = new DecimalFormat("000");
			String numFormatStr2 = decimalFormat2.format(room);
			list.get(i).setRoomnum(numFormatStr2);
			
			String s1= (String) list.get(i).getIdcard().subSequence(0, 6);//截取身份证前6位
			
			String dateStr =new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(list.get(i).getTesttime());//获取考试日期，改为yyyy-MM-dd hh:mm:ss格式
			
			s1 = s1 + dateStr.subSequence(2, 4)+dateStr.subSequence(5, 7)
				+dateStr.subSequence(8, 9)+numFormatStr+numFormatStr2;//准考证为身份证前6位+考试日期的年份后二位+月份+加日期+考场号+座位号
			list.get(i).setExamnum(s1);
			ExamService.update(list.get(i));
		}
		model.addAttribute("examList", list);
		return "Arrangement";
   	}
	
	
	/**
	* admin添加用户
	* 
	* @author:  HQL
	* @methodsName: AddUser
	* @param:  model 前台传参
	*/
	@RequestMapping(value = "AddUser", method = RequestMethod.GET)
	public String AddUser(Model model){
		 return "AddUser";
	}
	/**
	* admin用户信息管理
	* 
	* @author:  HQL
	* @methodsName: AdinManagementUser
	* @param:  model 前台传参
	*/
	@RequestMapping(value = "AdminManagementUser", method = RequestMethod.GET)
	public String AdinManagementUser(Model model){
		 return "AdminManagementUser";
	}
	/**
	* admin修改用户信息
	* 
	* @author:  HQL
	* @methodsName: ChangeUseInfo
	*/	
	@RequestMapping(value = "ChangeUseInfo", method = RequestMethod.GET)
	public String ChangeUseInfo(){
		return "ChangeUseInfo";
	}	
	
	
}
