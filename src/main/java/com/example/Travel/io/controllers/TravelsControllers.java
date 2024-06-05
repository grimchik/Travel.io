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
import org.springframework.web.bind.annotation.*;

import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

@Controller
@RequiredArgsConstructor
public class TravelsControllers {
    private static Client client;
    private static int count =0;
    private static Trip trip;
    private String name;
    private String travelName;
    private boolean check = false;
    private final GeoIPService geoIPService;
    private final HttpServletRequest request;
    private final serviceTrip serviceTrip;
    private final serviceClient serviceClient;
    private final serviceSubTrip servicesubTrip;
    @PostMapping("/saveTravelAdminCheck")
    @PreAuthorize("isAuthenticated()")
    @Transactional
    public ResponseEntity<String> saveTravelNonAdmin(@RequestBody TravelRequest request)
    {
        List<String> names = request.getNames();
        if (request.getStatus().equals("admin"))
        {
            String name = names.get(0);
            Trip trip1 = serviceTrip.findByName(name);
            List<Coordinate> markers = request.getMarkers();
            String transportType = request.getTransportType();
            client = ClientController.getClient();
            serviceTrip.updateTrip(Integer.valueOf(trip1.getIdTrip()),names.get(names.size()-1));
            serviceTrip.deleteByTripId(trip1);
            for (int i = 0; i < markers.size() ; i++) {
                Coordinate coor = markers.get(i);
                SubTrip sub = new SubTrip();
                sub.setTrip(trip1);
                sub.setPoint(String.valueOf(coor.getLng()) + "|" + String.valueOf(coor.getLat()));
                sub.setTransportType(transportType);
                sub.setStatus(markers.get(i).isStatus());
                servicesubTrip.saveSubTrip(sub);
            }
        }
        else
        {
            String name = names.get(0);
            Trip trip1 = serviceTrip.findByName(name);
            List<Coordinate> markers = request.getMarkers();
            String transportType = request.getTransportType();
            client = ClientController.getClient();
            serviceTrip.updateTrip(Integer.valueOf(trip1.getIdTrip()),name);
            serviceTrip.deleteByTripId(trip1);
            for (int i = 0; i < markers.size() ; i++) {
                Coordinate coor = markers.get(i);
                SubTrip sub = new SubTrip();
                sub.setTrip(trip1);
                sub.setPoint(String.valueOf(coor.getLng()) + "|" + String.valueOf(coor.getLat()));
                sub.setTransportType(transportType);
                sub.setStatus(markers.get(i).isStatus());
                servicesubTrip.saveSubTrip(sub);
            }
        }
        return ResponseEntity.ok("Путешествие успешно сохранено.");
    }
    @PostMapping("/saveTravel")
    @PreAuthorize("isAuthenticated()")
    @Transactional
    public ResponseEntity<String> saveTravel (@RequestBody TravelRequest request)
    {

        List<String> names = request.getNames();
        System.out.println(names.get(names.size()-1));
        if (names.get(names.size()-1).equals(""))
        {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Путешествие с таким именем недопустимо");
        }

        if (serviceTrip.findByName(names.get(names.size()-1)) != null && check != true)
        {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Путешествие с таким именем уже существует");
        }
        if ((names.size() == 1 && check != true) || (check != true) ) {
            System.out.println(1);
            check = true;
            Trip trip = new Trip();
            List<Coordinate> markers = request.getMarkers();
            String transportType = request.getTransportType();

            client = ClientController.getClient();
            var client2 = serviceClient.getClientByLogin(client.getLogin());
            trip.setName(names.get(names.size()-1));
            trip.getClients().add(client2);
            trip.setAdministrator(client2);
            serviceTrip.saveTrip(trip);
            for (int i = 0; i < markers.size() ; i++) {
                Coordinate coor = markers.get(i);
                SubTrip sub = new SubTrip();
                sub.setTrip(trip);
                sub.setPoint(String.valueOf(coor.getLng()) + "|" + String.valueOf(coor.getLat()));
                sub.setTransportType(transportType);
                sub.setStatus(markers.get(i).isStatus());
                servicesubTrip.saveSubTrip(sub);
            }
        }
        else
        {
            if (names.size() > 1)
            {
                System.out.println(2);
                Trip trip1 = serviceTrip.findByName(names.get(names.size() - 2));
                serviceTrip.deleteByTripId(trip1);
                var client2 = serviceClient.getClientByLogin(client.getLogin());
                List<Coordinate> markers = request.getMarkers();
                String transportType = request.getTransportType();
                client = ClientController.getClient();
                serviceTrip.updateTrip(Integer.valueOf(trip1.getIdTrip()),names.get(names.size() - 1));
                serviceTrip.deleteByTripId(trip1);
                for (int i = 0; i < markers.size() ; i++) {
                    Coordinate coor = markers.get(i);
                    SubTrip sub = new SubTrip();
                    sub.setTrip(trip1);
                    sub.setPoint(String.valueOf(coor.getLng()) + "|" + String.valueOf(coor.getLat()));
                    sub.setTransportType(transportType);
                    sub.setStatus(markers.get(i).isStatus());
                    servicesubTrip.saveSubTrip(sub);
                }
                return ResponseEntity.ok("Путешествие успешно сохранено.");
            }
            System.out.println(3);
            Trip trip = new Trip();
            List<Coordinate> markers = request.getMarkers();
            String transportType = request.getTransportType();
            client = ClientController.getClient();
            Trip trip1 = serviceTrip.findByName(names.get(0));
            serviceTrip.deleteByTripId(trip1);
            for (int i = 0; i < markers.size() ; i++) {
                Coordinate coor = markers.get(i);
                SubTrip sub = new SubTrip();
                sub.setTrip(trip);
                sub.setPoint(String.valueOf(coor.getLng()) + "|" + String.valueOf(coor.getLat()));
                sub.setTransportType(transportType);
                sub.setStatus(markers.get(i).isStatus());
                servicesubTrip.saveSubTrip(sub);
            }
        }
        return ResponseEntity.ok("Путешествие успешно сохранено.");
    }
    @GetMapping("/travel/{name}")
    @PreAuthorize("isAuthenticated()")
    public String travelPage(@PathVariable String name, Model model)
    {
        String admin = "user";
        String get = "none";
         var client1 =ClientController.getClient();
        if (serviceTrip.findByName(name) != null) {
            if (client1.getIdClient() == serviceTrip.findByName(name).getAdministrator().getIdClient()) {
                admin="admin";
                System.out.println(admin);
                model.addAttribute("status", "admin");
            }
            else
            {
                System.out.println(admin);
                model.addAttribute("status", "user");
            }
            if (serviceTrip.tripWithIdClient(client1.getIdClient()).contains(serviceTrip.findByName(name)))
            {
                get = "get";
                System.out.println(get);
                model.addAttribute("get", "get");
            }
            else
            {
                System.out.println(get);
                model.addAttribute("get", "none");
            }
            this.name = name;
            model.addAttribute("name",name);
            Long idValue = ClientController.getClient().getIdClient();
            Long id = idValue;
            var image = serviceClient.findImage(id);
            if (image != null) {
                byte[] imageData = image.getImage();
                var base64Image = Base64.getEncoder().encodeToString(imageData);
                model.addAttribute("base64Image", base64Image);
            }

            return "travel";
        }
        System.out.println("CHECK");
        return "error";
    }
    @PostMapping("/leave-travel")
    @PreAuthorize("isAuthenticated()")
    @Transactional
    public String leaveTravel(@RequestBody TravelInfo request) {
        System.out.println("EXXXX" + request.getName());
        List<Client> clients = serviceClient.allClientsForTrip(serviceTrip.findByName(request.getName()).getIdTrip());
        for (Client client: clients)
        {
            if (client.getLogin().equals(ClientController.getClient().getLogin()))
            serviceTrip.deleteTrip(client.getIdClient(),serviceTrip.findByName(request.getName()).getIdTrip());
        }
        return "redirect:/your-travels";
    }

