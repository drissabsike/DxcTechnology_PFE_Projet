package com.DxcTechnology.Service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.DxcTechnology.Entities.Equipe;

@Service
public interface EquipeService {

	public List<Equipe> listeEquipe();
	
	public void AddTeam(Equipe equipe);
	
	
}
