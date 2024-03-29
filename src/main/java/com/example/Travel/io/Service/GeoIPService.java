package com.example.Travel.io.Service;

import com.example.Travel.io.Model.GeoIP;
import com.maxmind.geoip2.DatabaseReader;
import com.maxmind.geoip2.exception.GeoIp2Exception;
import com.maxmind.geoip2.model.CityResponse;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
@Component
public class GeoIPService {
    private DatabaseReader dbReader;

    public GeoIPService() throws IOException {
        File database = new File("C://GeoDataBase//GeoLite2-City.mmdb");
        dbReader = new DatabaseReader.Builder(database).build();
    }

    public GeoIP getLocation(String ip)
            throws IOException, GeoIp2Exception {
        InetAddress ipAddress = InetAddress.getByName(ip);
        CityResponse response = dbReader.city(ipAddress);

        String cityName = response.getCity().getName();
        String latitude =
                response.getLocation().getLatitude().toString();
        String longitude =
                response.getLocation().getLongitude().toString();
        return new GeoIP(ip, cityName, latitude, longitude);
    }
}