    @GetMapping("/getSubTripCoordinates")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<List<Coordinate>> getSubTripCoordinates()
    {
            Trip trip = serviceTrip.findByName(name);
            List<SubTrip> subTrips = serviceTrip.subTrips(trip);
            Set<String> coordinatesSet = new HashSet<>();
            List<Boolean> booleanSet = new ArrayList<>();
            String transportType = "driving";
            for (SubTrip subTrip : subTrips) {
                transportType = subTrip.getTransportType();
                coordinatesSet.add(subTrip.getPoint());
                booleanSet.add(subTrip.getStatus());
            }
            System.out.println(transportType);
            List<Coordinate> coordinateSubTrips = new ArrayList<>();
            int count = 0;
            for (String string : coordinatesSet)
            {
                Boolean elem = booleanSet.get(count);
                count++;
                String[] parts = string.split("\\|");
                double part1 = Double.valueOf(parts[0]);
                double part2 = Double.valueOf(parts[1]);
                coordinateSubTrips.add(new Coordinate(part1, part2,transportType,elem));
            }
            return ResponseEntity.ok(coordinateSubTrips);
    }
    @PostMapping("/invitetotravel")
    @PreAuthorize("isAuthenticated()")
    @Transactional
    public ResponseEntity<String> addFriendToTravel(@RequestBody AddFriendRequest request) {
        System.out.println(serviceTrip.findByName(request.getName()));
        boolean success = serviceTrip.addFriendToTravel(serviceTrip.findByName(request.getName()), request.getUsername());
        if (success) {
            return ResponseEntity.ok("Пользователь успешно добавлен!");
        } else {
            return ResponseEntity.ok("Превышен лимит добавленных пользователей!");
        }
    }
}
