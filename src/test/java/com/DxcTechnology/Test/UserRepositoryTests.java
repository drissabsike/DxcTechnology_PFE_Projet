package com.DxcTechnology.Test;

import static org.assertj.core.api.Assertions.assertThat;
import java.util.List;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;
import org.springframework.test.annotation.Rollback;
import com.DxcTechnology.Entities.Projet;
import com.DxcTechnology.Entities.Role;
import com.DxcTechnology.Entities.Tache;
import com.DxcTechnology.Entities.User;
import com.DxcTechnology.Repository.*;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(false)
public class UserRepositoryTests {
	
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private TestEntityManager entityManager;
	
	@Autowired
	private ProjetRepository projetRepo;
	
	@Autowired
	private TacheRepository tacheRepo;
	

	@Test
	public void testCreateUser() {
		
		User user = new User();
		user.setNom("test3");
		user.setPrenom("test3");
		user.setCin("a746444");
		user.setTelephone("0689433212");
		user.setEmail("test3@gmail.com");
		user.setPassword("123456");
		user.setRole_user("Chef de Projet");
		user.setTitre("Ingenieur");
		user.setExperiance("Stagiaire");
		
		User SavedUser = userRepository.save(user);
		User ExistUser = entityManager.find(User.class, SavedUser.getId_user());
		assertThat(ExistUser.getEmail()).isEqualTo(user.getEmail());
	}
	
	@Test
	public void testFindByEmail() {
		String email = "absike@gmail.com";
		User user = userRepository.findByEmailandPass(email,"7/L9KyJokRRIJwjiw/FvXA==");
		if(user==null) {
			System.out.println("Compte trouver");
		}
		if(user!=null) {
			System.out.println("Compte non rouver");
		}
		assertThat(user).isNotNull();		
	}
	
	@Test
	public void testFindVerificationCode() {
		String code = "fCjIMHyazBWXpIORCwt5VxARLRtXVjkoXs0bnYea5ySiK2N6hbE3l2NCckYf1KdY";
		User user = userRepository.findByVerivicationCode(code);
		if(user==null) {
			System.out.println("code non trouver");
		}
		if(user!=null) {
			System.out.println("code trouver");
		}
		assertThat(user).isNotNull();
	}
	
	@Test
	public void findByCIN() {
		String cin = "a12345";
		User user = userRepository.findUserBymatricule(cin);
		if(user==null) {
			System.out.println("user non trouver");
		}
		if(user!=null) {
			System.out.println("user trouver");
		}
		assertThat(user).isNotNull();
	}
	
	@Test
	public void updatepwd() {
		userRepository.pwdUpdate("1995","test");
	}
	
	@Test
	public void showRoles() {
		try {
		List<Role> ListDesRoles = userRepository.ListeDesRoles();
		System.out.println(ListDesRoles);
		}catch(Exception e) {System.out.println("error in :"+e.getMessage());}
	}
	
	@Test
	public void findByNomPrenom() {
		User user = userRepository.selectParNomPrenom("a123456");
		if(user==null) {
			System.out.println("user non trouver");
		}
		if(user!=null) {
			System.out.println("user trouver");
		}
		assertThat(user).isNotNull();
	}
	
	
	@Test
	public void UpdateUser() {
	String cin = "test";	
		userRepository.UpdateUserByCin("test9","test9","test9", "0689433212","MANAGER","test9","Senior",cin);
	}
	
	@Test
	public void selectProjetcs() {
	String cin = "cintest3";	
	 List<Projet> listp = (List<Projet>) projetRepo.findBycin(cin);
		if(listp!=null) {
			System.out.println("trouver @@");
		}else {
			System.out.println("Non trouer");
		}
	}
	
	
	@Test
	public void selectP() {
	String cin = "cintest3";	
	 int listp = projetRepo.findPBycin(cin);
		System.out.println(listp);
		
	}
	
	
	@Test
	public void ShowList() {
		List<String> list1 = projetRepo.findTitres();
		System.out.println(list1);
	}
	
	@Test
	public void ShowEmp() {
		@SuppressWarnings("unused")
		List<User> list1 = userRepository.ListEmpl();
	}
	
	
	@Test
	public void addTache() {
//Tache tache = new Tache("Tache 2", ""2021, 01, 01, 2021, 01, 2, 8, 10, "En Attente", "slahmi mohamed", "Desc 1", 10, "Developpement");
//tacheRepo.save(tache);
	}
	
	public void findTACHEBycin() {
	
	List<Tache> Listetache = tacheRepo.findBycin("cintest3");
	if(Listetache==null) {
		System.out.println("Erreur in findTACHEBycin");
	}else {
		System.out.println(Listetache);
	}}

	
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	






















