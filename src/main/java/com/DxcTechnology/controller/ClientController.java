package com.DxcTechnology.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.DxcTechnology.Entities.Client;
import com.DxcTechnology.Entities.Projet;
import com.DxcTechnology.Service.ClientService;
import com.DxcTechnology.Service.ProjetService;

@Controller
public class ClientController {
	
	@Autowired
	private ClientService clientService;
	
	@Autowired
	private ProjetService ps;
	
	@RequestMapping("/ADMIN/ListClients")
	public String showListClients(Model model, String keyword) {
		if(keyword==null) {
		List<Client> ListClients = clientService.listClients();
		model.addAttribute("ListClients",ListClients);
		}else {
			List<Client> ListClients = clientService.FindClientByKeywoard(keyword);
			model.addAttribute("ListClients",ListClients);	
		}
		return "/ADMIN/ListClients";
	}
	
	@RequestMapping("/ADMIN/NouvClient")
	public String showNouvClient() {
			return "/ADMIN/NouvClient";
	}

	///MANAGER/process_create_Client
	@PostMapping("/ADMIN/process_create_Client")
	public String create_project(Client client,@RequestParam(value = "nom_client") String nom_client,
			@RequestParam(value = "address") String address,
			@RequestParam(value = "telephone") String telephone,
			@RequestParam(value = "file") MultipartFile file) throws IllegalStateException, IOException {
		String image_path = "D:\\DXC\\Projet\\DxcTechnology-1_V14\\DxcTechnology-1\\src\\main\\webapp\\images\\";
		String image_path2 = "images/"+nom_client+".png";
		file.transferTo(new File(image_path+nom_client+".png"));	
		client.setNom_client(nom_client);
		client.setAddress(address);
		client.setTelephone(telephone);
		client.setImage_path(image_path2);
		clientService.CreationClient(client);
		return "redirect:/ADMIN/ListClients";
	}

	@RequestMapping("/MANAGER/ListClients")
	public String showListClients_MANAGER(Model model, String keyword) {
		if(keyword==null) {
		List<Client> ListClients = clientService.listClients();
		model.addAttribute("ListClients",ListClients);
		}else {
			List<Client> ListClients = clientService.FindClientByKeywoard(keyword);
			model.addAttribute("ListClients",ListClients);	
		}
		return "/MANAGER/ListClients";
	}
	
	
	@RequestMapping("/MANAGER/ProjetClient")
	public String showProjects_Client(HttpSession session,Model model,@Param(value = "client") String client) {
		List<Projet> listP = ps.findByclient(client);
		model.addAttribute("ListProjets",listP);
		model.addAttribute("client",client);
		session.setAttribute("client",client);
		return "/MANAGER/ProjetClient";
	}
		/*
	///MANAGER/process_create_Client
	@PostMapping("/MANAGER/process_create_Client")
	public String create_project_MANAGER(Client client,@RequestParam(value = "nom_client") String nom_client,
			@RequestParam(value = "address") String address,
			@RequestParam(value = "telephone") String telephone,
			@RequestParam(value = "file") MultipartFile file) throws IllegalStateException, IOException {
		String image_path = "D:\\DXC\\Projet\\DxcTechnology-1_V14\\DxcTechnology-1\\src\\main\\webapp\\images\\";
		String image_path2 = "images/"+nom_client+".png";
		file.transferTo(new File(image_path+nom_client+".png"));	
		client.setNom_client(nom_client);
		client.setAddress(address);
		client.setTelephone(telephone);
		client.setImage_path(image_path2);
		clientService.CreationClient(client);
		return "redirect:/MANAGER/ListClients";
	}*/
}
