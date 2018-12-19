package demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import demo.model.Pass;

@Mapper
public interface PassDAO {
    int deleteByPrimaryKey(Integer pid);

    int insert(Pass record);

    int insertSelective(Pass record);

    Pass selectByPrimaryKey(Integer pid);

    int updateByPrimaryKeySelective(Pass record);

    int updateByPrimaryKey(Pass record);
    @Select("select * from pass")
    List<Pass> findList();
}