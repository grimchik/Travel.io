package com.example.Travel.io.controllers;
import com.example.Travel.io.Model.Client;
import com.example.Travel.io.Model.GeoIP;
import com.example.Travel.io.Service.*;
import com.example.Travel.io.Storage.TokenStorage;
import com.example.Travel.io.token.JwtRequest;
import com.example.Travel.io.token.JwtUtil;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.*;
import java.text.AttributedString;

@Controller
@RequiredArgsConstructor
public class ClientController {
    private final GeoIPService geoIPService;
    private final HttpServletRequest request;
    private final TokenStorage tokenStorage;
    private final JwtUtil jwtUtil;
    private final AuthenticationManager authenticationManager;
    private final serviceClient serviceClient;
    @GetMapping("/")
    public String getmain()
    {
        return "mainPage";
    }
    @GetMapping("/hello")
    @PreAuthorize("isAuthenticated()")
    public String hello(Model model)
    {
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
            var longitude = location.getLongitude();
            var latitude = location.getLatitude();
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
                               Model model)
    {
        if (repeat_password.equals(password)&& serviceClient.isValidPassword(password) && serviceClient.isValidEmail(email)) {
            Client client = new Client(0, login, password, email, phone, true);
            System.out.println(client.getPassword());
            if (!serviceClient.createClient(client)) {
                model.addAttribute("errorMessage", "User with this login are exist!");
                return "registration";
            }
        }
        return "redirect:/login";
    }
    @PostMapping("/try-login")
    public String trylogin(@RequestParam String username, @RequestParam String password, Model model, RedirectAttributes redirectAttributes) {
        try {
            Authentication authentication =authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(username, password)
            );
            UserDetails userDetails = serviceClient.getClientByLogin(username);
            String token = jwtUtil.generateToken(userDetails);
            tokenStorage.setToken(token);
            SecurityContextHolder.getContext().setAuthentication(authentication);
            //redirectAttributes.addAttribute("token", token);

            return "redirect:/hello";
        } catch (AuthenticationException e) {
            model.addAttribute("errorMessage", "Invalid credentials. Please try again.");
            return "login";
        }
    }
}