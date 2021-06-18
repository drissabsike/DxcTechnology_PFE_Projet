package com.DxcTechnology.controller;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.DxcTechnology.Entities.Equipe_projet;
import com.DxcTechnology.Entities.Tache;
import com.DxcTechnology.Repository.Equipe_projetRepository;
import com.DxcTechnology.Repository.TacheRepository;

@Controller
public class PlanEquipeController {

	@Autowired
	private Equipe_projetRepository EquipeService;
	
	@Autowired
	private TacheRepository tr;
	
	//PlanificationEquipe
	@RequestMapping("/MANAGER/PlanificationEquipe")
	public String showListProjets(Model model,HttpSession session,@Param(value = "titre_projet") String titre_projet) {
		String cin = (String) session.getAttribute("cin");
		if(cin==null) {
			return "redirect:/loginPage";
		}
		//System.out.println(titre_projet);
		List<Equipe_projet> ListT = EquipeService.ListTeam(titre_projet);
		String somme = EquipeService.SommeCharge(titre_projet);
		String SommeT = tr.getSum(titre_projet);
		if((somme==null)) {
			somme ="0"; 
		}
		if(SommeT==null) {
			SommeT="0";
		}
		List<Tache> ListTaches = EquipeService.listdesPhases(titre_projet);
		model.addAttribute("ListTaches",ListTaches);
		model.addAttribute("ListT",ListT);
		model.addAttribute("somme",somme);
		model.addAttribute("SommeT",SommeT);
		model.addAttribute("titre_projet",titre_projet);
		session.setAttribute("titre_projet", titre_projet);
		return "/MANAGER/PlanificationEquipe";
	}
	
}
