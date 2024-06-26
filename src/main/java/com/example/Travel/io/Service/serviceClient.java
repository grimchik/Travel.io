package com.example.Travel.io.Service;
import com.example.Travel.io.Model.*;
import com.example.Travel.io.Model.Image;
import com.example.Travel.io.Model.emuns.InviteStatus;
import com.example.Travel.io.Model.emuns.Role;
import com.example.Travel.io.repositories.ClientRepository;
import com.example.Travel.io.repositories.ImageRepository;
import com.example.Travel.io.repositories.InviteRepository;
import com.nimbusds.jose.shaded.json.JSONObject;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.transaction.Transactional;
import java.io.IOException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@Slf4j
public class serviceClient
{
    private static String PASSWORD_PATTERN = "(?=.*[0-9])(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*]{6,100}";
    private static final String EMAIL_PATTERN = "^[_A-Za-z0-9-+]+(.[_A-Za-z0-9-]+)*@" + "[A-Za-z0-9-]+(.[A-Za-z0-9]+)*(.[A-Za-z]{2,150})$";
    private final ClientRepository clientRepository;
    private final ImageRepository imageRepository;
    private final InviteRepository inviteRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public serviceClient(InviteRepository inviteRepository,ImageRepository imageRepository, ClientRepository clientRepository, PasswordEncoder passwordEncoder) {
        this.clientRepository = clientRepository;
        this.imageRepository=imageRepository;
        this.passwordEncoder = passwordEncoder;
        this.inviteRepository=inviteRepository;
    }
    public String encode(String pas)
    {
        return passwordEncoder.encode(pas);
    }

