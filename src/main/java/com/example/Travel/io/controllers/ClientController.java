package com.example.Travel.io.controllers;
import com.example.Travel.io.Model.Client;
import com.example.Travel.io.Service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;

@Controller
@RequiredArgsConstructor
public class ClientController {
    private final serviceClient serviceClient;
    @GetMapping("/")
    public String getmain()
    {
        return "mainPage";
    }
    @GetMapping("/login")
    public String getlogin()
    {
        return "login";
    }
   @PostMapping("/tryregistration")
    public String createClient(@RequestParam String login,
                               @RequestParam String password,
                               @RequestParam String repeat_password,
                               @RequestParam String email,
                               @RequestParam String phone,
                               Model model)
    {
        if (repeat_password.equals(password)) {
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
    public String trylogin(@RequestParam String username,
                           @RequestParam String password,
                           Model model)
    {
     if (!serviceClient.getClientByLogin(username).equals(serviceClient.encode(password)))
     {
         return "login";
     }
     return "redirect:/hello";
    }
    @GetMapping("/registration")
    public String registrate()
    {
        return "registration";
    }
}
