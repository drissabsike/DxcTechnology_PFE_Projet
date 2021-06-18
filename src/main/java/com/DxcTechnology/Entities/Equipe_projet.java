package com.DxcTechnology.Entities;

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
@Table(name = "equipe_projet")
public class Equipe_projet {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column
	private String nom_equipe;
	
	@Column
	private int heure;
	
	@Column
	private String projet_title;

	@Column
	private String description;
	
	public Equipe_projet(Long id, String nom_equipe, int heure, String projet_title, String description) {
		this.id = id;
		this.nom_equipe = nom_equipe;
		this.heure = heure;
		this.projet_title = projet_title;
		this.description = description;
	}
	
	public Equipe_projet() {}
	
	public Equipe_projet(String nom_equipe, int heure, String projet_title, String description) {
		this.nom_equipe = nom_equipe;
		this.heure = heure;
		this.projet_title = projet_title;
		this.description = description;
	}
}
