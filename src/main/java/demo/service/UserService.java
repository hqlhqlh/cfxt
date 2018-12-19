package demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import demo.dao.UserMapper;
import demo.model.User;


@Service
public class UserService {
	@Autowired
    private UserMapper UserMapper;
	
	 public int add(User User) {
	        return UserMapper.insert(User);
	    }
	    public int update(User User) {
	        return UserMapper.updateByPrimaryKey(User);
	    }
	    public int delete(int uid) {
	        return UserMapper.deleteByPrimaryKey(uid);
	    }
	    public User findOne(int uid) {
	        return UserMapper.selectByPrimaryKey(uid);
	    }
	    public User selectByPhone(String phone) {
	        return UserMapper.selectByPhone(phone);
	    }
	    public User selectByIdcard(String idcard) {
	        return UserMapper.selectByIdcard(idcard);
	    }
	    
	    public List<User> findList() {
	        return UserMapper.findList();
	    }
		
	    public int update2(int uid,String username, String sex, String idcard, String nation, String edu, String nativeplace,
				String email,String photo) {
			return UserMapper.update(uid, username, sex, idcard, nation, edu, nativeplace, email,photo);
			
		}
	
	    
}