package demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import demo.dao.SignMapper;
import demo.model.Sign;


@Service
public class SignService {
	@Autowired
    private SignMapper SignMapper;
	
	public int add(Sign Sign) {
		return SignMapper.insert(Sign);
	}   
	public int update(Sign Sign) {
        return SignMapper.updateByPrimaryKey(Sign);
    }
    public int delete(int signid) {
        return SignMapper.deleteByPrimaryKey(signid);
    }
    public Sign findOne(int signid) {
        return SignMapper.selectByPrimaryKey(signid);
    }
    
    public List<Sign> findList() {
        return SignMapper.findList();
    }
}