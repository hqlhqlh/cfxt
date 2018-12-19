package demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import demo.model.File;
import demo.model.Subjects;
@Mapper
public interface FileMapper {
    int deleteByPrimaryKey(Integer fid);

    int insert(File record);

    int insertSelective(File record);

    File selectByPrimaryKey(Integer fid);

    int updateByPrimaryKeySelective(File record);

    int updateByPrimaryKey(File record);
    
    @Select("select * from file")
    List<File> findList();
    
    @Select("select * from file group by subject")
    List<File> findListGROUPBYSubject();
    
    @Select("select * from file where subject = '${subject}'")
    List<File> selectBySubject(@Param("subject")String subject);
}