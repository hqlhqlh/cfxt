package demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import demo.dao.PassMapper;
import demo.model.Pass;
import demo.model.Sign;

@Service
public class PassService {
	@Autowired
	private PassMapper PassMapper;
	
	public int add(Pass Pass) {
		return PassMapper.insert(Pass);
	}   
	public int update(Pass Pass) {
        return PassMapper.updateByPrimaryKey(Pass);
    }
    public int delete(int pid) {
        return PassMapper.deleteByPrimaryKey(pid);
    }
    public Pass findOne(int pid) {
        return PassMapper.selectByPrimaryKey(pid);
    }
    
    public List<Pass> findList() {
        return PassMapper.findList();
    }

}
