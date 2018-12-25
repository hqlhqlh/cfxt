package demo.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import demo.model.Exam;
import demo.model.Invigilate;
import demo.model.Scoreform;
import demo.model.Subjects;
import demo.model.User;
import demo.service.ExamService;
import demo.service.InvigilateService;
import demo.service.ScoreService;
import demo.service.SubjectsService;
import demo.service.UserService;
import demo.util.OutputReporting;
/**
 * 教师控制类
 * 
 * @author: HQL
 * @className:
 * @packageName: demo.controller;
 **/
@Controller	
@RequestMapping("")
public class TeacherManager {
	@Autowired
    ExamService ExamService;
	@Autowired
    UserService UserService;
	@Autowired
	InvigilateService InvigilateService;
	@Autowired
    SubjectsService SubjectsService;
	@Autowired
    ScoreService ScoreService;
	
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
	* 显示导出某学校的成绩页面
	* 
	* @author:  HQL
	* @methodsName: exportExcelpg
	* @param:  model 前台传参
	*/
	@RequestMapping(value = "exportExcelpg", method = RequestMethod.GET)
   	public String exportExcelpg(Model model){
		subjectTestplace(model);
		return "exportExcelpg";
   	}
	/**
	* 显示导出某学校的成绩
	* 
	* @author:  HQL
	* @methodsName: examlist
	* @param:  subject 考试科目
	* @param:  testplace 考试地点
	* @param:  model 前台传参
	*/
	@RequestMapping(value = "examlist", method = RequestMethod.POST)
   	public String examlist(Model model,@RequestParam(value = "subject") String subject,
   			@RequestParam(value = "school") String testplace){
		//System.out.print(subject+"111");
		List<Scoreform> Scoreform = ScoreService.findListSubtsTpl(subject,testplace);
		model.addAttribute("Scoreform", Scoreform);
		subjectTestplace(model);
		return "exportExcelpg";
   	}
	/**
	* 导出某学校的成绩
	* 
	* @author:  HQL
	* @methodsName: exportExcel
	* @param:  model 前台传参
	*/	
	@RequestMapping(value = "exportExcel", method = RequestMethod.POST)
   	public String exportExcel(HttpServletRequest request,Model model,
   			@RequestParam(value = "subject") String subject
   			,HttpServletResponse response) throws IOException{
		String testplace = "";
		List<Scoreform> List = ScoreService.findListSubtsTpl(subject,testplace);
		OutputReporting otp = new OutputReporting();
		HSSFWorkbook wb = new HSSFWorkbook();  
        HSSFSheet sheet =wb.createSheet("考试成绩");  
        HSSFRow row = null;  
  
        row = sheet.createRow(0);  
        row.setHeight((short)(26.25*20));  
        row.createCell(0).setCellValue("考试成绩列表");  
        row.getCell(0).setCellStyle(otp.getStyle(wb,0));//设置样式  
        for(int i = 1;i <= 3;i++){  
            row.createCell(i).setCellStyle(otp.getStyle(wb,0));  
        }  
        CellRangeAddress rowRegion = new CellRangeAddress(0,0,0,4);  
        sheet.addMergedRegion(rowRegion);  
  
        CellRangeAddress columnRegion = new CellRangeAddress(1,5,0,0);  
        sheet.addMergedRegion(columnRegion);  
        row = sheet.createRow(1);  
        row.createCell(0).setCellStyle(otp.getStyle(wb,3));  
        row.setHeight((short)(22.50*20));  
        row.createCell(1).setCellValue("姓名");  
        row.createCell(2).setCellValue("身份证");  
        row.createCell(3).setCellValue("科目"); 
        row.createCell(4).setCellValue("成绩");  
        for(int i = 1;i <= 4;i++){  
            row.getCell(i).setCellStyle(otp.getStyle(wb,1));  
        }  
        for(int i = 0;i<List.size();i++){  
        	row = sheet.createRow(i+2);  
        	Scoreform e = List.get(i);
        	row.createCell(1).setCellValue(e.getUsername());  
	            row.createCell(2).setCellValue(e.getIdcard());  
	            row.createCell(3).setCellValue(e.getSubject()); 
	            row.createCell(4).setCellValue(e.getScore());  
	            for(int j = 1;j <= 4;j++){  
	                row.getCell(j).setCellStyle(otp.getStyle(wb,2));  
	            }          	
        }
        //默认行高  
        sheet.setDefaultRowHeight((short)(16.5*20));  
        //列宽自适应  
        for(int i=0;i<=13;i++){  
            sheet.autoSizeColumn(i);  
        }  
        response.setContentType("application/vnd.ms-excel;charset=utf-8");  
        OutputStream os = response.getOutputStream();  
        wb.write(os);  
        os.flush();  
        os.close();  
		return "exportExcelpg";
   	}
	/**
	* 监考信息
	* 
	* @author:  HQL
	* @methodsName: sInvigilatorInfo
	* @param:  model 前台传参
	*/		
	@RequestMapping(value = "sInvigilatorInfo", method = RequestMethod.GET)
   	public String sInvigilatorInfo(HttpServletRequest request,Model model){
		int u = (int)request.getSession().getAttribute("uid");
		String uid = u+"";
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
	/**
	* 监考信息，显示考场考生信息
	* 
	* @author:  HQL
	* @methodsName: sSeatArrange
	* @param:  roomnum 考场
	* @param:  model 前台传参
	*/
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
	/**
	* 教师信息
	* 
	* @author:  HQL
	* @methodsName: teacherInfo
	* @param:  model 前台传参
	*/
	@RequestMapping(value = "teacherInfo", method = RequestMethod.GET)
   	public String teacherInfo(HttpServletRequest request,Model model){
		int uid = (int)request.getSession().getAttribute("uid");
		model.addAttribute("user",UserService.findOne(uid));
   		return "teacherInfo";
   	}
	/**
	* 教师主页
	* 
	* @author:  HQL
	* @methodsName: teacherMain
	*/
	@RequestMapping(value = "teacherMain", method = RequestMethod.GET)
   	public String teacherMain(){
   		return "teacherMain";
   	}
    
}
