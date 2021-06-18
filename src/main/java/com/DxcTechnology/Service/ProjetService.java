package com.DxcTechnology.Service;

import java.util.List;
import org.springframework.stereotype.Service;

import com.DxcTechnology.Entities.Projet;

@Service
public interface ProjetService {

	public List<Projet> findAllP();
	
	public List<Projet> FindProjetByKeywoard(String k);
	
	public int findPBycin(String cin);
	
	public List<Projet> findByclient(String client);
	
	public Projet createNewwProject(Projet projet);
	
	public void changeStatutPojet(Long id_projet);
	
	public List<String> listtitre_projet();

	public List<Projet> getprojetAndPourcentage();
	
	int findAllp();

	public List<Projet> findBycin(String cin);
	
	public List<Projet> findPAnuulerBycin(String cin);
	
	void changeStatutPojet2(Long id_projet);
	
	public void FindByProjectName(String name);
	
	
}
