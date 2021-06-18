package com.DxcTechnology.controller;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import com.DxcTechnology.Entities.User;
import com.DxcTechnology.Repository.UserRepository;
import com.DxcTechnology.Service.UserService;

@Controller
public class ManagerController {


	@Autowired
	private UserService us;
	
	@RequestMapping("MANAGER/NouvProjet")
	public String showFormAddProjet() {
		return "/MANAGER/NouvProjet";
	}

	@RequestMapping("MANAGER/AddTeams")
	public String AddTeams(HttpSession session,Model model,@Param(value = "titre_projet") String titre_projet) {
		//System.out.println(titre_projet);
		model.addAttribute("titre_projet",titre_projet);
		session.setAttribute("titre_projet", titre_projet);
		return "/MANAGER/AddTeams";
	}
	
	@RequestMapping("/MANAGER/Profile")
	public String showFormProfile(HttpSession session,Model model,@Param(value = "cin") String cin,
			@Param(value = "nom1") String nom1,
			@Param(value = "prenom1") String prenom1) {
		String cin2 = (String) session.getAttribute("cin");
		if(cin2==null) {
			return "redirect:/loginPage";
		}
		User user = us.findUserByCIN(cin);
		model.addAttribute("user", user);
		return "/MANAGER/Profile";
	}
	
	@Autowired
	private UserRepository ur;
	///ADMIN/process_EditManager
	@RequestMapping("/MANAGER/process_EditManager")
	public String UpdateUser(User user,@RequestParam(value = "nom") String nom,HttpSession session,
			@RequestParam(value = "prenom") String prenom,
			@RequestParam(value = "cin") String cin,
			@RequestParam(value = "telephone") String telephone,
			@RequestParam(value = "email") String email,
			@RequestParam(value = "titre") String titre) throws IllegalStateException, IOException {
		System.out.println(cin);
		ur.UpdateUserwithCIN(nom, prenom, telephone, email, titre, cin, cin);
		return "/MANAGER/Profile";
	}


	@RequestMapping("/Erreur409")
	public String ErreursPage407() {
		return "/ErreursPages/Erreur409";
	}

	@RequestMapping("/MANAGER/AnnulerProjet")
	public String AnnulerProjet(@Param("id_projet") Long id_projet,HttpSession session, Model model) {
		String cin = (String) session.getAttribute("cin");
		if(cin==null) {
			return "redirect:/loginPage";
		}
		model.addAttribute("id_projet",id_projet);
		//projetMetier.changeStatutPojet((Long) id_projet);
		//session.setAttribute("id_projet", id_projet);
	return "/MANAGER/justification";
	}	

	@RequestMapping("/MANAGER/doLogout")
	public String doLogout(HttpServletRequest request,SessionStatus status) {	
		 HttpSession session = request.getSession(false);
		    if (session != null) {
		    	status.setComplete();
		        session.invalidate();
		    }
		    return "redirect:/loginPage"; 
	}
	

	
	
}


























