package com.example.Travel.io.Storage;

import com.example.Travel.io.token.JwtUtil;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Data
@Component
public class TokenStorage {
    @Getter
    @Setter
    private String token;
}
