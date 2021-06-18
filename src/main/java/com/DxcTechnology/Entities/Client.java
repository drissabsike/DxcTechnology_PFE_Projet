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
@Table(name = "clients")
public class Client {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id_client;
	
	@Column
	private String nom_client;
	
	@Column
	private String telephone;
	
	@Column
	private String address;
	
	@Column
	private String image_path;
	
	public Client() {}

	public Client(String nom_client, String telephone, String address, String image_path) {
		this.nom_client = nom_client;
		this.telephone = telephone;
		this.address = address;
		this.image_path = image_path;
	}
	
	
	
}











