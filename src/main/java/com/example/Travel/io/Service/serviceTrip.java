package com.example.Travel.io.Service;

import com.example.Travel.io.Model.*;

public class serviceTrip {
    public Trip trip;
    serviceTrip(Trip trip)
    {
        this.trip=trip;
    }
    public void deleteSubTrip(SubTrip subTrip)
    {
        this.trip.getTrip().remove(subTrip);
    }
    public void deleteAllSubTrip()
    {
        for (SubTrip elem:
                this.trip.getTrip()
             ) {
            this.trip.getTrip().remove(elem);
        }
    }
    public void addSubTrip(SubTrip subTrip)
    {
        this.trip.getTrip().add(subTrip);
    }
}
