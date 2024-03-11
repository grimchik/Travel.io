package com.example.Travel.io.Service;
import com.example.Travel.io.Model.*;
import com.example.Travel.io.repositories.ClientRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
@Service
@RequiredArgsConstructor
@Slf4j
public class serviceClient {
    private final ClientRepository clientRepository;
    private ArrayList<Client> clients;
    public ArrayList<Client> getClients() {
        return clients;
    }
    public void saveClient(Client client) {
        clientRepository.save(client);
    }
    public Client getClient(Long id) {
        return clientRepository.findById(id).orElse(null);
    }
    public void deleteClient(Long id) {
        //clients.removeIf(client -> client.getidClient() == id);
    }
}