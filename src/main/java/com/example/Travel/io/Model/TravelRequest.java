package com.example.Travel.io.Model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Service;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
public class TravelRequest {
    @Getter
    @Setter
    String name;
    @Getter
    @Setter
    private List<Coordinate> markers;
    @Getter
    @Setter
    private String transportType;
}
