package demo.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import demo.dao.ExamMapper;
import demo.model.Exam;


@Service
public class ExamService {
	@Autowired
    private ExamMapper ExamMapper;
	
	 public int add(Exam Exam) {
	        return ExamMapper.insert(Exam);
	    }
	    public int update(Exam Exam) {
	        return ExamMapper.updateByPrimaryKey(Exam);
	    }
	    public int delete(int eid) {
	        return ExamMapper.deleteByPrimaryKey(eid);
	    }
	    public Exam findOne(int eid) {
	        return ExamMapper.selectByPrimaryKey(eid);
	    }
	   
	    public List<Exam> findList() {
	        return ExamMapper.findList();
	    }
	   
		
	    
	    
}