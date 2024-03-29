package com.example.Travel.io.token;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class JwtRequest {
    @Getter
    @Setter
    private String login;
    @Getter
    @Setter
    private String password;
}