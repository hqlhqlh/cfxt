package demo.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import demo.model.User;
import demo.service.FileService;
import demo.service.SubjectsService;
import demo.service.UserService;
import demo.util.MD5;

@Controller
@RequestMapping("")
public class StudentManager {
	@Autowired
    UserService UserService;
	@Autowired
    FileService FileService;
	@Autowired
    SubjectsService SubjectsService;
	
	@RequestMapping("chPwd")
   	public String ChPwd(){
   		return "changePasswd";
   	}
	@RequestMapping("perfectmsg")
	public String perfectmsg(){
	   	return "perfectmsg";
	}
	@RequestMapping(value = "/perfectmsg", method = RequestMethod.GET)
	public String perfect() {
		return "/perfectmsg";
	}	
	/*@Value("${FILE_PATH}")
	private String FILE_PATH;*/
	
	//显示我的信息页面的信息
	@RequestMapping(value = "/myinfo", method = RequestMethod.GET)
   	public String myinfo(Model model,HttpServletRequest request){
		int uid = (int)request.getSession().getAttribute("uid");
    	User user = UserService.findOne(uid);
    	model.addAttribute("user",user);
    	return "myinfo";
   	}
	
	//修改密码
	@RequestMapping(value = "/ChPwd", method = RequestMethod.POST)
	@ResponseBody
    public String ChPwd(Model model,HttpServletRequest request,
    		@RequestParam(value = "password", required = true) String password,
    		@RequestParam(value = "newpassword", required = true) String newpassword
    		)throws Exception  {
		int uid = (int)request.getSession().getAttribute("uid");
		for(int i=0;i<UserService.findList().size();i++){
    		User user = UserService.findList().get(i);
    		if(user.getUid().equals(uid)&&MD5.verify(password, user.getPassword())){
    			user.setPassword(MD5.md5(newpassword));
    			UserService.update(user);
    			return "修改成功";
    		}	
    	}
    	return "原密码错误";
    }
	
	//完善信息页面加入数据库
    @RequestMapping(value = "/perfectmsg", method = RequestMethod.POST) 
    public String perfect(Model model,HttpServletRequest request,
    		@RequestParam(value = "username") String username,
    		@RequestParam(value = "sex") String sex,
    		@RequestParam(value = "idcard") String idcard,
    		@RequestParam(value = "nation") String nation,
    		@RequestParam(value = "edu") String edu,
    		@RequestParam(value = "province") String province,
    		@RequestParam(value = "city") String city,
    		@RequestParam(value = "email") String email,
    		@RequestParam(value = "file-input") MultipartFile file,
    		@RequestParam(value = "filename") String photo
    		) throws Exception {
    	String nativeplace = province+city;   	
    	int uid =(int)request.getSession().getAttribute("uid");
    	if(!file.isEmpty()) {
    		try {
    			BufferedOutputStream out = new BufferedOutputStream(
						new FileOutputStream(new File("E:/myeclipseWorkspace/cfxt1.0/src/main/webapp/photo",file.getOriginalFilename())));
				out.write(file.getBytes());
				out.flush();
				out.close();
				//成功
				UserService.update2(uid,username,sex,idcard,nation,edu,nativeplace,email,photo);    	
		    	return "xs";
    		}catch(Exception e) {
				e.printStackTrace();
				model.addAttribute("errmsg","上传失败");
				return "perfectmsg";
			}
    	}else {
    		//空文件
    		model.addAttribute("errmsg","上传失败");
			return "perfectmsg";
    	}
    }
    /*public void downLoad(String filePath, HttpServletResponse response, boolean isOnLine) throws Exception {
        File f = new File(filePath);
        if (!f.exists()) {
            response.sendError(404, "File not found!");
            return;
        }
        BufferedInputStream br = new BufferedInputStream(new FileInputStream(f));
        byte[] buf = new byte[1024];
        int len = 0;

        response.reset(); // 非常重要
        if (isOnLine) { // 在线打开方式
            URL u = new URL("file:///" + filePath);
            response.setContentType(u.openConnection().getContentType());
            response.setHeader("Content-Disposition", "inline; filename=" + f.getName());
            // 文件名应该编码成UTF-8
        } else { // 纯下载方式
            response.setContentType("application/x-msdownload");
            response.setHeader("Content-Disposition", "attachment; filename=" + f.getName());
        }s
        OutputStream out = response.getOutputStream();
        while ((len = br.read(buf)) > 0)
            out.write(buf, 0, len);
        br.close();
        out.close();
    }*/
    //全部资料
    @RequestMapping(value = "/downloadData", method = RequestMethod.GET) 
    public String downloadData(Model model){
    	model.addAttribute("flgbslist",FileService.findListGROUPBYSubject());
    	model.addAttribute("sublist",SubjectsService.findList());
		return "download";
    }
    
    //筛选某科目资料
    @RequestMapping(value = "/downloadsub", method = RequestMethod.GET) 
    public String Download(Model model,@RequestParam(value = "sub") String subject){
    	model.addAttribute("flgbslist",FileService.selectBySubject(subject));
    	model.addAttribute("sublist",SubjectsService.findList());
		return "download";
    }
    
    @RequestMapping(value = "/downloadD", method = RequestMethod.GET)
    public void downloadD(HttpServletResponse response,HttpServletRequest request,
    		@RequestParam(value = "address") String address)throws Exception  {
    	try {
    		String path = "E:/myeclipseWorkspace/cfxt1.0/src/main/webapp/files/"+address;
            // path是指欲下载的文件的路径。
            File file = new File(path);
            // 取得文件名。
            String filename = file.getName();
            filename = URLEncoder.encode(filename,"UTF-8");
            // 取得文件的后缀名。
            String ext = filename.substring(filename.lastIndexOf(".") + 1).toUpperCase();

            // 以流的形式下载文件。
            InputStream fis = new BufferedInputStream(new FileInputStream(path));
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer);
            fis.close();
            // 清空response
            response.reset();
            // 设置response的Header
            response.addHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes()));
            response.addHeader("Content-Length", "" + file.length());
            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
            response.setContentType("application/octet-stream");
            toClient.write(buffer);
            toClient.flush();
            toClient.close();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
    
}
