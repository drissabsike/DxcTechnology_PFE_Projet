package com.DxcTechnology.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DxcTechnology.Entities.Client;
import com.DxcTechnology.Repository.ClientRepository;

@Service
public class ClientServiceIMPL implements ClientService{

	
	@Autowired
	private ClientRepository cr;
	
	@Override
	public String CreationClient(Client c) {
		cr.save(c);
		return "Client added !";
		}

	@Override
	public List<Client> listClients() {
		return cr.findAll();
	}

	@Override
	public int CountNbrClient() {
		int  i =cr.CountAllClient();
		return i;
	}

	@Override
	public List<Client> FindClientByKeywoard(String key) {
		List<Client> k = cr.FindClientByKeywoard(key);
		return k;
	}

	/*@Override
	public List<Client> listClientsByClient(String name) {
		// TODO Auto-generated method stub
		return cr.;
	}*/

}
