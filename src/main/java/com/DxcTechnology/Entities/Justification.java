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
@Table(name = "justification")
public class Justification {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column
	private Long ref_id_projet;
	
	@Column
	private String justification;
	
	@Column
	private Date date_creation;
	
	public Justification() {}

	public Justification(Long ref_id_projet, String justification) {
		super();
		this.ref_id_projet = ref_id_projet;
		this.justification = justification;
	}
	
	

}
