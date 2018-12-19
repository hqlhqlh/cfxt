package demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import demo.model.Information;
@Mapper
public interface InformationMapper {
    int deleteByPrimaryKey(Integer xid);

    int insert(Information record);

    int insertSelective(Information record);

    Information selectByPrimaryKey(int xid);

    int updateByPrimaryKeySelective(Information record);

    int updateByPrimaryKey(Information record);
    
    List<Information> selectAll();
    
    @Select("select * from information where xid =  (#{xid})")
	List<Information> selectByXid(@Param("xid")String xid);
    
    List<Information> selectBylimit(@Param("offset") int offset, @Param("limit") int limit);
    int selectcount();
}