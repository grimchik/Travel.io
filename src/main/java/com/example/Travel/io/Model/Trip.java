package com.example.Travel.io.Model;


import java.util.ArrayList;
import java.util.Objects;

public class Trip {
    private ArrayList<SubTrip> trip = new ArrayList<>();

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Trip trip1 = (Trip) o;
        return Objects.equals(trip, trip1.trip);
    }

    @Override
    public int hashCode() {
        return Objects.hash(trip);
    }
    public ArrayList<SubTrip> getTrip() {
        return trip;
    }
    public void setTrip(ArrayList<SubTrip> trip) {
        this.trip = trip;
    }
}
