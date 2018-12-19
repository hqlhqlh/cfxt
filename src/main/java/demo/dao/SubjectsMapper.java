package demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import demo.model.Subjects;
@Mapper
public interface SubjectsMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(Subjects record);

    int insertSelective(Subjects record);

    Subjects selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(Subjects record);

    int updateByPrimaryKey(Subjects record);
    
    @Select("select * from subjects where subject = ${subject}")
    List<Subjects> selectBySubject(@Param("subject")String subject);
    
    @Select("select * from subjects")
    List<Subjects> findList();
}