package com.DxcTechnology.Entities;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name = "equipes")
public class Equipe {
	
	@Column
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column
	private String nom_equipe;
	
	@Column
	private String description;
	
	@Column
	private Date date_creation;
	
	public Equipe() {}

	public Equipe(String nom_equipe, String description,Date date_creation) {
		this.nom_equipe = nom_equipe;
		this.description = description;
		this.date_creation = date_creation;
	}

	
}
