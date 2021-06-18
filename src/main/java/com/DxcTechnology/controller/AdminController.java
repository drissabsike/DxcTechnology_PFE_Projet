package com.DxcTechnology.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import com.DxcTechnology.Entities.EncryptionDemo;
import com.DxcTechnology.Entities.Experiance;
import com.DxcTechnology.Entities.Projet;
import com.DxcTechnology.Entities.Role;
import com.DxcTechnology.Entities.Tache;
import com.DxcTechnology.Entities.User;
import com.DxcTechnology.Repository.TacheRepository;
import com.DxcTechnology.Repository.UserRepository;
import com.DxcTechnology.Service.ClientService;
import com.DxcTechnology.Service.ProjetService;
import com.DxcTechnology.Service.UserService;
import com.DxcTechnology.Service.UserServiceMailing;
import com.DxcTechnology.Service.Utility;

import net.bytebuddy.utility.RandomString;

@Controller
public class AdminController {

	@Autowired
	private UserService userreMetier;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private UserServiceMailing userser;
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private ProjetService projetMetier;
	
	@Autowired
	private TacheRepository tacheRepo;
	
	@Autowired
	private ClientService cl;
	
	@RequestMapping("404")
	public String ErreurPage404() {
		return "/MANAGER/ErreurPage/404";
	}
	
	
	@GetMapping("/motdepasseOublie")
	public String showForgorPassword() {
		return "/motdepasseOublie";
	}
	
	@RequestMapping("/ADMIN/doLogout")
	public String doLogout(HttpServletRequest request,SessionStatus status) {	
		 HttpSession session = request.getSession(false);
		    if (session != null) {
		    	status.setComplete();
		        session.invalidate();
		    }
		    return "redirect:/loginPage"; 
	}	
	
	@RequestMapping("/MANAGER/DashboardMANAGER")
	public String showDashboardMANAGER(Model model,HttpSession session) {
		String cin = (String) session.getAttribute("cin");
       if(cin==null) {
			return "redirect:/loginPage";
		}
		int nbrP = projetMetier.findPBycin(cin);
		int nbrE = tacheRepo.getEMP();
		int nbt = tacheRepo.getTach(cin);
		List<User> listU = userreMetier.getUserExp();
		System.out.println(listU);
		model.addAttribute("listU", listU);
		String sumP = tacheRepo.getSUMPro(cin);
		session.setAttribute("nbrP", nbrP);
		session.setAttribute("nbrE", nbrE);
		session.setAttribute("nbt", nbt);
		session.setAttribute("sumP", sumP);
		return "/MANAGER/DashboardMANAGER";
	}
	

	@RequestMapping("/register")
	public String ShowRegisterPage(@ModelAttribute("Role") Role role,HttpSession session,@Param("nom1") String nom,
			@ModelAttribute("Experiance") Experiance experiance, Model model) {
		model.addAttribute("user",new User());
        session.setAttribute("nom1",nom);
		return "Signup_Form";
	} 

