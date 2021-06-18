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
@Table(name = "role")
public class Role {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id_role;
	
	@Column
	private String role;
	
	public Role() {}

	public Role(Long id_role, String role) {
		super();
		this.id_role = id_role;
		this.role = role;
	}
	
	
	
}
