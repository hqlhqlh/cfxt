package demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import demo.model.Invigilate;
@Mapper
public interface InvigilateMapper {
    int deleteByPrimaryKey(Integer invid);

    int insert(Invigilate record);

    int insertSelective(Invigilate record);

    Invigilate selectByPrimaryKey(Integer invid);

    int updateByPrimaryKeySelective(Invigilate record);

    int updateByPrimaryKey(Invigilate record);
    
    @Select("select * from invigilate")
    List<Invigilate> selectAll();
    
    
    
}