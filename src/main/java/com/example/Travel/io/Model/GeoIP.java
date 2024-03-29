package com.example.Travel.io.Model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Data
public class GeoIP {
    @Getter
    @Setter
    private String ipAddress;
    @Getter
    @Setter
    private String city;
    @Getter
    @Setter
    private String latitude;
    @Getter
    @Setter
    private String longitude;

}
