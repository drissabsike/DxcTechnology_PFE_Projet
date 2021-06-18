package com.DxcTechnology.Repository;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.DxcTechnology.Entities.Justification;

@Repository
public interface JustificationRepository extends JpaRepository<Justification, Long>{
	
	@Modifying
	@Transactional 
	@Query("DELETE from Justification j where j.ref_id_projet = ?1")
	void deleteJustification(Long id_projet);
	
	@Query("SELECT justification from Justification j where j.ref_id_projet = ?1")
	String justifiaction(Long id_projet);
	
}
