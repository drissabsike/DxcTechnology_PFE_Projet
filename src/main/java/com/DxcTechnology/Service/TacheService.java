package com.DxcTechnology.Service;

import java.util.List;
import org.springframework.stereotype.Service;

import com.DxcTechnology.Entities.Tache;

@Service
public interface TacheService {
	
	public List<Tache> finallTasks();
	
	public List<Tache> finaTasksByEMP(String name);
	
	public List<Tache> GetBycin(String cin);
	
	public List<Tache> findBnames(String nom,String penom);

}
