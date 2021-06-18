package com.DxcTechnology.Repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.DxcTechnology.Entities.Experiance;
import com.DxcTechnology.Entities.Role;
import com.DxcTechnology.Entities.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long>{
	
	
	@Query("SELECT u FROM User u WHERE u.email = ?1 AND u.password = ?2 AND u.activation=1 ")
	User findByEmailandPass(String email,String password);
	
	@Query("SELECT u FROM User u WHERE u.email = ?1 AND u.activation=1 ")
	User findByEmail(String email);

	@Query("UPDATE User u SET u.activation = 1 WHERE u.activation_code = ?1 ")
	@Modifying
	public void active(String activation_code);
	
	@Query("SELECT u FROM User u WHERE u.activation_code = ?1 ")
	public User findByVerivicationCode(String code);
	
	@Query("SELECT u FROM User u WHERE u.matricule = ?1 ")
	public User findUserBymatricule(String matricule);

	@Query("SELECT u FROM User u WHERE u.cin = ?1 ")
	public User findUserByCIN(String cin);	

	@Query("UPDATE User u SET u.password = ?1 WHERE u.matricule = ?2 ")
	@Modifying
	@Transactional
	void pwdUpdate(String Npwd,String matricule);
	
	@Query("SELECT r FROM Role r")
	List<Role> ListeDesRoles();
	
	@Query("SELECT e FROM Experiance e")
	List<Experiance> ListeDexp();
	
	@Query("SELECT u FROM User u WHERE u.cin = ?1")
	User selectParNomPrenom(String cin);
	
	@Query("SELECT CONCAT(nom,' ',prenom) AS fullName FROM User WHERE role_user='EMPLOYE'")
	List<User> ListEmpl();
	
	@Query("SELECT COUNT(u) FROM User u WHERE role_user='EMPLOYE'")
	int NbrEmpl();
	
	@Query("SELECT COUNT(u) FROM User u WHERE role_user='MANAGER'")
	int NbrMng();
	
	@Query("SELECT u FROM User u WHERE u.nom like %:keyword% or u.prenom like %:keyword% ")
	List<User> FindEmplByKeywoard(@Param("keyword") String keyword);
	
	@Query("UPDATE User u SET u.activation=1 WHERE u.cin = ?1 ")
	@Modifying
	@Transactional
	void ActiveUpdate(String cin);
	
	@Query("UPDATE User u SET u.activation=0 WHERE u.cin = ?1 ")
	@Modifying
	@Transactional
	void DesativeUpdate(String cin);
	
	@Query("UPDATE User u SET u.nom=?1, u.prenom=?2, u.cin=?3, u.telephone=?4, u.titre=?5, u.role_user=?6, u.experiance=?7 WHERE u.cin = ?8")
	@Modifying
	@Transactional
	void UpdateUserByCin(String nom,String prenom,String cin,String telephone, String titre, String role_user,String experiance,String cin2);
	
	
	@Query("UPDATE User u SET u.nom=?1, u.prenom=?2, u.telephone=?3, u.email=?4, u.titre=?5, u.cin=?6 WHERE u.cin = ?7")
	@Modifying
	@Transactional
	void UpdateUserwithCIN(String nom,String prenom,String telephone,String email, String titre, String cin, String cin2);
	
	@Query("SELECT u FROM User u WHERE u.role_user='EMPLOYE'")
	public List<User> getUserExp();
	
}










