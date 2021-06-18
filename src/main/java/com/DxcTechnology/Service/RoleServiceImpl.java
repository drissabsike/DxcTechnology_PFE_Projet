package com.DxcTechnology.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DxcTechnology.Entities.Role;
import com.DxcTechnology.Repository.RoleRepository;


@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	private RoleRepository roleRepository;
	
	public List<Role> ListeDesRoles() {
		return (List<Role>) roleRepository.findAll();
	}

	
}
