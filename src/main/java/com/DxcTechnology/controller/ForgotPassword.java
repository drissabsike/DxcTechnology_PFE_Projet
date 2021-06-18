package com.DxcTechnology.controller;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.DxcTechnology.Entities.EncryptionDemo;
import com.DxcTechnology.Entities.User;
import com.DxcTechnology.Repository.UserRepository;
import com.DxcTechnology.Service.UserService;

@Controller
public class ForgotPassword {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private UserService userrMetier;
	
	@PostMapping("/process_pwd")
	public String LoginUser(User user,@RequestParam(value = "matricule") String matricule,
			@RequestParam(value = "pawssord1") String pawssord1) throws Exception {
		User x = userRepo.findUserBymatricule(matricule);
		String url = "";
		System.out.println("x is : "+x);
		if(x!=null){
			System.out.println("x!=null");
			String k = "Bar12345Bar12345";
	        //SecretKey key = KeyGenerator.getInstance("AES").generateKey();
	        SecretKey key = new SecretKeySpec(k.getBytes(), "AES");
	        EncryptionDemo encrypter = new EncryptionDemo(key);
	        String encrypted = encrypter.encrypt(pawssord1);
	        userrMetier.pwdUpdate(encrypted, matricule);
			url = "/ForgotPassword/pwd_success";
		}
		else{
			System.out.println("x==null");
			url = "/ErreursPages/Page407";
		}
		return url;
	}
	
	@RequestMapping("/Page407")
	public String ErreursPage407() {
		return "/ErreursPages/Page407";
	}

}
