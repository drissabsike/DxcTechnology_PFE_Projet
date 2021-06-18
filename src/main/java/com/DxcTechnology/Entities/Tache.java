package com.DxcTechnology.Entities;

import java.sql.Date;

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
@Table(name = "taches")
public class Tache {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id_tache;
	@Column
	private String titre_tache;
	@Column
	private Date dateDebut;
	@Column
	private Date dateMax;
	@Column
	private int ref_id_projet;
	@Column
	private int duree_t;
	@Column
	private String statut_t;
	@Column
	private String emp_nom;
	@Column
	private String description;
	@Column
	private int percent_complete;
	@Column
	private String types_tache;
	
	public Tache() {}
	

	public Tache(int duree_t, String emp_nom, String description, String types_tache) {
		this.duree_t = duree_t;
		this.emp_nom = emp_nom;
		this.description = description;
		this.types_tache = types_tache;
	}


	public Tache(String titre_tache, Date dateDebut, Date dateMax, int ref_id_projet, int duree_t, String statut_t,
			String emp_nom, String description, int percent_complete, String types_tache) {
		this.titre_tache = titre_tache;
		this.dateDebut = dateDebut;
		this.dateMax = dateMax;
		this.ref_id_projet = ref_id_projet;
		this.duree_t = duree_t;
		this.statut_t = statut_t;
		this.emp_nom = emp_nom;
		this.description = description;
		this.percent_complete = percent_complete;
		this.types_tache = types_tache;
	}



		
	
	
	
}
