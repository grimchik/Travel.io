package com.example.Travel.io.controllers;
import com.example.Travel.io.repositories.ClientRepository;
import com.example.Travel.io.Model.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
@Controller
@RequiredArgsConstructor
public class AuthorizationControllers {
    private ClientRepository clientRepository;
    @GetMapping("/")
    public String loginPage() {
        return "login";
    }
    @GetMapping("/mainPage")
    public String mainPage() {
        return "mainPage";
    }
    @PostMapping("/submit-login")
    public String submitLogin(String username, String password)
    {
            return  "redirect:/registration";
    }
    @PostMapping("/submit-registration")
    public String registration()
    {
        return "redirect:/registration";
    }
}