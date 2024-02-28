package com.example.Travel.io.Model;

import java.util.Objects;

public class SubTrip {
    private String pointA;
    private String pointB;
    private String typeOfTransport;
    SubTrip(SubTrip elem)
    {
        this.pointA=elem.pointA;
        this.pointB=elem.pointB;
        this.typeOfTransport=elem.typeOfTransport;
    }
    SubTrip(String pointa, String pointb,String type)
    {
     this.pointA=pointa;
     this.pointB=pointb;
     this.typeOfTransport=type;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        SubTrip subTrip = (SubTrip) o;
        return Objects.equals(pointA, subTrip.pointA) && Objects.equals(pointB, subTrip.pointB) && Objects.equals(typeOfTransport, subTrip.typeOfTransport);
    }

    @Override
    public int hashCode() {
        return Objects.hash(pointA, pointB, typeOfTransport);
    }

    @Override
    public String toString() {
        return "{" +
                "pointA='" + pointA + '\'' +
                ", pointB='" + pointB + '\'' +
                ", typeOfTransport='" + typeOfTransport + '\'' +
                '}';
    }

    public String getPointA() {
        return pointA;
    }

    public String getPointB() {
        return pointB;
    }

    public String getTypeOfTransport() {
        return typeOfTransport;
    }

    public void setPointA(String pointA) {
        this.pointA = pointA;
    }

    public void setPointB(String pointB) {
        this.pointB = pointB;
    }

    public void setTypeOfTransport(String typeOfTransport) {
        this.typeOfTransport = typeOfTransport;
    }
}
