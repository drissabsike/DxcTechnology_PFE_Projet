package com.DxcTechnology.Service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DxcTechnology.Entities.Tache;
import com.DxcTechnology.Repository.TacheRepository;

@Service
public class TacheServiceImlp implements TacheService{

	@Autowired
	private TacheRepository tacheRepo;
	
	@Override
	public List<Tache> finallTasks() {
		List<Tache> T = tacheRepo.findAll();
		return T;
	}

	@Override
	public List<Tache> finaTasksByEMP(String name) {
		List<Tache> T = tacheRepo.FindTacheByKeywoard(name);
		return T;
	}

	@Override
	public List<Tache> GetBycin(String cin) {
		List<Tache> lt = tacheRepo.GetBycin(cin);
		return  lt;
	}

	@Override
	public List<Tache> findBnames(String nom, String penom) {
		List<Tache> lt = tacheRepo.findBnames(nom, penom);
		return lt;
	}

}
