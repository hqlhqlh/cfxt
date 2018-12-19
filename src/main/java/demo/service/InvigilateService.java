package demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import demo.dao.InvigilateMapper;
import demo.model.Invigilate;


@Service
public class InvigilateService {
	@Autowired
    private InvigilateMapper InvigilateMapper;
	
	public int add(Invigilate Invigilate) {
		return InvigilateMapper.insert(Invigilate);
	}   
	public int update(Invigilate Invigilate) {
        return InvigilateMapper.updateByPrimaryKey(Invigilate);
    }
    public int delete(int sid) {
        return InvigilateMapper.deleteByPrimaryKey(sid);
    }
    public Invigilate findOne(int sid) {
        return InvigilateMapper.selectByPrimaryKey(sid);
    }
    
    public List<Invigilate> findList() {
        return InvigilateMapper.selectAll();
    }
    
    
}