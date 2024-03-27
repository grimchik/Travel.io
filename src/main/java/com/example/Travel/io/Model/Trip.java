package com.example.Travel.io.Model;

import javax.persistence.*;
import lombok.*;
import lombok.Setter;
import lombok.Getter;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "Trip")
public class Trip {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idTrip")
    @Getter
    @Setter
    private int idTrip;

    @ManyToOne
    @JoinColumn(name = "id_client_trips", nullable = false)
    @Getter
    @Setter
    private Client client;

    // Constructors, getters, and setters
}
