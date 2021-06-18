package com.DxcTechnology.controller;

import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.sql.Date;
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
import com.DxcTechnology.Entities.Equipe_projet;
import com.DxcTechnology.Entities.Projet;
import com.DxcTechnology.Entities.Tache;
import com.DxcTechnology.Entities.Tasks;
import com.DxcTechnology.Repository.Equipe_projetRepository;
import com.DxcTechnology.Repository.MemberEquipeRepository;
import com.DxcTechnology.Repository.TacheRepository;
import com.DxcTechnology.Repository.TasksRepository;
import com.DxcTechnology.Service.ProjetService;

@Controller
public class TacheController {
	
	@Autowired
	private TacheRepository tacheRepo;
	
	@Autowired
	private Equipe_projetRepository ep;
	
	@Autowired
	private ProjetService projetMetier;
	
	@Autowired
	private TasksRepository tsr;
	
	@Autowired
	private TacheRepository tr;
	
	@Autowired
	private MemberEquipeRepository mr;

	@RequestMapping("/MANAGER/NouvTache")
	public String showNouvTache(@Param(value = "id_projet") int id_projet,HttpSession session) {
		//System.out.println(id_projet);
		session.setAttribute("id_projet", id_projet);
	return "/MANAGER/NouvTache";
	}
	
	@RequestMapping("/MANAGER/EditPhase")
	public String EditPhase(Model model,@Param(value = "projet") String projet,@Param(value = "id_tache") Long id_tache) {
		//System.out.println(id_tache);
		model.addAttribute("id_tache",id_tache);
		Tache t = tr.FindTacheByid(id_tache);
		model.addAttribute("tache",t);
		model.addAttribute("projet",projet);
	return "/MANAGER/EditPhase";
	}
	
	//ListTaches
	@RequestMapping("/MANAGER/PlanCharge")
	public String showListTaches(Model model,HttpSession session) {
		String cin = (String) session.getAttribute("cin");
		if(cin==null) {
			return "redirect:/loginPage";
		}
		session.setAttribute("cin", cin);
		List<Projet> ListProjets = projetMetier.findBycin(cin);
		model.addAttribute("ListProjets",ListProjets);
		return "/MANAGER/PlanCharge";
	}
	
		static String printTheDay(String date1) {
			String tempDate = date1;
		    LocalDate date = LocalDate.parse(tempDate);
		    DayOfWeek day = date.getDayOfWeek();
			return day.toString();
		}
	
	@PostMapping("/MANAGER/process_create_tache")
	public String process_create_tache(@RequestParam(value = "titre_tache") String titre_tache,
			@RequestParam(value = "duree_t") int duree_t,
			@RequestParam(value = "percent_complete") int percent_complete,
			@RequestParam(value = "types_tache") String types_tache,
			@RequestParam(value = "statut_t") String statut_t,
			@RequestParam(value = "emp_nom") String emp_nom,
			@RequestParam(value = "DateMax") Date DateMax,
			@RequestParam(value = "id_projet") int id_projet,
			@RequestParam(value = "DateDebut") Date DateDebut,
			@RequestParam(value = "description") String description,Model model) throws IllegalStateException, IOException {
			//System.out.println(DateDebut);
			//System.out.println(DateMax);
		String msg = "";
		int chargeGlobale = mr.getChargeGlobale(emp_nom);
		int charge_task = duree_t;
		if(chargeGlobale==0) {
			Date dateMx1 = tacheRepo.getDatefin1ereTask(emp_nom);
			 msg ="La charge globale de l'employé "+emp_nom+" est égal à "+chargeGlobale+", jusqu'à: "+dateMx1;
		}if((charge_task>chargeGlobale) && (chargeGlobale!=0)) {
			 msg ="La charge global de l'employé "+emp_nom+" est "+chargeGlobale+" par jour, veuillez modifier La charge du task";
		}
		if(charge_task<=chargeGlobale) {
			int res = chargeGlobale-charge_task;
			mr.UpdateMmeberCharge(res, emp_nom);
		//System.out.println("charge global d'employe "+" "+emp_nom+": "+chargeGlobale);
Tache tache = new Tache(titre_tache, DateDebut, DateMax, id_projet, duree_t, statut_t, emp_nom, description, percent_complete, types_tache);
Tasks t = new Tasks(titre_tache, DateDebut, DateMax);
			tacheRepo.save(tache);
				tsr.save(t);
		msg = "Phase ajouté avec success";
		}
			model.addAttribute("success",msg);
			return "/MANAGER/NouvTache";
	}
	
	@PostMapping("/MANAGER/process_update_tache")
	public String process_update_tache(@RequestParam(value = "DateDebut") Date DateDebut,
			@RequestParam(value = "DateMax") Date DateMax,
			@RequestParam(value = "id_tache") Long id_tache,
			@RequestParam(value = "types_tache") String types_tache,
			@RequestParam(value = "emp_nom") String emp_nom,
			@RequestParam(value = "description") String description) throws IllegalStateException, IOException {
         	tacheRepo.TacheUpdate(emp_nom, description, types_tache, DateDebut, DateMax, id_tache);
			return "redirect:/MANAGER/EditPhase?id_tache="+id_tache;
	}
	
	@PostMapping("/MANAGER/process_TeamAdd")
	public String process_create_tache(Model model, @RequestParam(value = "Titre") String Titre,
			@RequestParam(value = "equipe") String equipe,
			@RequestParam(value = "jours") int jours,
			@RequestParam(value = "description") String description
			) throws IllegalStateException, IOException {
		//System.out.println(Titre+" "+equipe+" "+jours+" "+description);
		Equipe_projet e = new Equipe_projet(equipe, jours, Titre, description);
		ep.save(e);
		if(ep.save(e)!=null) {
			model.addAttribute("success","L'équipe a été ajouté avec succès");
		}
		return "/MANAGER/AddTeams";
	}

	
	@GetMapping("/MANAGER/PlanificationCharge")
	public String PlanificationCharge(HttpSession session,@Param(value = "key") Long key) {
		session.setAttribute("key", key);
		return "/MANAGER/PlanificationCharge";
	}	
	
}
