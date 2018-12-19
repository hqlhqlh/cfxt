package demo.util;
 

import java.net.URLEncoder;
 

public class SendVerificationCode {
	
	private static String operation = "/industrySMS/sendSMS";
	private static String accountSid = Config.ACCOUNT_SID;
	private static String to = "";
	private static String smsContent = smsCode();
	private static String n = "2";
	// 根据相应的手机号发送验证码
	public static String getCode(String phone){	
		to = phone;
		String tmpSmsContent = "【超方系统】尊敬的用户，您好，您的验证码为：" + smsContent + ",请于"+n+"分钟内正确输入,如非本人操作,请忽略此短信。";
	    try{
	      tmpSmsContent = URLEncoder.encode(tmpSmsContent, "UTF-8");
	    }catch(Exception e){
	      e.printStackTrace();
	    }
	    String url = Config.BASE_URL + operation;
	    String body = "accountSid=" + accountSid + "&to=" + to + "&templateid=999259897&param="+smsContent+","+n+""
	        + HttpUtil.createCommonParam();

	    // 提交请求
	    String result = HttpUtil.post(url, body);
	    //System.out.println("result:" + System.lineSeparator() + result);
	    return smsContent;
	}

	// 创建验证码
	public static String smsCode() {
		String random = (int) ((Math.random() * 9 + 1) * 100000) + "";
		return random;
	}
	
}

