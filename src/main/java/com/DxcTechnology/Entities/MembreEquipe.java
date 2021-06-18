package com.DxcTechnology.Entities;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Setter
@Getter
@Entity
@Table(name = "membre_Equipe")
public class MembreEquipe {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id_member;
	
	@Column
	private String team_name;
	
	@Column
	private String employe;
	
	@Column
	private int chargeJour;
	
	@Column
	private Date date_creation;
	
	public MembreEquipe() {}

	public MembreEquipe(String team_name, String employe, int chargeJour, Date date_creation) {
		this.team_name = team_name;
		this.employe = employe;
		this.chargeJour = chargeJour;
		this.date_creation = date_creation;
	}
	
	

}
