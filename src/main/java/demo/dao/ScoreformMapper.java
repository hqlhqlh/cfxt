package demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import demo.model.Scoreform;
@Mapper
public interface ScoreformMapper {
    int deleteByPrimaryKey(Integer scoreid);

    int insert(Scoreform record);

    int insertSelective(Scoreform record);

    Scoreform selectByPrimaryKey(Integer scoreid);

    int updateByPrimaryKeySelective(Scoreform record);
    @Select("select * from scoreform where idcard =  (#{idcard})")
    List<Scoreform> selectByIdcard(@Param("idcard")String idcard);
    
    int updateByPrimaryKey(Scoreform record);
    
    @Select("select * from scoreform where subject = '${subject}'")
    List<Scoreform> findListSubtsTpl(@Param("subject")String subject,@Param("testplace")String testplace);
		
	List<Scoreform> selectAll();

	
}