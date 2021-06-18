package com.DxcTechnology.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DxcTechnology.Entities.Justification;
import com.DxcTechnology.Repository.JustificationRepository;

@Service
public class JustificationServiceIMLP implements JusificationService{

	@Autowired
	private JustificationRepository justificationRepo;
	
	@Override
	public String ConfirmationJustification(Justification justification) {
		Justification j = new Justification();
		Justification j2 =justificationRepo.save(j);
		if(j2==null) {
			throw new RuntimeException("Erreur in: ConfirmationJustification");
		}
		return "Projet Annuler";
	}

	@Override
	public void deleteJustification(Long id_projet) {
	 justificationRepo.deleteJustification(id_projet);	
	}

	@Override
	public String justifiaction(Long id_projet) {
		return justificationRepo.justifiaction(id_projet);
	}

}
