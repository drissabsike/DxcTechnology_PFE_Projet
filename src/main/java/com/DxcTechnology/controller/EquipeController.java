package com.DxcTechnology.controller;

import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.DxcTechnology.Entities.Equipe;
import com.DxcTechnology.Repository.EquipeRepository;
import com.DxcTechnology.Service.EquipeService;

@Controller
public class EquipeController {

	@Autowired
	private EquipeService es;
	
	@Autowired
	private EquipeRepository er;
	
	@GetMapping("/Equipe/ListEquipe")
	public String showForgorPassword(Model model,HttpSession session) {
		String cin = (String) session.getAttribute("cin");
	       if(cin==null) {
				return "redirect:/loginPage";
			}
		List<Equipe> listE = es.listeEquipe();
		model.addAttribute("listE",listE);
		return "/MANAGER/Equipe/ListEquipe";
	}
	
	
	@GetMapping("/Equipe/NewTeams")
	public String showForgorPassword(HttpSession session) {
		String cin = (String) session.getAttribute("cin");
	       if(cin==null) {
				return "redirect:/loginPage";
			}
		return "/MANAGER/Equipe/NewTeams";
	}
	
	@PostMapping("/MANAGER/Equipe/process_NewAdd")
	public String CreationEquipe(Model model,@RequestParam(value = "nom_equipe") String nom_equipe,
			@RequestParam(value = "description") String description) {
		//System.out.println(nom_equipe);
		Equipe e = new Equipe();
			e.setNom_equipe(nom_equipe);
			e.setDescription(description);
			e.setDate_creation(new Date());
			er.save(e);
			if(er.save(e)!=null) {
				model.addAttribute("success","Équipe créée avec succès");
			}
		return "/MANAGER/Equipe/NewTeams";
	}
	
	@RequestMapping("/Equipe/DeleteTeam")
	public String DeleteTeam(@Param(value = "id") Long id) {
		//System.out.println(id);
		er.deleteById(id);
		return "redirect:/Equipe/ListEquipe";
	}
	
	
	
	
}
