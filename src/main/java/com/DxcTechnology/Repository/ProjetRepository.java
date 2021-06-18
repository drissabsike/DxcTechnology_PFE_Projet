package com.DxcTechnology.Repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.DxcTechnology.Entities.Projet;

@Repository
public interface ProjetRepository extends JpaRepository<Projet, Long>{
	
	@Query("SELECT p FROM Projet p WHERE p.cin_Manager = ?1 AND p.etat_projet='Non_Annuler' ")
	public List<Projet> findBycin(String cin);

	@Query("SELECT p FROM Projet p WHERE p.client = ?1")
	public List<Projet> findByclient(String client);
	
	@Query("SELECT p.titre_projet FROM Projet p")
	public List<String> findTitres();
	
	@Query("SELECT COUNT(p.titre_projet) FROM Projet p WHERE p.cin_Manager = ?1")
	public int findPBycin(String cin);
	
	@Query("SELECT COUNT(p.titre_projet) FROM Projet p")
	public int findAllp();
	
	@Query("SELECT p FROM Projet p WHERE p.titre_projet like %:keyword%")
	public List<Projet> FindProjetByKeywoard(@Param("keyword") String keyword);
	
	@Query("SELECT p.titre_projet, p.percent_complete FROM Projet p")
	public List<Projet> getprojetAndPourcentage();
	
	@Modifying
	@Query("UPDATE Projet p SET p.etat_projet='Annuler' WHERE p.id_projet = ?1 ")
	void changeStatutPojet(Long id_projet);
	
	@Modifying
	@Query("UPDATE Projet p SET p.etat_projet='Non_Annuler' WHERE p.id_projet = ?1 ")
	void changeStatutPojet2(Long id_projet);
	
	@Query("SELECT p FROM Projet p WHERE p.cin_Manager = ?1 AND p.etat_projet='Annuler' ")
	public List<Projet> findPAnuulerBycin(String cin);
	
	@Query("SELECT p.titre_projet FROM Projet p WHERE p.titre_projet like %:name%")
	public String FindByProjectName(String name);

	
	
}