    public Long count()
    {
        return clientRepository.count();
    }
    @Transactional
    public boolean createClient (Client client)
    {
        if (clientRepository.findBylogin(client.getUsername()) != null) return false;
        client.setActive(true);
        client.setPassword(passwordEncoder.encode(client.getPassword()));
        client.getRoles().add(Role.ROLE_USER);
        if (client.getPassword().equals("") ||client.getMail().equals("") || client.getLogin().equals(""))
        return false;
        else {clientRepository.save(client) ; return true;}
    }
    public Client getClientByEmail (String str) {return clientRepository.findBymail(str);}
    public void saveImage(Client client, MultipartFile avatar) throws IOException {
        Image image;
        if (avatar.getSize() !=0)
        {
            image= toImage(avatar);
        }
    }
    public List<Client> findFriendsByClientId(Long id) {
        return clientRepository.findFriendsById(id);
    }
    public Image toImage(MultipartFile avatar) throws IOException
    {
        Image image= new Image();
        image.setName(avatar.getName());
        image.setOriginalFileName(avatar.getOriginalFilename());
        image.setContentType(avatar.getContentType());
        image.setSize(avatar.getSize());
        image.setImage(avatar.getBytes());
        return image;
    }
    public Image findImage(Long id)
    {
        return imageRepository.findByClientIdClient(id);
    }
    public void updateAvatar(Integer client, Image ima)
    {
     var params = new MapSqlParameterSource();
     params.addValue("id",ima.getId());
     params.addValue("content_type",ima.getContentType());
     params.addValue("image",ima.getImage());
     params.addValue("name",ima.getName());
     params.addValue("original_file",ima.getOriginalFileName());
     params.addValue("size",ima.getSize());
     params.addValue("client_id_client",client);
     JdbcTemplate jdbcTemplate= new JdbcTemplate();
     jdbcTemplate.update("update images where set id = :id, content_type =:content_type, image = :image, name =: name,original_file = :original_file, size = :size,client_id_client =: client_id_client ",params);
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
    public void save(Client client){clientRepository.save(client);}
    public boolean isValidEmail(String email){
        return (validateEmail(email));
    }
    private boolean validateEmail(String email) {
        Pattern pattern = Pattern.compile(EMAIL_PATTERN);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }
    public void deleteById(Long id) {inviteRepository.deleteById(id);}
    public Optional<Invite> deleteInvite(String from, String to){return inviteRepository.findByFromLoginAndToLogin(from, to);}
    @Transactional
    public void changeStatusInvite(InviteStatus status, String to, String from)
    {
        Client fromClient = clientRepository.findBylogin(from);
        Client toClient = clientRepository.findBylogin(to);
        Invite friendshipExists = inviteRepository.findByFromLoginAndToLogin(from, to).get();
        if (status == InviteStatus.DECLINE)
        {
            friendshipExists.setStatus(InviteStatus.DECLINE);
            inviteRepository.updateInviteStatusBetweenUsers(fromClient,toClient,InviteStatus.DECLINE);
        }
        else
        {
            friendshipExists.setStatus(InviteStatus.APPROVE);
            inviteRepository.updateInviteStatusBetweenUsers(fromClient,toClient,InviteStatus.APPROVE);
            fromClient.getFriends().add(toClient);
            toClient.getFriends().add(fromClient);
            clientRepository.save(fromClient);
            clientRepository.save(toClient);
        }
    }
    @Transactional
    public void saveAvatar(Client client, MultipartFile avatar) throws IOException {
        Image image = new Image();
        var name = avatar.getName();
        var originalFileName = avatar.getOriginalFilename();
        var contentType = avatar.getContentType();
        var size = avatar.getSize();
        var imageData = avatar.getBytes(); // Получение массива байтов изображения

        image.setName(name);
        image.setOriginalFileName(originalFileName);
        image.setContentType(contentType);
        image.setSize(size);
        image.setImage(imageData);
        image.setClient(client);

        imageRepository.updateImageByIdClient(
                client.getIdClient(),
                name,
                originalFileName,
                contentType,
                size,
                imageData
        );
    }
    @Transactional
    public List<Client> findByLoginContaining(String login)
    {
        return clientRepository.findByLoginContaining(login);
    }

    public boolean addFriend(String from,String to) {
            int startIndex = to.indexOf(":") + 2;
            int endIndex = to.lastIndexOf("\"");
            String username = to.substring(startIndex, endIndex);
            to = username;
        Client fromClient = clientRepository.findBylogin(from);
        Client toClient = clientRepository.findBylogin(to);
        if (inviteRepository.findByFromLoginAndToLogin(from, to).isPresent())
        {
            Invite friendshipExists = inviteRepository.findByFromLoginAndToLogin(from, to).get();
            if (friendshipExists.getStatus() == InviteStatus.PENDING)
            {
                return false;
            }
            else
            {
                inviteRepository.updateInviteStatusBetweenUsers(fromClient,toClient,InviteStatus.PENDING);
                return true;
            }
        }
        else if (inviteRepository.findByFromLoginAndToLogin(to,from).isPresent())
        {
            Invite friendshipExists = inviteRepository.findByFromLoginAndToLogin(to,from).get();
            if (friendshipExists.getStatus() == InviteStatus.PENDING)
            {
                return false;
            }
            if (friendshipExists.getStatus() == InviteStatus.DECLINE)
            {
                inviteRepository.updateInviteStatusBetweenUsers(fromClient,toClient,InviteStatus.PENDING);
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            Invite invite = new Invite();
            invite.setFrom(fromClient);
            invite.setTo(toClient);
            invite.setStatus(InviteStatus.PENDING);
            inviteRepository.save(invite);
            return true;
        }
    }
    public boolean isValidPassword(String password){
        return validatePassword(password);
    }
    private boolean validatePassword(String password) {
        Pattern pattern = Pattern.compile(PASSWORD_PATTERN);
        Matcher matcher = pattern.matcher(password);
        return matcher.matches();
    }
    public List<Client> allClientsForTrip(Integer id){return clientRepository.findAllClientsForTrip(id);}
    public List<Invite> getInvitesByClientId(Long id) {
    List<Invite> inv= inviteRepository.findByTo(clientRepository.findById(id).get());
    List<Invite> invites = new ArrayList<Invite>();
        for (Invite invite : inv) {
            if (invite.getStatus() == InviteStatus.PENDING) {
                invites.add(invite);
            }
        }
        return invites;
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