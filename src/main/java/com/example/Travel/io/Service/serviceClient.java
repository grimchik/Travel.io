package com.example.Travel.io.Service;
import com.example.Travel.io.Model.*;
import com.example.Travel.io.Model.emuns.Role;
import com.example.Travel.io.repositories.ClientRepository;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class serviceClient
{
    private final ClientRepository clientRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public serviceClient(ClientRepository clientRepository, PasswordEncoder passwordEncoder) {
        this.clientRepository = clientRepository;
        this.passwordEncoder = passwordEncoder;
    }
    public String encode(String pas)
    {
        return passwordEncoder.encode(pas);
    }

    public Long count()
    {
        return clientRepository.count();
    }
    public boolean createClient (Client client)
    {
        if (clientRepository.findBylogin(client.getUsername()) != null) return false;
        client.setActive(true);
        client.setPassword(passwordEncoder.encode(client.getPassword()));
        client.getRoles().add(Role.ROLE_USER);
        clientRepository.save(client) ;
        return true;
    }
    public List<Client> getAllClients()
    {
        return clientRepository.findAll();
    }
    public Client getClientByLogin(String login)
    {
        return clientRepository.findBylogin(login);
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