	@RequestMapping("/ADMIN/process_register")
	public String ProcessRegistration(Model model,User user,@RequestParam(value = "nom") String nom,HttpServletRequest request,
			@RequestParam(value = "prenom") String prenom,
			@RequestParam(value = "cin") String cin,
			@RequestParam(value = "telephone") String telephone,
			@RequestParam(value = "email") String email,
			@RequestParam(value = "password") String password,
			@RequestParam(value = "titre") String titre,
			@RequestParam(value = "role_user") String role_user,
			@RequestParam(value = "experiance") String experiance,
			@RequestParam(value = "file") MultipartFile file) throws Exception {
			User x = userRepo.findByEmail(email);
			String url = "";
			if(x!=null){
				System.out.println("The same emails");
				System.out.println(x);
				url = "/ErreursPages/PageDerreur";
			}
			if(x==null) {
				System.out.println("This is not same emails");
				System.out.println(x);	
				
				 String k = "Bar12345Bar12345";
				 //SecretKey key = KeyGenerator.getInstance("AES").generateKey();
			        SecretKey key = new SecretKeySpec(k.getBytes(), "AES");
			        EncryptionDemo encrypter = new EncryptionDemo(key);
			        String encrypted = encrypter.encrypt(user.getPassword());
				
			        String image_path = "D:\\DXC\\Projet\\DxcTechnology-1_V14\\DxcTechnology-1\\src\\main\\webapp\\image_profile\\";
					String image_path2 = "image_profile/"+nom+"_"+prenom+".png";
					file.transferTo(new File(image_path+nom+"_"+prenom+".png"));
			        
				//la date de creation user
			    user.setNom(nom);
			    user.setPrenom(prenom);
			    user.setCin(cin);
			    user.setTelephone(telephone);
			    user.setEmail(email);
			    user.setPassword(encrypted);
				user.setTitre(titre);
				user.setRole_user(role_user);
				user.setExperiance(experiance);
				//generation du token
				String randomCode = RandomString.make(64);
				user.setActivation_code(randomCode);
				user.setImage_path(image_path2);
			    user.setDate_creation(new Date());		
			    user.setMatricule(nom.substring(0,2)+"_"+prenom.substring(0,2)+"_"+cin.substring(0,3)+"_"+role_user.substring(0,3));
			    userRepo.save(user);
				String sitURL = Utility.getSiteURL(request);
				sendVerificationEmail(user,sitURL);
				model.addAttribute("success","l'utilisateur a été ajouté avec succès");
				url = "/ADMIN/Signup_Form";
			}
			return url;
	}
	
	@GetMapping("/activate")
	public String verifyCompte(@Param("code") String code, Model model) {
		String url ="";
		boolean verifier = userser.verify(code);
		if(verifier==true) {
			url ="/ValidePages/felisitationPage";
		}else {
			url="/ValidePages/Page202";
		}
		return url;
	}
	
	//Code envoie dMail
	public void sendVerificationEmail(User user,String siteURL) throws UnsupportedEncodingException, MessagingException {
		String subject = "S'il vous plaît activer votre compte ";
		String senderName ="Equipe_projet DXCTechnology Maroc";
		String mailContent = "<p>Cher Utilisateur "+user.getNom()+" "+user.getPrenom()+", Votre Matricule est: "+user.getMatricule()+"</p>";
			   mailContent +="<p>Cliquez sur le lien ci-dessous pour activer votre compte:</p>";
			   String verifyURL = siteURL+"/activate?code="+user.getActivation_code();
			   mailContent +="<h3><a href=\"" + verifyURL + "\">Activate</a></h3>";
			   mailContent +="<img height=\"30%\" width=\"30%\" src=\"https://www.leconomiste.com/sites/default/files/eco7/public/thumbnails/image/dxc_technology_logo_ex_hp-cdg_trt.jpg\">";
			   mailContent +="<p>Merci<br>Equipe_projet DXCTechnology Maroc<br>Technopolis, Batiment B9، Rabat 11100</p>";
			   MimeMessage message = mailSender.createMimeMessage();
			   MimeMessageHelper helper = new MimeMessageHelper(message);
			   helper.setFrom("absikeidriss25@gmail.com",senderName);
			   helper.setTo(user.getEmail());
			   helper.setSubject(subject);
			   helper.setText(mailContent, true);
			   mailSender.send(message);
	}


	@RequestMapping("/ADMIN/Signup_Form")
	public String showFelisitationPage(HttpSession session) {
		String cin = (String) session.getAttribute("cin");
		if(cin==null) {
			return "redirect:/loginPage";
		}
		return "/ADMIN/Signup_Form";
	}
	
	@RequestMapping("/Register_success")
	public String showRegister_success() {
		return "/Register_success";
	}
	
	
	@RequestMapping("/ADMIN/DashboardAdmin")
	public String showAdminPage(Model model,@Param("nom1") String nom,@Param("prenom1") String prenom,HttpSession session) {
		String cin = (String) session.getAttribute("cin");
		if(cin==null) {
			return "redirect:/loginPage";
		}
		int nbrP = projetMetier.findAllp();
		int NbE = userreMetier.NbrEmpl();
		int NbM = userreMetier.NbrMng();
		int NbC = cl.CountNbrClient();
		session.setAttribute("nbrP", nbrP);
		session.setAttribute("NbE", NbE);
		session.setAttribute("NbM", NbM);
		session.setAttribute("NbC", NbC);
		session.setAttribute("nom2",nom);
		session.setAttribute("prenom2",prenom);
		return "/ADMIN/DashboardAdmin";
	}
	
