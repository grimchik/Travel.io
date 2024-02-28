package com.example.Travel.io.controllers;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProductControllers {
    @GetMapping("/")
    public String products()
    {
        return "products";
    }
}
