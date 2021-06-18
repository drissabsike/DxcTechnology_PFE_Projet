package com.DxcTechnology.Service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.DxcTechnology.Entities.Equipe;
import com.DxcTechnology.Repository.EquipeRepository;

@Service
public class ServiceEquipeIMP implements EquipeService{

	@Autowired
	private EquipeRepository ER;
	
	@Override
	public List<Equipe> listeEquipe() {
		return ER.findAll();
	}

	@Override
	public void AddTeam(Equipe equipe) {
		Equipe e = new Equipe();
		ER.save(e);
		}

}
