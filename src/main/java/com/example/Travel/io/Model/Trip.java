package com.example.Travel.io.Model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.ForeignKey;
import lombok.*;
import lombok.Setter;
import lombok.Getter;

@Entity
@Table(name = "Trip")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Trip {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "idTrip")
    @Getter
    @Setter
    private Long idTrip;

    @ManyToOne
    @JoinColumn(name = "idClient_TRIPS", referencedColumnName = "idClient", foreignKey = @ForeignKey(name = "idClient_TRIPS"))
    @Getter
    @Setter
    private Client client;

}
