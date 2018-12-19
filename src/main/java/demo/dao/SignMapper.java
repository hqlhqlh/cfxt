package demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import demo.model.Sign;
@Mapper
public interface SignMapper {
    int deleteByPrimaryKey(Integer signid);

    int insert(Sign record);

    int insertSelective(Sign record);

    Sign selectByPrimaryKey(Integer signid);

    int updateByPrimaryKeySelective(Sign record);

    int updateByPrimaryKey(Sign record);
    
    @Select("select * from sign")
    List<Sign> findList();
}