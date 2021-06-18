package com.DxcTechnology.Service;

import java.util.List;

import com.DxcTechnology.Entities.Experiance;
import com.DxcTechnology.Entities.Role;
import com.DxcTechnology.Entities.User;

public interface UserService {
	
	public User findByEmailandPass(String email,String password);
	public User findByEmail(String email);
	public User createNewUser(User user);
	public int getEMP();	
	public int NbrEmpl();
	public int NbrMng();
	public List<User> getUserExp();
	public User findUserByCIN(String cin);
	public User findUserBymatricule(String cin);
	public void pwdUpdate(String Npwd,String matricule);
	public List<Role> ListeDesRoles();
	public List<Experiance> ListeDexp();
	public List<User> listUsers();
	public User selectParNomPrenom(String cin);
	public void ActiveUpdate(String cin);
	public void DesativeUpdate(String cin);
	public void UpdateUserByCin(String nom,String prenom,String cin,String telephone, String titre, String role_user,String experiance,String cin2);

}
