package com.DxcTechnology.Service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.DxcTechnology.Entities.Client;

@Service
public interface ClientService {

	
	public String CreationClient(Client client);
	
	public List<Client> listClients();
	
	//public List<Client> listClientsByClient(String name);
	
	public int CountNbrClient();
	
	public List<Client> FindClientByKeywoard(String key);
	
}
