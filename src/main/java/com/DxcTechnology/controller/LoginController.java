package com.DxcTechnology.controller;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.DxcTechnology.Entities.EncryptionDemo;
import com.DxcTechnology.Entities.User;
import com.DxcTechnology.Repository.UserRepository;

@Controller
public class LoginController {
	
	@Autowired
	private UserRepository userRepo;

	@GetMapping("")
	public String viewHomePage() {
		return "/loginPage";
	}
	
	@GetMapping("loginPage")
	public String login() {
		return "/loginPage";
	}
	
	@RequestMapping("/process_login") 
	public String LoginUser(User user,Model model,HttpSession session,
			@RequestParam(value = "password") String password,
			@RequestParam(value = "email") String email) throws Exception {
			String k = "Bar12345Bar12345";
	        //SecretKey key = KeyGenerator.getInstance("AES").generateKey();
	        SecretKey key = new SecretKeySpec(k.getBytes(), "AES");
	        EncryptionDemo encrypter = new EncryptionDemo(key);
	        String encrypted = encrypter.encrypt(password);
	        
	        User x = userRepo.findByEmailandPass(email, encrypted);
	        String url = "/ErreursPages/Page404";
			System.out.println("x is the: "+x);
		if(x==null) {
			System.out.println("page404");
			return "/ErreursPages/Page404";
		}
        session.setAttribute("nom1",x.getNom());
		session.setAttribute("prenom1",x.getPrenom());
		session.setAttribute("cin",x.getCin());
		session.setAttribute("image_profile",x.getImage_path());
		
		if((x.getRole_user().equals("EMPLOYE")) && (x.getPassword().equals(encrypted))) {
			System.out.println("EMPLOYE");
			url = "redirect:/EMPLOYE/DashboardEmp";
		}
		if(x.getRole_user().equals("MANAGER") && (x.getPassword().equals(encrypted))) {
			System.out.println("MANAGER");
			url = "redirect:/MANAGER/DashboardMANAGER";
		}
		if(x.getRole_user().equals("ADMIN") && (x.getPassword().equals(encrypted))) {
			System.out.println("ADMIN");
			url = "redirect:/ADMIN/DashboardAdmin";
		}
		return url;
	}
	
}
