package com.example.Travel.io.Model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Base64;

@AllArgsConstructor
@NoArgsConstructor
public class ClientInfo {
    @Getter
    @Setter
    private String login;
    @Getter
    @Setter
    private String image;
}
