package demo.backups;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import demo.cfxtApplication;
public class log4 {
	private static Logger log = LogManager.getLogger(cfxtApplication.class);
	public void testLog(){
		log.debug("debug");
		log.error("error");
		System.out.println("日志管理");
		
	}
	
}
