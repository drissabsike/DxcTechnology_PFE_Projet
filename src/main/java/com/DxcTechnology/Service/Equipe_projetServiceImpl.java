package com.DxcTechnology.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DxcTechnology.Entities.Equipe_projet;
import com.DxcTechnology.Repository.Equipe_projetRepository;

@Service
public class Equipe_projetServiceImpl implements Equipe_projetService{

	@Autowired
	private Equipe_projetRepository ER;
	
	@Override
	public Equipe_projet creatTeam(Equipe_projet equipe_projet) {
		Equipe_projet ep = new Equipe_projet();
		Equipe_projet e = ER.save(ep);
		if(e==null) {
			throw new RuntimeException("Erreur in: createNewTeam");
		}
		return e;
	}

	@Override
	public List<Equipe_projet> ListTeam(String Titre_projet) {
		List<Equipe_projet> ListT =ER.ListTeam(Titre_projet); 
		return ListT;
	}

}
