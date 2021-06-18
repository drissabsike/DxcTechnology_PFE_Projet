package com.DxcTechnology.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.DxcTechnology.Entities.MembreEquipe;
import com.DxcTechnology.Repository.MemberEquipeRepository;

@Controller
public class MemberEquipeControlelr {
	
	@Autowired
	private MemberEquipeRepository emr;

	@RequestMapping("/Equipe/AddMember")
	public String GotoAddMember(Model model,@Param(value = "nom_equipe") String nom_equipe) {
		model.addAttribute("nom_equipe",nom_equipe);
	return "/MANAGER/Equipe/AddMember";
	}
	
	@PostMapping("/MANAGER/Equipe/process_Add_Member")
	public String AddMember(Model model,MembreEquipe me,@RequestParam(value = "nom_equipe") String nom_equipe,
			@RequestParam(value = "employe") String employe) throws IllegalStateException, IOException {
		String msg =  "";
		me.setTeam_name(nom_equipe);
		me.setEmploye(employe);
		me.setChargeJour(8);
		me.setDate_creation(new Date());
		MembreEquipe m = emr.getMember(employe);
		if(m!=null) {
			msg = "L'employé est déjà intégré à l'équipe "+m.getTeam_name();
		}
		if(m==null){
		emr.save(me);
		msg = "Le membre a été ajouté avec succès";
		}
		model.addAttribute("success",msg);
		model.addAttribute("nom_equipe",nom_equipe);
		return "/MANAGER/Equipe/AddMember";
	}
	
	@RequestMapping("/Equipe/ListMemberEquipe")
	public String ShowListTeams(Model model,@RequestParam(value = "nom_equipe") String nom_equipe) {
		List<MembreEquipe> listMember = emr.listMembreEquipeByTeam(nom_equipe);
		model.addAttribute("listMember",listMember);
		model.addAttribute("nom_equipe",nom_equipe);
		return "/MANAGER/Equipe/ListMemberEquipe";
	}

	@RequestMapping("/Equipe/ListAllMember")
	public String ShowListMembers(Model model) {
		List<MembreEquipe> listMember = emr.findAll();
		model.addAttribute("listMember",listMember);
		return "/MANAGER/Equipe/ListAllMember";
	}
	
}






