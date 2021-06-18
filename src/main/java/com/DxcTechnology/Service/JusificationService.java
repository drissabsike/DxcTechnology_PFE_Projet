package com.DxcTechnology.Service;

import org.springframework.stereotype.Service;

import com.DxcTechnology.Entities.Justification;

@Service
public interface JusificationService {
	
	
	public String ConfirmationJustification(Justification justification);
	
	void deleteJustification(Long id_projet);
	
	String justifiaction(Long id_projet);
	

}