	@RequestMapping("/ADMIN/EditUser")
	public String showEditUserPage(Model model,@Param("cin") String cin,HttpSession session) {
		String cin2 = (String) session.getAttribute("cin");
		if(cin2==null) {
			return "redirect:/loginPage";
		}
		session.setAttribute("cin",cin);
        User user = userreMetier.selectParNomPrenom(cin);
        model.addAttribute("user",user);
		return "/ADMIN/EditUser";
	}
	
	@RequestMapping("/ADMIN/AcitveUser")
	public String UserActive(Model model,@Param("cin") String cin,
			@Param("nom2") String nom2,HttpSession session) {
		session.setAttribute("nom2",nom2);
		session.setAttribute("cin",cin);
		User user = userreMetier.findUserByCIN(cin);
		System.out.println(nom2);
		if(user.getActivation()==0) {
			System.out.println(user.getActivation());
			userreMetier.ActiveUpdate(cin);
		}
		if(user.getActivation()==1){
			System.out.println(user.getActivation());
			userreMetier.DesativeUpdate(cin);
		}
		return "redirect:/ADMIN/ListUsers?nom="+nom2;
	}
	
	@RequestMapping("/ADMIN/ListUsers")
	public String showListUsers(String keyword,Model model,@Param("nom2") String nom,@Param("prenom2") String prenom,HttpSession session) {
		String cin2 = (String) session.getAttribute("cin");
		if(cin2==null) {
			return "redirect:/loginPage";
		}
		session.setAttribute("nom2",nom);
		//System.out.println(keyword);
		if(keyword==null) {
			List<User> listUsers = userreMetier.listUsers();
			model.addAttribute("listUsers",listUsers);
		}else {
			List<User> listUsers = userRepo.FindEmplByKeywoard(keyword);
			model.addAttribute("listUsers",listUsers);
		}
		return "/ADMIN/ListUsers";
	}
	
	@RequestMapping("/ADMIN/process_EditUser")
	public String UpdateUser(User user,@Param("nom2") String nom2,@Param("cin") String cin,
			@RequestParam(value = "nom") String nom,
			@RequestParam(value = "prenom") String prenom,
			@RequestParam(value = "cin2") String cin2,
			@RequestParam(value = "telephone") String telephone,
			@RequestParam(value = "titre") String titre,
			@RequestParam(value = "role_user") String role_user,
			@RequestParam(value = "experiance") String experiance) {
		System.out.println(cin);
		System.out.println(nom2);
		userreMetier.UpdateUserByCin(nom, prenom, cin2, telephone, titre, role_user, experiance, cin);
		return "redirect:/ADMIN/ListUsers?nom="+nom2;
	}
	
	@RequestMapping("/ADMIN/ListProjets")
	public String showListProjets(Model model,String keyword,HttpSession session) {
		String cin2 = (String) session.getAttribute("cin");
		if(cin2==null) {
			return "redirect:/loginPage";
		}
		if(keyword==null) {
			List<Projet> ListProjets = projetMetier.findAllP();
			model.addAttribute("ListProjets",ListProjets);
		}else {
			List<Projet> ListProjets = projetMetier.FindProjetByKeywoard(keyword);
			model.addAttribute("ListProjets",ListProjets);
		}
		return "/ADMIN/ListProjets";
	}
	
	@RequestMapping("/ADMIN/ListTaches")
	public String showListTaches(Model model,String keyword, HttpSession session) {
		String cin2 = (String) session.getAttribute("cin");
		if(cin2==null) {
			return "redirect:/loginPage";
		}
		if(keyword==null) {
			List<Tache> ListTaches = tacheRepo.findAll();
			model.addAttribute("ListTaches",ListTaches);
		}else {
			List<Tache> ListTaches = tacheRepo.FindTacheByKeywoard(keyword);
			model.addAttribute("ListTaches",ListTaches);
		}
		return "/ADMIN/ListTaches";
	}
	
}
	





























