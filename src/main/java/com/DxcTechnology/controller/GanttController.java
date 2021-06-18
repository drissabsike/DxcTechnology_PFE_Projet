package com.DxcTechnology.controller;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.DxcTechnology.Entities.Projet;
import com.DxcTechnology.Entities.Tache;
import com.DxcTechnology.Service.ProjetService;
import com.DxcTechnology.Service.TacheService;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@Controller
public class GanttController {
	
	@Autowired
	private ProjetService ps;
	
	@Autowired
	private TacheService ts;
	
	@RequestMapping("/MANAGER/Pie_chart")
	@ResponseBody
	public String getDataFromDB(HttpSession session){
		String cin =(String) session.getAttribute("cin");
		System.out.println("cin is:"+cin);
		List<Tache> listProjet = ts.GetBycin(cin);
		JsonArray jsonArrayTitre_tache = new JsonArray();
		JsonArray jsonArrayPoucentage = new JsonArray();
		JsonObject jsonObject = new JsonObject();
		listProjet.forEach(data->{
			jsonArrayTitre_tache.add(data.getTitre_tache() );
			jsonArrayPoucentage.add(data.getPercent_complete() );
		});
		jsonObject.add("Titre_tache", jsonArrayTitre_tache);
		jsonObject.add("Percent_complete", jsonArrayPoucentage);
		return jsonObject.toString();
	}

	@RequestMapping("/MANAGER/Pie_chart2")
	@ResponseBody
	public String getData(HttpSession session){
		String cin =(String) session.getAttribute("cin");
		System.out.println("cin is:"+cin);
		List<Projet> listProjet = ps.findBycin(cin);
		JsonArray jsonArrayTitre_Projet = new JsonArray();
		JsonArray jsonArrayPoucentage = new JsonArray();
		JsonObject jsonObject = new JsonObject();
		listProjet.forEach(data->{
			jsonArrayTitre_Projet.add(data.getTitre_projet() );
			jsonArrayPoucentage.add(data.getPercent_complete());
		});
		jsonObject.add("Titre_projet", jsonArrayTitre_Projet);
		jsonObject.add("Percent_complete", jsonArrayPoucentage);
		return jsonObject.toString();
	}
	

	@RequestMapping("/MANAGER/Pie_chart3")
	public ResponseEntity<?> getTableByCIN(HttpSession session){
		String cin =(String) session.getAttribute("cin");
		System.out.println("cin is:"+cin);
		List<Projet> listProjet = ps.findBycin(cin);
		 return new ResponseEntity<>(listProjet,HttpStatus.OK);
	}
	
	@RequestMapping("/MANAGER/Pie_chart6")
	public ResponseEntity<?> getTableByClient(HttpSession session){
		String client =(String) session.getAttribute("client");
		System.out.println("client is "+client);
		List<Projet> listProjet = ps.findByclient(client);
		 return new ResponseEntity<>(listProjet,HttpStatus.OK);
	}
		
	@RequestMapping("/ADMIN/Pie_chart2")
	@ResponseBody
	public String getDataforADMIN(){
		List<Projet> listProjet = ps.findAllP();
		JsonArray jsonArrayTitre_Projet = new JsonArray();
		JsonArray jsonArrayPoucentage = new JsonArray();
		JsonObject jsonObject = new JsonObject();
		listProjet.forEach(data->{
			jsonArrayTitre_Projet.add(data.getTitre_projet() );
			jsonArrayPoucentage.add(data.getPercent_complete());
		});
		jsonObject.add("Titre_projet", jsonArrayTitre_Projet);
		jsonObject.add("Percent_complete", jsonArrayPoucentage);
		return jsonObject.toString();
	}
	

	@RequestMapping("/ADMIN/Pie_chart3")
	public ResponseEntity<?> getDataADMIN(HttpSession session){
		List<Projet> listProjet = ps.findAllP();
		 return new ResponseEntity<>(listProjet,HttpStatus.OK);
	}
	

	@RequestMapping("/EMPLOYE/Pie_chart8")
	public ResponseEntity<?> getTasksEmploye(HttpSession session){
		String nom =(String) session.getAttribute("nom1");
		String prenom =(String) session.getAttribute("prenom1");
		List<Tache> TasksList = ts.findBnames(nom, prenom);
		 return new ResponseEntity<>(TasksList,HttpStatus.OK);
	}
	
	
	
}
