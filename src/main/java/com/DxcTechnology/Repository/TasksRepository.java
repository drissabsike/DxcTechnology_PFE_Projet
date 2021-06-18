package com.DxcTechnology.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;
import com.DxcTechnology.Entities.Tasks;

public interface TasksRepository extends JpaRepository<Tasks, Long>{
	
	@Query("UPDATE Tache t SET t.statut_t= ?1 ,t.description = ?2 WHERE t.id_tache = ?3")
	@Modifying
	@Transactional
	void UpdteTaskByid_tache(String statut_t, String description,Long id_tache);

}
