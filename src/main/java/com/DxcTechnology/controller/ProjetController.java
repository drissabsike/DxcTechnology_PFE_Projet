package com.DxcTechnology.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.DxcTechnology.Entities.Justification;
import com.DxcTechnology.Entities.Projet;
import com.DxcTechnology.Repository.JustificationRepository;
import com.DxcTechnology.Repository.ProjetRepository;
import com.DxcTechnology.Service.JusificationService;
import com.DxcTechnology.Service.ProjetService;

@Controller
public class ProjetController {
	
	@Autowired
	private ProjetService projetMetier;
	
	@Autowired
	private ProjetRepository projetRepo;
	
	@Autowired
	private JustificationRepository justificationService;
	
	//show_Justification
	@Autowired
	private JusificationService js;
	
	@RequestMapping("/MANAGER/ListProjets")
	public String showListProjets(Model model,HttpSession session) {
		String cin = (String) session.getAttribute("cin");
		if(cin==null) {
			return "redirect:/loginPage";
		}
		List<Projet> ListProjets = projetMetier.findBycin(cin);
		model.addAttribute("ListProjets",ListProjets);
		return "/MANAGER/ListProjets";
	}
	
	@RequestMapping("/MANAGER/ListProjets_annuler")
	public String showListProjets_annuler(Model model,HttpSession session) {
		String cin = (String) session.getAttribute("cin");
		if(cin==null) {
			return "redirect:/loginPage";
		}
		List<Projet> ListProjets = projetMetier.findPAnuulerBycin(cin);
		model.addAttribute("ListProjets",ListProjets);
		return "/MANAGER/ListProjets_annuler";
	}
	
	
	
	@PostMapping("/MANAGER/process_create_project")
	public String create_project(Projet projet,@RequestParam(value = "titre_projet") String titre_projet,
			@RequestParam(value = "cin_Manager") String cin_Manager,
			@RequestParam(value = "DateDebut") java.sql.Date DateDebut,
			@RequestParam(value = "DateFin") java.sql.Date DateFin,
			@RequestParam(value = "budget_projet") int budget_projet,
			@RequestParam(value = "avance") int avance,
			@RequestParam(value = "description") String description,
			@RequestParam(value = "client") String client,
			@RequestParam(value = "percent_complete") int percent_complete,
			@RequestParam(value = "file") MultipartFile file) throws IllegalStateException, IOException {
		String k = projetRepo.FindByProjectName(titre_projet);
        System.out.println(k);
		if(k!=null) {
			return "/ErreursPages/Erreur409";
        }else {
		String Uid = UUID.randomUUID().toString();
        @SuppressWarnings("unused")
		String code = Uid.substring(0, 6);
        String timeStamp = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss").format(Calendar.getInstance().getTime());
        System.out.println(timeStamp);
        String file_path ="D:\\DXC\\Projet\\DxcTechnology-1_V14\\DxcTechnology-1\\src\\main\\webapp\\WEB-INF\\views\\upload\\";
		file.transferTo(new File(file_path+"Cahier_de_charge_"+timeStamp+"_de_"+client+".docx"));
		projet.setTitre_projet(titre_projet);
		projet.setCin_Manager(cin_Manager);
		projet.setDateDebut(DateDebut);
		projet.setDateFin(DateFin);
		projet.setBudget_projet(budget_projet);
		projet.setAvance(avance);
		projet.setDescription(description);
		projet.setClient(client);
		projet.setEtat_projet("Non_Annuler");
		projet.setPercent_complete(percent_complete);
		projet.setFile_path(file_path);
		projet.setDate_creation(new Date());
		projetRepo.save(projet);
        }
		return "redirect:/MANAGER/ListProjets";
	}
	
	@RequestMapping("/MANAGER/Confirmer_Projet")
	public String ConfimerProjet(@Param("id_projet") Long id_projet,HttpSession session) {
		String cin = (String) session.getAttribute("cin");
		if(cin==null) {
			return "redirect:/loginPage";
		}
		projetMetier.changeStatutPojet2((Long) id_projet);
		justificationService.deleteJustification(id_projet);
	return "redirect:/MANAGER/ListProjets";
	}

	@RequestMapping("/MANAGER/process_justification")
	public String process_justification(Justification just, @RequestParam(value = "id_projet") Long id_projet,
			@RequestParam(value = "Justification") String justification) throws IllegalStateException, IOException {
			projetMetier.changeStatutPojet((Long) id_projet);
			just.setRef_id_projet(id_projet);
			just.setJustification(justification);
			just.setDate_creation(new Date());
			justificationService.save(just);
		return "redirect:/MANAGER/ListProjets_annuler";
	} 
		
	@RequestMapping("/MANAGER/show_Justification")
	public String show_Justification(Model model, @Param("id_projet") Long id_projet,HttpSession session) {
		String cin = (String) session.getAttribute("cin");
		if(cin==null) {
			return "redirect:/loginPage";
		}
		//System.out.println(id_projet);
		String jus = js.justifiaction(id_projet);
		model.addAttribute("jus",jus);
	return "/MANAGER/justification_2";
	}

	
	
}
