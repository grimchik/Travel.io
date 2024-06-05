package com.example.Travel.io.Model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
public class Coordinate {
    @Getter
    @Setter
    private double lng;
    @Getter
    @Setter
    private double lat;
    @Getter
    @Setter
    private String typeOfTransport;
    @Getter
    @Setter
    private boolean status;
    @Override
    public String toString() {
        return
                lng +
                "," + lat;
    }

}