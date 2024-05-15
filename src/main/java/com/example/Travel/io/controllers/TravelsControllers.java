package com.example.Travel.io.controllers;

import com.example.Travel.io.Model.*;
import com.example.Travel.io.Service.GeoIPService;
import com.example.Travel.io.Service.serviceClient;
import com.example.Travel.io.Service.serviceSubTrip;
import com.example.Travel.io.Service.serviceTrip;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

@Controller
@RequiredArgsConstructor
public class TravelsControllers {
    private static Client client;
    private static String latitude;
    private static String longitude;
    private static String base64Image;
    private static int count =0;
    private static Trip trip;
    private final GeoIPService geoIPService;
    private final HttpServletRequest request;
    private final serviceTrip serviceTrip;
    private final serviceClient serviceClient;
    private final serviceSubTrip servicesubTrip;
    @PostMapping("/saveTravel")
    @PreAuthorize("isAuthenticated()")
    @Transactional
    public ResponseEntity<String> saveTravel(@RequestBody TravelRequest request) {
        trip = new Trip();
        String name = request.getName();

        if (count ==0) {
            if (serviceTrip.findByName(name) != null)
            {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Путешествие с таким именем уже существует");
            }
            List<Coordinate> markers = request.getMarkers();
            String transportType = request.getTransportType();
            client = ClientController.getClient();
            var client2 = serviceClient.getClientByLogin(client.getLogin());
            trip.setName(name);
            trip.getClients().add(client2);
            serviceTrip.saveTrip(trip);
            for (int i = 0; i < markers.size() - 1; i++) {
                Coordinate coor = markers.get(i);
                Coordinate coo2 = markers.get(i + 1);
                SubTrip sub = new SubTrip();
                sub.setTrip(trip);
                sub.setPointA(String.valueOf(coor.getLng()) + String.valueOf(coor.getLat()));
                sub.setPointB(String.valueOf(coo2.getLng()) + String.valueOf(coo2.getLat()));
                sub.setTransportType(transportType);
                servicesubTrip.saveSubTrip(sub);
                count++;
            }
        }
        else
        {
            List<Coordinate> markers = request.getMarkers();
            String transportType = request.getTransportType();
            client = ClientController.getClient();Trip trip1 = serviceTrip.findByName(name);
            serviceTrip.deleteByTripId(trip1);
            System.out.println(trip1.getIdTrip());
            for (int i = 0; i < markers.size() - 1; i++) {
                Coordinate coor = markers.get(i);
                Coordinate coo2 = markers.get(i + 1);
                SubTrip sub = new SubTrip();
                sub.setIdSubTrip(trip1.getIdTrip());
                sub.setTrip(trip1);
                sub.setPointA(String.valueOf(coor.getLng()) + String.valueOf(coor.getLat()));
                sub.setPointB(String.valueOf(coo2.getLng()) + String.valueOf(coo2.getLat()));
                sub.setTransportType(transportType);
                servicesubTrip.saveSubTrip(sub);
            }
        }
        return ResponseEntity.ok("Путешествие успешно сохранено.");
    }
    @PostMapping("/invitetotravel")
    @PreAuthorize("isAuthenticated()")
    @Transactional
    public ResponseEntity<String> addFriendToTravel(@RequestBody AddFriendRequest request) {
        boolean success = serviceTrip.addFriendToTravel(serviceTrip.findByName(request.getName()), request.getUsername());
        if (success) {
            return ResponseEntity.ok("User added to travel successfully!");
        } else {
            return ResponseEntity.ok("User doesn't added to travel successfully!");
        }
    }
}
