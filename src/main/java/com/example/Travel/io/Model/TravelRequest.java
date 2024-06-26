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
    private List<String> names;
    @Getter
    @Setter
    private List<Coordinate> markers;
    @Getter
    @Setter
    private String transportType;
    @Getter
    @Setter
    private String type;
    @Getter
    @Setter
    private String status;
}
