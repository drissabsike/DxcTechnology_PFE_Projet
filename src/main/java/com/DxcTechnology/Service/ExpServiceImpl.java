package com.DxcTechnology.Service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DxcTechnology.Entities.Experiance;
import com.DxcTechnology.Repository.ExperianceRepository;

@Service
public class ExpServiceImpl implements ExperianceService {

	@Autowired
	private ExperianceRepository ExpService;
	
	public List<Experiance> ListeDexp() {
		return  (List<Experiance>) ExpService.findAll();
	}

}
