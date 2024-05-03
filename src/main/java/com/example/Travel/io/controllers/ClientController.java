package com.example.Travel.io.controllers;
import com.example.Travel.io.Model.Client;
import com.example.Travel.io.Model.GeoIP;
import com.example.Travel.io.Model.Invite;
import com.example.Travel.io.Model.emuns.InviteStatus;
import com.example.Travel.io.Service.*;
import com.example.Travel.io.Storage.TokenStorage;
import com.maxmind.geoip2.exception.GeoIp2Exception;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.*;
import java.text.AttributedString;
import java.util.Base64;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class ClientController {
    private static Client client;
    private static String latitude;
    private static String longitude;
    private static String base64Image;
    private final GeoIPService geoIPService;
    private final HttpServletRequest request;
    private final AuthenticationManager authenticationManager;
    private final serviceClient serviceClient;
    @GetMapping("/")
    public String getmain()
    {
        return "mainPage";
    }

    @GetMapping("/search")
    public ResponseEntity<List<Client>> searchUsers(@RequestParam("query") String query) {
        // Выполнить поиск пользователей в базе данных по частичному совпадению логина
        List<Client> users = serviceClient.findByLoginContaining(query);
        return ResponseEntity.ok(users);
    }
    @GetMapping("/friend-invitations")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<List<Invite>> getFriendInvitations() {
        Long id = client.getIdClient();
        List<Invite> invites = serviceClient.getInvitesByClientId(id);
        return ResponseEntity.ok(invites);
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

    @PostMapping("/addFriend")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<String> addFriend(@RequestBody String username) {
        boolean success = serviceClient.addFriend(client.getLogin(), username);
        if (success) {
            return ResponseEntity.ok("User added to friends successfully!");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to add user to friends.");
        }
    }


    @GetMapping("/hello")
    @PreAuthorize("isAuthenticated()")
    public String hello(Model model)
    {
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
        String ipAddress ="";
        String urlString = "http://checkip.amazonaws.com/";
        try {
            URL url = new URL(urlString);
            try (BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()))) {
                ipAddress= br.readLine();
            }
        } catch (MalformedURLException e) {
            e.printStackTrace(); // Обработка ошибки URL
        } catch (IOException e) {
            e.printStackTrace(); // Обработка ошибки ввода-вывода при работе с URL
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
                               @RequestParam String phone,
                               Model model) throws IOException {
        if (repeat_password.equals(password)&& serviceClient.isValidPassword(password) && serviceClient.isValidEmail(email)) {
            Client client = new Client(0, login, password, email, phone, true);
            client.setDefaultAvatar();
            System.out.println(client.getPassword());
            if (!serviceClient.createClient(client)) {
                model.addAttribute("errorMessage", "User with this login are exist!");
                return "registration";
            }
            return "redirect:/login";
        }
        System.out.println(serviceClient.isValidPassword(password) && serviceClient.isValidEmail(email));
        return "registration";
    }
    @GetMapping("/newtravel")
    @PreAuthorize("isAuthenticated()")
    public String newTravel(Model model) {
        model.addAttribute("longitude", longitude );
        model.addAttribute("latitude", latitude);
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