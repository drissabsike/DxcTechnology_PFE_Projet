package com.DxcTechnology.Entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "statuts")
public class Statut {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id_s;
	
	@Column
	private String statut_tache;
	
	public Statut() {}
	
	public Statut(String statut_tache){
		this.statut_tache = statut_tache;
	}
	
}
