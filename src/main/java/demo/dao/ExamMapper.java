package demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import demo.model.Exam;
@Mapper
public interface ExamMapper {
    int deleteByPrimaryKey(Integer eid);

    int insert(Exam record);

    int insertSelective(Exam record);

    Exam selectByPrimaryKey(Integer eid);

    int updateByPrimaryKeySelective(Exam record);

    int updateByPrimaryKey(Exam record);
    
    @Select("select * from exam")
    List<Exam> findList();
}