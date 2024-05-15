package com.example.Travel.io.Model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
@AllArgsConstructor
@NoArgsConstructor
public class AddFriendRequest {
    @Getter
    @Setter
    private String username;
    @Getter
    @Setter
    private String name;
}
