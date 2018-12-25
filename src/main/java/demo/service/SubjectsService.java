package demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import demo.dao.SubjectsMapper;
import demo.model.Subjects;


@Service
public class SubjectsService {
	@Autowired
    private SubjectsMapper SubjectsMapper;
	
	public int add(Subjects Subjects) {
		return SubjectsMapper.insert(Subjects);
	}   
	public int update(Subjects Subjects) {
        return SubjectsMapper.updateByPrimaryKey(Subjects);
    }
    public int delete(int sid) {
        return SubjectsMapper.deleteByPrimaryKey(sid);
    }
    public Subjects findOne(int sid) {
        return SubjectsMapper.selectByPrimaryKey(sid);
    }
    
    public List<Subjects> findList() {
        return SubjectsMapper.findList();
    }
    
    public List<Subjects> selectBySubject(String subject) {
        return SubjectsMapper.selectBySubject(subject);
    }
    public String selectBySubject2(String subject ) {
        return SubjectsMapper.selectBySubject2(subject);
    }
	public List<Subjects> selectAll() {
        return SubjectsMapper.findList();
    }
}