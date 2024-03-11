package com.example.Travel.io.controllers;

import com.example.Travel.io.repositories.ClientRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import com.example.Travel.io.Model.*;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.io.Console;

@Controller
@RequiredArgsConstructor
public class RegistrationControllers {
    @Autowired
    private ClientRepository clientRepository;
    @GetMapping("/registration")
    public String registrationPage() {
        return "registration";
    }
    @PostMapping("/tryregistration")
    public String registration(@RequestParam String login,
                               @RequestParam String password,
                               @RequestParam String repeat_password,
                               @RequestParam String email,
                               @RequestParam String phone) {
        System.out.println(login);
        System.out.println(password);
        System.out.println(email);
        System.out.println(phone);
        Client client = new Client(0,login, password, email, phone);
        clientRepository.save(client);
        return "redirect:/mainPage";
    }
}
