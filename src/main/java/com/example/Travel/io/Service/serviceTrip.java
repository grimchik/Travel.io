package com.example.Travel.io.Service;

import com.example.Travel.io.Model.*;
import com.example.Travel.io.repositories.*;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
public class serviceTrip {
    private final ClientRepository clientRepository;
    private final ImageRepository imageRepository;
    private final InviteRepository inviteRepository;
    private final TripRepository tripRepository;
    private final SubTripRepository subTripRepository;
    private final serviceClient serviceClient;
    @Autowired
    public serviceTrip(serviceClient serviceClient,SubTripRepository subTripRepository,TripRepository tripRepository,InviteRepository inviteRepository, ImageRepository imageRepository, ClientRepository clientRepository, PasswordEncoder passwordEncoder) {
        this.clientRepository = clientRepository;
        this.imageRepository=imageRepository;
        this.inviteRepository=inviteRepository;
        this.tripRepository = tripRepository;
        this.subTripRepository= subTripRepository;
        this.serviceClient=serviceClient;
    }
    public void saveTrip(Trip trip)
    {
        tripRepository.save(trip);
    }

    public Trip findByName(String name) {
        return tripRepository.findByName(name);
    }
    public void deleteByTripId(Trip trip)
    {
        subTripRepository.deleteByTrip(trip);
    }

    public boolean addFriendToTravel(Trip trip, String username)
    {
        Client client = serviceClient.getClientByLogin(username);
        trip.getClients().add(client);
        saveTrip(trip);
        return true;
    }
}
