package com.DxcTechnology.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.DxcTechnology.Entities.Equipe_projet;
import com.DxcTechnology.Entities.Tache;

@Repository
public interface Equipe_projetRepository extends JpaRepository<Equipe_projet, Long>{
	
	@Query("SELECT p FROM Equipe_projet p WHERE p.projet_title = ?1 ")
	public List<Equipe_projet> ListTeam(String Titre_projet);

	@Query("SELECT SUM(heure) as Total FROM Equipe_projet WHERE projet_title = ?1 ")
	String SommeCharge(String Titre_projet);
	
	@Query("SELECT T FROM Tache T WHERE T.ref_id_projet = (SELECT p.id_projet FROM Projet p WHERE p.titre_projet = ?1 )")
	public List<Tache> listdesPhases(String ref_id_projet);
}
