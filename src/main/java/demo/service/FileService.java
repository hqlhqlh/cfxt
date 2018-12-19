package demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import demo.dao.FileMapper;
import demo.model.File;
import demo.model.Subjects;

@Service
public class FileService {
	@Autowired
	private FileMapper FileMapper;
	
	public int insert(File record) {
		return FileMapper.insert(record);		
	}
	
	public List<File> selectAll() {
        return FileMapper.findList();
    }
	public List<File> findListGROUPBYSubject() {
        return FileMapper.findListGROUPBYSubject();
    }
	
	public List<File> selectBySubject(String subject) {
        return FileMapper.selectBySubject(subject);
    }
}
