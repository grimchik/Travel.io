package com.example.Travel.io.Service;

import com.example.Travel.io.Model.*;

public class serviceClient {
    private Client client;
    private long id = 0;
    public void changeId()
    {
        this.client.setId(id);
        id++;
    }
    serviceClient(Client client)
    {
        this.client=client;
    }
    public void addTrip(Trip trip)
    {
        this.client.getTripArrayList().add(trip);
    }
    public void deleteTrip(Trip trip)
    {
        if (!this.client.getTripArrayList().isEmpty()) {
            this.client.getTripArrayList().remove(trip);
        }
    }
    public void deleteAllTripsForClient()
    {
        for (Trip elem:
             this.client.getTripArrayList()) {
            this.client.getTripArrayList().remove(elem);
        }
    }
}
