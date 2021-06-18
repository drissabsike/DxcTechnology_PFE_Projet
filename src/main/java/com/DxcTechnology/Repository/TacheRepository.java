package com.DxcTechnology.Repository;

import java.sql.Date;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.DxcTechnology.Entities.Tache;

@Repository
public interface TacheRepository extends JpaRepository<Tache, Long>{
	
//SELECT t.* FROM taches t INNER JOIN projets p ON t.ref_id_projet=p.id_projet AND p.cin_manager = 'cintest3'

	@Query("SELECT t FROM Tache t INNER JOIN Projet p ON t.ref_id_projet=p.id_projet AND p.cin_Manager = ?1 ")
	public List<Tache> findBycin(String cin);
	
	//SELECT * FROM taches WHERE ref_id_projet IN (SELECT id_projet FROM projets WHERE cin_manager='test')
	@Query("SELECT t FROM Tache t WHERE t.ref_id_projet IN (SELECT p.id_projet FROM Projet p WHERE p.cin_Manager = ?1 )")
	public List<Tache> GetBycin(String cin);
	
	//SELECT COUNT(u.nom) FROM User u WHERE u.role_user='EMPLOYE'
	@Query("SELECT COUNT(u.nom) FROM User u WHERE u.role_user='EMPLOYE'")
	public int getEMP();
	
	@Query("SELECT SUM(t.duree_t) FROM Tache t WHERE t.ref_id_projet=(SELECT p.id_projet FROM Projet p WHERE p.titre_projet = ?1 )")
	String getSum(String ref_id_projet);
	
	@Query("SELECT COUNT(*) FROM Tache t INNER JOIN Projet p ON t.ref_id_projet=p.id_projet AND p.cin_Manager = ?1 ")
	public int getTach(String cin);
	
	@Query("SELECT SUM(budget_projet) FROM Projet WHERE cin_manager = ?1")
	public String getSUMPro(String cin);
	
	@Query("SELECT t FROM Tache t WHERE t.emp_nom like %:keyword%")
	public List<Tache> FindTacheByKeywoard(@Param("keyword") String keyword);
	
	@Query("SELECT t FROM Tache t WHERE t.id_tache = ?1 ")
	public Tache FindTacheByid(Long id_tache);
	
	@Query("UPDATE Tache t SET t.emp_nom = ?1 ,t.description = ?2, t.types_tache = ?3, t.dateDebut= ?4, t.dateMax= ?5 WHERE t.id_tache = ?6 ")
	@Modifying
	@Transactional
	void TacheUpdate(String emp_nom, String description,String types_tache ,Date dateDebut, Date dateMax, Long id_tache);
	
	@Query("SELECT t from Tache t WHERE t.emp_nom=CONCAT(?1,' ',?2)")
	public List<Tache> findBnames(String nom,String penom);
	
	//SELECT MIN(date_max) FROM taches WHERE emp_nom='idriss absike'
	@Query("SELECT MIN(dateMax) FROM Tache WHERE emp_nom=?1 ")
	public Date getDatefin1ereTask(String employe);
	
	//SELECT duree_t FROM `taches` WHERE statut_t ='Terminer'
	@Query("SELECT t FROM Tache t WHERE statut_t ='Terminer'")
	public List<Tache> getCharteTache();

	
	

}
