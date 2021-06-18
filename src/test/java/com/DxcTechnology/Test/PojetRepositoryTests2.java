package com.DxcTechnology.Test;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.Rollback;

import com.DxcTechnology.Repository.*;
import com.DxcTechnology.Service.ProjetService;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(false)
public class PojetRepositoryTests2 {
	
	@Autowired
	private ProjetRepository projetRepo;
	
	
	
	@Autowired
	private ProjetService ps;
	
	@Autowired
	private Equipe_projetRepository er;
	
	@Test
	public void changeEtatP() {
		try {
		projetRepo.changeStatutPojet((long) 2);
	}catch (Exception e) {
		System.out.println("erreur in: "+e.getMessage());
	}
	}
	
	
	@Test
	public void showP() {
		try {
		ps.FindByProjectName("APP WEB");
	}catch (Exception e) {
		System.out.println("erreur in: "+e.getMessage());
	}
		}
	
	@Test
	public void showT() {
		try {
		er.ListTeam("app mobile gestion de Y");
	}catch (Exception e) {
		System.out.println("erreur in: "+e.getMessage());
	}
		}

	
	
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	






















