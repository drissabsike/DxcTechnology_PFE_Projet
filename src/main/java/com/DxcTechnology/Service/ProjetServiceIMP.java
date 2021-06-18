package com.DxcTechnology.Service;

import java.util.List;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DxcTechnology.Entities.Projet;
import com.DxcTechnology.Repository.ProjetRepository;

@Service 
@Transactional
public class ProjetServiceIMP implements ProjetService{
	
	@Autowired
	private ProjetRepository proRepo;

	@Override
	public List<Projet> findBycin(String cin) {
		
		List<Projet> listProjet = proRepo.findBycin(cin);
		
		if(listProjet==null) 
			{throw new RuntimeException("Projet Introuvable");
			}
		return listProjet;
	}

	@Override
	public int findPBycin(String cin) {
		int i = proRepo.findPBycin(cin); 
		return i;
	}

	@Override
	public Projet createNewwProject(Projet p) {
		Projet pr = proRepo.save(p);
		if(pr==null) {
			throw new RuntimeException("Erreur in: createNewwProject");
		}
		return pr;
	}

	@Override
	public List<String> listtitre_projet() {
		List<String> list_titres = proRepo.findTitres();
		if(list_titres==null) {
			System.out.println("Erreur in :listtitre_projet");
		}
		System.out.println(list_titres);
		return list_titres;
	}

	@Override
	public int findAllp() {
		return proRepo.findAllp();
	}

	@Override
	public List<Projet> findAllP() {
		List<Projet> L = proRepo.findAll();
		return L;
	}

	@Override
	public List<Projet> FindProjetByKeywoard(String k) {
		List<Projet> L = proRepo.FindProjetByKeywoard(k);
		return L;
	}

	@Override
	public List<Projet> getprojetAndPourcentage() {
		return proRepo.getprojetAndPourcentage();
	}

	@Override
	public void changeStatutPojet(Long id_projet) {
		 proRepo.changeStatutPojet((Long) id_projet);
		 }

	@Override
	public List<Projet> findPAnuulerBycin(String cin) {

		List<Projet> listProjet = proRepo.findPAnuulerBycin(cin);
		
		if(listProjet==null) 
			{throw new RuntimeException("Projet Introuvable");
			}
		return listProjet;
	}

	@Override
	public void changeStatutPojet2(Long id_projet) {
		 proRepo.changeStatutPojet2((Long) id_projet);
	 }

	@Override
	public void FindByProjectName(String name) {
		try {
		String n = proRepo.FindByProjectName(name);
			if(n==null) {
				System.out.println("Project not exist");
			}else {
				System.out.println("Project Alredy exist");
			}
	}catch (Exception e) {
		System.out.println("erreur in: ProjetIMP "+e.getMessage());
	}
			
	}

	@Override
	public List<Projet> findByclient(String client) {
		 List<Projet> listProjetsClient = proRepo.findByclient(client);
		return listProjetsClient;
	}

}





