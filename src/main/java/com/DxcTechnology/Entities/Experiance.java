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
@Table(name = "experiance")
public class Experiance {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column
	private String niveau_exp;
	
	public Experiance() {}

	public Experiance(Long id, String niveau_exp) {
		super();
		this.id = id;
		this.niveau_exp = niveau_exp;
	}
	
	

}
