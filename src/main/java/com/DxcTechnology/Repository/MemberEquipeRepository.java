package com.DxcTechnology.Repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.DxcTechnology.Entities.MembreEquipe;

@Repository
public interface MemberEquipeRepository extends JpaRepository<MembreEquipe, Long>{
	
	@Query("SELECT m FROM MembreEquipe m WHERE m.team_name =?1 ")
	List<MembreEquipe> listMembreEquipeByTeam(String team);
	
	/*@Query("SELECT m.employe, m.team_name, m.chargeJour FROM MembreEquipe m ,Tache t WHERE m.employe=t.emp_nom "
			+ "AND t.ref_id_projet=(SELECT id_projet from Projet WHERE titre_projet = ?1")
	public List<MembreEquipe> EquipeEmploye(String titre_projet);*/ 
	
	@Query("SELECT chargeJour FROM MembreEquipe WHERE employe=?1 ")
	public int getChargeGlobale(String employe);
	
	@Query("select m from MembreEquipe m WHERE employe=?1 ")
	public MembreEquipe getMember(String emp_name);
	
	
	//UPDATE membre_equipe SET charge_jour = WHERE employe=
		@Query("UPDATE MembreEquipe SET chargeJour=?1 WHERE employe=?2 ")
		@Modifying
		@Transactional
		void UpdateMmeberCharge(int Ncharge,String emp_nom);
		
		
	//UPDATE membre_equipe SET charge_jour=charge_jour+4 WHERE employe='slahmi mohamed'
		@Query("UPDATE MembreEquipe SET chargeJour=chargeJour+?1 WHERE employe=CONCAT(?2,' ',?3) ")
		@Modifying
		@Transactional
		void Modifiactioncharge(int chargeJour, String nom, String prenom);
		
	
	}













