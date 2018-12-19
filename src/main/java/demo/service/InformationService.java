package demo.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import demo.dao.InformationMapper;
import demo.model.Information;



@Service
public class InformationService {
	@Autowired
	 private InformationMapper informationMapper;
	public List<Information> selectAll() {
        return informationMapper.selectAll();
    }
	public Information selectByXid(int xid) {
		// TODO Auto-generated method stub
		return informationMapper.selectByPrimaryKey(xid);
	}
	public List<Information> selectBylimit(@Param("offset") int offset, @Param("limit") int limit){
		return informationMapper.selectBylimit(offset, limit);
	}
	public int selectcount(){
		return informationMapper.selectcount();
	}
}
