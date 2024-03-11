package com.example.Travel.io.Model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.*;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import lombok.Setter;
import lombok.Getter;
@Entity
@Table(name = "subTrip")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class SubTrip {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    @Getter
    @Setter
    @Column (name = "idsubTrip")
    private long idSubTrip;

    @Getter
    @Setter
    @Column (name = "trip_id")
    private long trip_id;


    @Getter
    @Setter
    @Column (name = "pointA")
    private String pointA;

    @Getter
    @Setter
    @Column (name = "pointB")
    private String pointB;

    @Getter
    @Setter
    @Column (name = "transport_type")
    private String transport_type;
}
