package com.example.Travel.io.Model;
import java.util.ArrayList;
import java.util.Objects;
public class Client {
    private String login;
    private String password;
    private String mail;
    private String phoneNumber;
    private long id;

    private ArrayList<Trip> tripArrayList = new ArrayList<>();
    Client (Client client)
    {
        this.login=client.login;
        this.password= client.password;
        this.mail = client.mail;
        this.phoneNumber= client.phoneNumber;
        this.id= client.id;
        this.tripArrayList=client.tripArrayList;
    }
    public boolean checkStatus()
    {
        if(id == 0 || phoneNumber == "" || mail == "" || login == "" || password == "")
        return true;
        else return false;
    }
    public void setId(long id) {
        this.id = id;
    }
    public long getId() {
        return id;
    }

    @Override
    public String toString() {
        return "Client{" +
                "login='" + login + '\'' +
                ", password='" + password + '\'' +
                ", mail='" + mail + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", id=" + id +
                ", tripArrayList=" + tripArrayList +
                '}';
    }

    public String getLogin() {
        return login;
    }

    public ArrayList<Trip> getTripArrayList() {
        return tripArrayList;
    }

    public String getPassword() {
        return password;
    }

    public String getMail() {
        return mail;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Client client = (Client) o;
        return id == client.id  && Objects.equals(login, client.login) && Objects.equals(password, client.password) && Objects.equals(mail, client.mail) && Objects.equals(phoneNumber, client.phoneNumber) && Objects.equals(tripArrayList, client.tripArrayList);
    }

    @Override
    public int hashCode() {
        return Objects.hash(login, password, mail, phoneNumber, id, tripArrayList);
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public void setTripArrayList(ArrayList<Trip> tripArrayList) {
        this.tripArrayList = tripArrayList;
    }
}
