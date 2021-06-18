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
@Table(name = "types_tache")
public class Type_tache {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id_type;
	
	@Column
	private String type_tache;
	
	public Type_tache() {}
	
	public Type_tache(String type_tache) {
		this.type_tache = type_tache;
	}
	
	
}
