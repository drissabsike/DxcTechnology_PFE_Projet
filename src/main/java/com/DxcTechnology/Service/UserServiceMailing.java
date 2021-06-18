package com.DxcTechnology.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.DxcTechnology.Entities.User;
import com.DxcTechnology.Repository.UserRepository;

@Service
@Transactional
public class UserServiceMailing {

	
	@Autowired
	private UserRepository userRepo;

	@SuppressWarnings("unused")
	@Autowired
	private JavaMailSender mailSender;
	
	public boolean verify(String activation_code) {
		User user = userRepo.findByVerivicationCode(activation_code);
		if(user == null) {
			return false;
		}else {
			System.out.println("userRepo.active");
			userRepo.active(activation_code);
			return true;
		}
		
	}
	
	
	
	
	
	
	
}
