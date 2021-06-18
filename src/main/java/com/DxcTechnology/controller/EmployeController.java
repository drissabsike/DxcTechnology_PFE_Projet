package com.DxcTechnology.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import com.DxcTechnology.Entities.Tache;
import com.DxcTechnology.Repository.MemberEquipeRepository;
import com.DxcTechnology.Repository.TacheRepository;
import com.DxcTechnology.Repository.TasksRepository;
import com.DxcTechnology.Service.TacheService;

@Controller
public class EmployeController {
	
	@Autowired
	private TacheService tacheRepo;
	
	@Autowired
	private TacheRepository tr;
	
	@Autowired
	private TasksRepository tsr;
	
	@Autowired
	private MemberEquipeRepository mrep;

	@RequestMapping("/EMPLOYE/doLogout")
	public String doLogout(HttpServletRequest request,SessionStatus status) {	
		 HttpSession session = request.getSession(false);
		    if (session != null) {
		    	status.setComplete();
		        session.invalidate();
		    }
		    return "redirect:/loginPage"; 
	}	
	
	
	@RequestMapping("/EMPLOYE/DashboardEmp")
	public String showDashboardEMPLOYE(Model model,HttpSession session) {
		String cin = (String) session.getAttribute("cin");
	       if(cin==null) {
				return "redirect:/loginPage";
			}
			
		return "/EMPLOYE/DashboardEmp";
	}

	@RequestMapping("/EMPLOYE/EditPhase")
	public String showEditPhase(Model model,HttpSession session,@Param(value = "id_tache") Long id_tache) {
		String cin = (String) session.getAttribute("cin");
	       if(cin==null) {
				return "redirect:/loginPage";
			}
	       Tache t = tr.FindTacheByid(id_tache);
			model.addAttribute("task",t);
		return "/EMPLOYE/EditPhase";
	}
	
	
	@RequestMapping("/EMPLOYE/ListTaches2")
	public String showListTaches(Model model,String keyword, HttpSession session) {
		String cin2 = (String) session.getAttribute("cin");
		String nom1 = (String) session.getAttribute("nom1");
		String prenom1 = (String) session.getAttribute("prenom1");
		if(cin2==null) {
			return "redirect:/loginPage";
		}
		List<Tache> ListTaches = tacheRepo.findBnames(nom1, prenom1);
		model.addAttribute("ListTaches",ListTaches);
		return "/EMPLOYE/ListTaches2";
	}
	
	 
	@PostMapping("/EMPLOYE/process_update_task_emp")
	public String process_update_tache(Model model,HttpSession s ,@RequestParam(value = "id_tache") Long id_tache,
			@RequestParam(value = "statut_t") String statut_t,
			@RequestParam(value = "duree_t") int duree_t,
			@RequestParam(value = "description") String description) throws IllegalStateException, IOException {
		String nom =(String) s.getAttribute("nom1");
 		String prenom =(String)s.getAttribute("prenom1"); 	
		tsr.UpdteTaskByid_tache(statut_t, description, id_tache);
         	if(statut_t.equals("Terminer")) {
         		System.out.println(duree_t);
         		mrep.Modifiactioncharge(duree_t, nom, prenom);
         	}
         	return "redirect:/EMPLOYE/EditPhase?id_tache="+id_tache;
	}
}






















