package com.example.Travel.io.Model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
public class TripInformation {
    @Getter
    @Setter
    private String administrator;
    @Getter
    @Setter
    private String name;
    @Getter
    @Setter
    private int count;
    @Getter
    @Setter
    private String transport;
}
