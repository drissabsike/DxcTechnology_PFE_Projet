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
@Table(name = "projets")
public class Projet {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id_projet;
	@Column
	private String titre_projet;
	@Column
	private String cin_Manager;
	@Column
	private Date dateDebut;
	@Column
	private Date dateFin;
	@Column
	private int budget_projet;
	@Column
	private String client;
	@Column
	private int avance;
	@Column
	private String description;
	@Column
	private int ref_id_facture;
	@Column
	private String file_path;
	@Column
	private java.util.Date date_creation;
	@Column
	private int percent_complete;
	@Column
	private String etat_projet;
	
	/*@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "ref_id_projet", referencedColumnName = "id_projet")
	List<Tache> list_tache = new ArrayList<>();*/

	public Projet() {}

	public Projet(String titre_projet, String cin_Manager,  Date dateDebut, Date dateFin,int budget_projet, 
			String client, int avance, String description,int ref_id_facture, String file_path, int percent_complete) {
		this.titre_projet = titre_projet;
		this.cin_Manager = cin_Manager;
		this.dateDebut = dateDebut;
		this.dateFin = dateFin;
		this.budget_projet = budget_projet;
		this.client = client;
		this.avance = avance;
		this.description = description;
		this.ref_id_facture = ref_id_facture;
		this.file_path = file_path;
		this.percent_complete = percent_complete;
	}
	

	
	
	
}
