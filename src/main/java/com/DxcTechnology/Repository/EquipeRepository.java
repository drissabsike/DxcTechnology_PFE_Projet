package com.DxcTechnology.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.DxcTechnology.Entities.Equipe;

@Repository
public interface EquipeRepository extends JpaRepository<Equipe, Long>{

}
