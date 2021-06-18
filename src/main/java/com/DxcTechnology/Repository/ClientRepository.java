package com.DxcTechnology.Repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.DxcTechnology.Entities.Client;

@Repository
public interface ClientRepository extends JpaRepository<Client, Long>{

	@Query("SELECT COUNT(c.nom_client) FROM Client c")
	int CountAllClient();
	
	@Query("SELECT c FROM Client c WHERE c.nom_client like %:keyword%")
	List<Client> FindClientByKeywoard(@Param("keyword") String keyword);
	
	
}
