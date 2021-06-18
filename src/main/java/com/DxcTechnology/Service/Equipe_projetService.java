package com.DxcTechnology.Service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.DxcTechnology.Entities.Equipe_projet;

@Service
public interface Equipe_projetService {
	
	public Equipe_projet creatTeam(Equipe_projet equipe_projet);
	
	public List<Equipe_projet> ListTeam(String Titre_projet);

}
