package demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import demo.dao.ScoreformMapper;
import demo.model.Scoreform;

@Service
public class ScoreService {
	@Autowired
	 private ScoreformMapper scoreformMapper;
	public int insert(Scoreform record) {
		return scoreformMapper.insert(record);		
	}
	public  List<Scoreform> selectByIdcard(String idcard) {
		return scoreformMapper.selectByIdcard(idcard);
       
    }
	public List<Scoreform> selectAll() {
        return scoreformMapper.selectAll();
    }
	public int add(Scoreform scoreform) {
		 return scoreformMapper.insert(scoreform);
		
	}
	
	 public List<Scoreform> findListSubtsTpl(String subject,String testplace) {
	        return scoreformMapper.findListSubtsTpl(subject, testplace);
	 }
}
