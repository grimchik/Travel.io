package com.example.Travel.io.controllers;

import com.example.Travel.io.repositories.ClientRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import com.example.Travel.io.Model.*;
import com.example.Travel.io.Service.*;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.io.Console;

@Controller
@RequiredArgsConstructor
public class RegistrationControllers {
}
