package demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import demo.model.User;
@Mapper
public interface UserMapper {
    int deleteByPrimaryKey(Integer uid);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer uid);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    @Select("select * from user where phone = ${phone}")
    User selectByPhone(@Param("phone")String phone);
    
    @Select("select * from user where idcard = ${idcard}")
    User selectByIdcard(@Param("idcard")String idcard);
    
    @Select("select * from user")
    List<User> findList();
    
    @Insert("update user set username =(#{username}),sex =(#{sex}),idcard =(#{idcard}),sex =(#{sex}),nation =(#{nation}),edu =(#{edu}),nativeplace =(#{nativeplace}),email =(#{email}) ,photo =(#{photo})  where uid = (#{uid})")
    int update(  @Param("uid") int uid,@Param("username") String username, @Param("sex") String sex,
    		@Param("idcard") String idcard,@Param("nation") String nation,
    		@Param("edu") String edu,
    		@Param("nativeplace") String nativeplace,@Param("email") String email,@Param("photo") String photo);

}