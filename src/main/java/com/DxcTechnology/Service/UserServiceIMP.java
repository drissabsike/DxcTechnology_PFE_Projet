package com.DxcTechnology.Service;

import java.util.List;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DxcTechnology.Entities.Experiance;
import com.DxcTechnology.Entities.Role;
import com.DxcTechnology.Entities.User;
import com.DxcTechnology.Repository.TacheRepository;
import com.DxcTechnology.Repository.UserRepository;

@Service 
@Transactional
class UserServiceIMP implements UserService{
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private TacheRepository tr;

	@Override
	public User findByEmailandPass(String email, String password) {
		User us = userRepo.findByEmailandPass(email, password);
		if(us==null) {
			
		}
		return us;
	}

	@Override
	public User findByEmail(String email) {
		User us = userRepo.findByEmail(email);
		if(us==null) {throw new RuntimeException("User Introuvable");
		}
		return us;
	}


	@Override
	public User findUserBymatricule(String matricule) {
		User us = userRepo.findUserBymatricule(matricule);
		if(us==null) {throw new RuntimeException("User Introuvable");
		}
		return us;
	}
	
	@Override
	public User findUserByCIN(String cin) {
		User us = userRepo.findUserByCIN(cin);
		if(us==null) {throw new RuntimeException("User Introuvable");
		}
		return us;
	}

	@Override
	public void pwdUpdate(String Npwd, String cin) {
		userRepo.pwdUpdate(Npwd, cin);
	}

	@Override
	public List<Role> ListeDesRoles() {
		List<Role> ListeDesRoles = userRepo.ListeDesRoles();
		return ListeDesRoles;
	}

	@Override
	public List<Experiance> ListeDexp() {
		List<Experiance> ListeDexp = userRepo.ListeDexp();
		return ListeDexp;
	}

	@Override
	public User selectParNomPrenom(String cin) {
		User us = userRepo.selectParNomPrenom(cin);
		if(us==null) {throw new RuntimeException("User Introuvable");
		}
		return us;
	}

	@Override
	public void ActiveUpdate(String cin) {
		userRepo.ActiveUpdate(cin);
	}

	@Override
	public void DesativeUpdate(String cin) {
		userRepo.DesativeUpdate(cin);
		
	}

	@Override
	public void UpdateUserByCin(String nom, String prenom, String cin, String telephone, String titre, String role_user,
			String experiance, String cin2) {
		userRepo.UpdateUserByCin(nom, prenom, cin, telephone, titre, role_user, experiance, cin2);
	}

	@Override
	public User createNewUser(User user) {
		User us = new User();
		User u = userRepo.save(us);
		if(u==null) {
			throw new RuntimeException("Erreur in: createNewUser");
		}
		return u;
	}

	@Override
	public List<User> listUsers() {
		List<User> listUsers = userRepo.findAll();
		return listUsers;
	}

	@Override
	public int getEMP() {
		int a = tr.getEMP();
		return a;
	}
	
	//get bY Keywoard
	public List<User> findUserBykeyword(String keyword){
		return userRepo.FindEmplByKeywoard(keyword);
	}

	@Override
	public int NbrEmpl() {
		return userRepo.NbrEmpl();
	}

	@Override
	public int NbrMng() {
		return userRepo.NbrMng();
	}

	@Override
	public List<User> getUserExp() {
		return userRepo.getUserExp();
	}


}
