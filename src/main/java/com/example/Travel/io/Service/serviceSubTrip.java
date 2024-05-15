package com.example.Travel.io.Service;

import com.example.Travel.io.Model.SubTrip;
import com.example.Travel.io.repositories.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class serviceSubTrip {
    private final ClientRepository clientRepository;
    private final ImageRepository imageRepository;
    private final InviteRepository inviteRepository;
    private final TripRepository tripRepository;
    private final SubTripRepository subTripRepository;
    @Autowired
    public serviceSubTrip(SubTripRepository subTripRepository, TripRepository tripRepository, InviteRepository inviteRepository, ImageRepository imageRepository, ClientRepository clientRepository, PasswordEncoder passwordEncoder) {
        this.clientRepository = clientRepository;
        this.imageRepository=imageRepository;
        this.inviteRepository=inviteRepository;
        this.tripRepository = tripRepository;
        this.subTripRepository=subTripRepository;
    }
    public void saveSubTrip(SubTrip subtrip)
    {
        subTripRepository.save(subtrip);
    }
}
