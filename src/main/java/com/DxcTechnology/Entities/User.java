package com.DxcTechnology.Entities;

import java.util.Date;
import javax.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Setter
@Getter
@Entity
@Table(name = "users")
public class User {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id_user;
	
	@Column
	private String nom;
	
	@Column
	private String prenom;
	
	@Column
	private String cin;
	
	@Column
	private String telephone;
	
	@Column
	private String email;
	
	@Column
	private String password;
	 
	@Column
	private String role_user;
	
	@Column	
	private String titre;
	
	@Column
	private String experiance;
	
	@Column
	private int activation;
	
	@Column
	private String activation_code;
	
	@Column
	private Date date_creation;
	
	@Column
	private String image_path;

	@Column
	private String matricule;
	
	public User() {}

	public User(String nom, String prenom, String cin, String telephone, String role_user, String titre,
			String experiance,String image_path,String matricule) {
		this.nom = nom;
		this.prenom = prenom;
		this.cin = cin;
		this.telephone = telephone;
		this.role_user = role_user;
		this.titre = titre;
		this.experiance = experiance;
		this.image_path = image_path;
		this.matricule= matricule;
	}

	public User(String nom, String prenom, String cin, String telephone, String email, String password,
			String role_user, String titre, String experiance,String image_path, String matricule) {
		this.nom = nom;
		this.prenom = prenom;
		this.cin = cin;
		this.telephone = telephone;
		this.email = email;
		this.password = password;
		this.role_user = role_user;
		this.titre = titre;
		this.experiance = experiance;
		this.image_path = image_path;
		this.matricule= matricule;
	}
}












