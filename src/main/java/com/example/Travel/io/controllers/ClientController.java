package com.example.Travel.io.controllers;
import com.example.Travel.io.Model.*;
import com.example.Travel.io.Model.emuns.InviteStatus;
import com.example.Travel.io.Service.*;
import org.springframework.web.multipart.MultipartFile;
import com.example.Travel.io.Storage.TokenStorage;
import com.maxmind.geoip2.exception.GeoIp2Exception;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.*;
import java.security.Principal;
import java.text.AttributedString;
import java.util.ArrayList;

import java.util.Base64;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class ClientController {
    private int count =0;
    private static Client client;
    private static String latitude;
    private static String longitude;
    private static String base64Image;
    private final GeoIPService geoIPService;
    private final HttpServletRequest request;
    private final AuthenticationManager authenticationManager;
    private final serviceClient serviceClient;
    private final serviceTrip serviceTrip;
    @GetMapping("/")
    public String getmain()
    {
        return "mainPage";
    }
    @PostMapping("/upload-avatar")
    public ResponseEntity<String> uploadAvatar(@RequestParam("avatar") MultipartFile avatar) throws IOException {
        serviceClient.saveAvatar(client,avatar);
        return ResponseEntity.ok().body("Avatar uploaded successfully");
    }
    @GetMapping("/get_user_friends")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<List<ClientInfo>> getUserFriends(@RequestParam("userLogin") String userLogin) {
        List<ClientInfo> friends = new ArrayList<>();
        List<Client> clients = serviceClient.findFriendsByClientId(serviceClient.getClientByLogin(userLogin).getIdClient());
        for (Client clnt: clients)
        {
            ClientInfo clientInfo = new ClientInfo(clnt.getLogin(),Base64.getEncoder().encodeToString(clnt.getImage().getImage()));
            friends.add(clientInfo);
        }
        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(friends);
    }
    @GetMapping("/get_user_travels")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<List<TravelInfo>> getUserTravels(@RequestParam("userLogin") String userLogin) {
        List<TravelInfo> travels = new ArrayList<>();
        List<Trip> trips = serviceTrip.tripWithIdClient(serviceClient.getClientByLogin(userLogin).getIdClient());
        for (Trip trip: trips)
        {
            TravelInfo travelInfo = new TravelInfo(trip.getName());
            travels.add(travelInfo);
        }
        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(travels);
    }
    @GetMapping("/profile/{username}")
    @PreAuthorize("isAuthenticated()")
    public String userPage(@PathVariable String username, Model model)
    {
        if (serviceClient.getClientByLogin(username) != null) {
            Client client1 = serviceClient.getClientByLogin(username);
            var base64Image2 = client1.getImage().getImage();
            model.addAttribute("base64Image", Base64.getEncoder().encodeToString(base64Image2));
            if (username.equals(client.getLogin()))
            {
                return "profile";
            }
            List<Trip> travels = serviceTrip.tripWithIdClient(client1.getIdClient());
            List<TripInformation> tripInfo = new ArrayList<>();
            for (Trip trip: travels)
            {
                TripInformation tripIn = new TripInformation();
                tripIn.setAdministrator(trip.getAdministrator().getLogin());
                tripIn.setName(trip.getName());
                tripIn.setCount(serviceClient.allClientsForTrip(trip.getIdTrip()).size());
                tripInfo.add(tripIn);
            }
            model.addAttribute("travels", tripInfo);
            List<ClientInfo> friends = new ArrayList<>();
            List<Client> clients = serviceClient.findFriendsByClientId(client1.getIdClient());
            for (Client clnt: clients)
            {
                ClientInfo clientInfo = new ClientInfo(clnt.getLogin(),Base64.getEncoder().encodeToString(clnt.getImage().getImage()));
                friends.add(clientInfo);
            }
            model.addAttribute("friends", friends);
            return "userPage";
        }
        System.out.println("CHECK");
        return "error";
    }
    @GetMapping("/get_friends")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<List<ClientInfo>> getFriends() {
        List<ClientInfo> friends = new ArrayList<>();
        List<Client> clients = serviceClient.findFriendsByClientId(client.getIdClient());
        for (Client clnt: clients)
        {
            ClientInfo clientInfo = new ClientInfo(clnt.getLogin(),Base64.getEncoder().encodeToString(clnt.getImage().getImage()));
            friends.add(clientInfo);
        }
        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(friends);
    }
    @GetMapping("/get_travels")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<List<TravelInfo>> getTravels() {
        List<TravelInfo> travels = new ArrayList<>();
        List<Trip> travel = serviceTrip.tripWithIdClient(client.getIdClient());
        for (Trip clnt: travel)
        {
            TravelInfo clientInfo = new TravelInfo(clnt.getName());
            travels.add(clientInfo);
        }
        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(travels);
    }
    @GetMapping("/search")
    @ResponseBody
    public ResponseEntity<List<ClientInfo>> searchUsers(@RequestParam("query") String query) {
        List<Client> users = serviceClient.findByLoginContaining(query);
        List<ClientInfo> userInfoList = new ArrayList<>();
        var client1 = ClientController.getClient();
        for (Client user : users) {
            if (!serviceClient.findFriendsByClientId(client1.getIdClient()).contains(user)) {
                ClientInfo userInfo = new ClientInfo();
                userInfo.setLogin(user.getLogin());
                byte[] imageData = user.getImage().getImage();
                userInfo.setImage(Base64.getEncoder().encodeToString(imageData));
                if (!user.getLogin().equals(client.getLogin()))
                    userInfoList.add(userInfo);
            }
        }
        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_JSON)
                .body(userInfoList);
    }

    @GetMapping("/friend-invitations")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<List<ClientInfo>> getFriendInvitations() {
        Long id = client.getIdClient();
        List<Invite> invites = serviceClient.getInvitesByClientId(id);
        List<ClientInfo> userInfoList = new ArrayList<>();
        for (Invite inv: invites) {
            ClientInfo userInfo = new ClientInfo();
            userInfo.setLogin(inv.getFrom().getLogin());
            byte[] imageData = inv.getFrom().getImage().getImage();
            userInfo.setImage(Base64.getEncoder().encodeToString(imageData));
            if (!inv.getFrom().getLogin().equals(client.getLogin()))
            userInfoList.add(userInfo);
        }
        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_JSON)
                .body(userInfoList);
    }
    @PostMapping("/accept-friend")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<String> addFriend(@RequestBody Map<String, String> requestData) {
        String friendUsername = requestData.get("friendUsername");
        serviceClient.changeStatusInvite(InviteStatus.APPROVE,client.getLogin(),friendUsername);
        return ResponseEntity.ok("Пользователь " + friendUsername + " успешно добавлен в друзья.");
    }

    @PostMapping("/reject-invitation")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<String> rejectInvitation(@RequestBody Map<String, String> requestData) {
        String friendUsername = requestData.get("friendUsername");
        serviceClient.changeStatusInvite(InviteStatus.DECLINE,client.getLogin(),friendUsername);
        return ResponseEntity.ok("Приглашение от пользователя " + friendUsername + " успешно отклонено.");
    }
    public static Client getClient()
    {
        return client;
    }

    @PostMapping("/addFriend")
    @PreAuthorize("isAuthenticated()")
    @Transactional
    public ResponseEntity<String> addFriend(@RequestBody String username) {
        boolean success = serviceClient.addFriend(client.getLogin(), username);
        if (success) {
            return ResponseEntity.ok("User added to friends successfully!");
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("User doesn't added to friends successfully!");
        }
    }


    @GetMapping("/hello")
    @PreAuthorize("isAuthenticated()")
    public String hello(Model model, Principal principal)
    {
        if (principal != null) {
            model.addAttribute("isAuthenticated", true);
            model.addAttribute("username", principal.getName());
            String username = client.getLogin();
            model.addAttribute("username", username);
            Long idValue = client.getIdClient();
            Long id = idValue;
            var image = serviceClient.findImage(id);
            if (image != null) {
                byte[] imageData = image.getImage();
                base64Image = Base64.getEncoder().encodeToString(imageData);
                model.addAttribute("base64Image", base64Image);
            }
        }
        else {
            model.addAttribute("isAuthenticated", false);
        }

        String ipAddress ="";
        String urlString = "http://checkip.amazonaws.com/";
        try {
            URL url = new URL(urlString);
            try (BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()))) {
                ipAddress= br.readLine();
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            GeoIP location = geoIPService.getLocation(ipAddress);
            longitude = location.getLongitude();
            latitude = location.getLatitude();
            model.addAttribute("longitude", longitude );
            model.addAttribute("latitude", latitude);
        } catch (IOException | GeoIp2Exception e) {
            e.printStackTrace();
        }
        return "hello";
    }

    @GetMapping("/login")
    public String getlogin()
    {
        return "login";
    }
    @GetMapping("/registration")
    public String getregistration()
    {
        return "registration";
    }

    @PostMapping("/tryregistration")
    public String createClient(@RequestParam String login,
                               @RequestParam String password,
                               @RequestParam String repeat_password,
                               @RequestParam String email,
                               Model model) throws IOException {
        if (repeat_password.equals(password)&& serviceClient.isValidPassword(password) && serviceClient.isValidEmail(email)) {
            Client client = new Client(0, login, password, email, true);
            client.setDefaultAvatar();
            if (!serviceClient.createClient(client)) {
                model.addAttribute("errorMessage", "User with this login are exist!");
                return "registration";
            }
            return "redirect:/login";
        }
        return "registration";
    }
    @GetMapping("/your-travels")
    @PreAuthorize("isAuthenticated()")
    public String yourTravels(Model model) {
        List<Trip> travels = serviceTrip.tripWithIdClient(client.getIdClient());
        List<TripInformation> tripInfo = new ArrayList<>();
        for (Trip trip: travels)
        {
            TripInformation tripIn = new TripInformation();
            tripIn.setAdministrator(trip.getAdministrator().getLogin());
            tripIn.setName(trip.getName());
            tripIn.setCount(serviceClient.allClientsForTrip(trip.getIdTrip()).size());
            tripInfo.add(tripIn);
        }
        model.addAttribute("travels", tripInfo);
        model.addAttribute("base64Image", base64Image);
        return "your-travels";
    }

    @GetMapping("/delete-travel")
    @PreAuthorize("isAuthenticated()")
    @Transactional
    public String deleteTravel(@RequestParam("travelId") String name) {
        List<Client> clients = serviceClient.allClientsForTrip(serviceTrip.findByName(name).getIdTrip());
        for (Client client: clients)
        {
            serviceTrip.deleteTrip(client.getIdClient(),serviceTrip.findByName(name).getIdTrip());
        }
        serviceTrip.deleteByName(name);
        return "redirect:/your-travels";
    }

    @GetMapping("/friends-list")
    @PreAuthorize("isAuthenticated()")
    public String friendsList(Model model) {
        model.addAttribute("base64Image", base64Image);
        List<ClientInfo> friends = new ArrayList<>();
        List<Client> clients = serviceClient.findFriendsByClientId(client.getIdClient());
        for (Client clnt: clients)
        {
            ClientInfo clientInfo = new ClientInfo(clnt.getLogin(),Base64.getEncoder().encodeToString(clnt.getImage().getImage()));
            friends.add(clientInfo);
        }
        model.addAttribute("friends", friends);
        return "friends-list";
    }
    @GetMapping("/delete-friend")
    @PreAuthorize("isAuthenticated()")
    @Transactional
    public String deleteFriend(@RequestParam("friendLogin") String name) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentUsername = authentication.getName();
        Client currentUser = serviceClient.getClientByLogin(currentUsername);
        Client friend = serviceClient.getClientByLogin(name);
        currentUser.getFriends().remove(friend);
        if (serviceClient.deleteInvite(name,currentUsername).isPresent())
        {
            serviceClient.deleteById(serviceClient.deleteInvite(name,currentUsername).get().getId());
        }
        else
        {
            serviceClient.deleteById(serviceClient.deleteInvite(currentUsername,name).get().getId());
        }
        friend.getFriends().remove(currentUser);
        serviceClient.save(currentUser);
        serviceClient.save(friend);
        return "redirect:/friends-list";
    }
    @GetMapping("/newtravel")
    @PreAuthorize("isAuthenticated()")
    public String newTravel(Model model) {
        model.addAttribute("longitude", longitude );
        model.addAttribute("latitude", latitude);
        model.addAttribute("base64Image", base64Image);
        return "newtravel";
    }
    @GetMapping("/profile")
    @PreAuthorize("isAuthenticated()")
    public String profile(Model model) {
        model.addAttribute("base64Image", base64Image);
        return "profile";
    }
    @PostMapping("/try-login")
    public String trylogin(@RequestParam String username, @RequestParam String password, Model model, RedirectAttributes redirectAttributes) {
        try {
            Authentication authentication =authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(username, password)
            );
            client = serviceClient.getClientByLogin(username);
            SecurityContextHolder.getContext().setAuthentication(authentication);
            return "redirect:/hello";
        } catch (AuthenticationException e) {
            model.addAttribute("errorMessage", "Invalid credentials. Please try again.");
            return "login";
        }
    }
}