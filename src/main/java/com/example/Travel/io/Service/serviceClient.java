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
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@Slf4j
public class serviceClient
{
    private static String PASSWORD_PATTERN = "(?=.*[0-9])(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*]{6,100}";
    private static final String EMAIL_PATTERN = "^[_A-Za-z0-9-+]+(.[_A-Za-z0-9-]+)*@" + "[A-Za-z0-9-]+(.[A-Za-z0-9]+)*(.[A-Za-z]{2,150})$";
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
        if (client.getPassword().equals("") ||client.getMail().equals("") || client.getPhoneNumber().equals("") || client.getLogin().equals(""))
        return false;
        else {clientRepository.save(client) ; return true;}
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
    public boolean isValidEmail(String email){
        return (validateEmail(email));
    }
    private boolean validateEmail(String email) {
        Pattern pattern = Pattern.compile(EMAIL_PATTERN);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }
    public boolean isValidPassword(String password){
        return validatePassword(password);
    }
    private boolean validatePassword(String password) {
        Pattern pattern = Pattern.compile(PASSWORD_PATTERN);
        Matcher matcher = pattern.matcher(password);
        return matcher.matches();
    }
   /* public boolean isValidPhone(String phone){
        return (validateEmail(phone));
    }
    private boolean validatePhone(String phone) {
        Pattern pattern = Pattern.compile(PHONE_PATTERN);
        Matcher matcher = pattern.matcher(phone);
        return matcher.matches();
    }*/
}