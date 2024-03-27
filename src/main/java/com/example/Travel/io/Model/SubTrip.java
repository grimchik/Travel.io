package com.example.Travel.io.Model;
import javax.persistence.*;
import lombok.*;
import lombok.Setter;
import lombok.Getter;
@Entity
@Table(name = "sub_trip")
@AllArgsConstructor
@NoArgsConstructor
public class SubTrip {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idsubTrip")
    @Getter
    @Setter
    private int idSubTrip;

    @ManyToOne
    @JoinColumn(name = "trip_id", nullable = false)
    @Getter
    @Setter
    private Trip trip;

    @Column(name = "pointA", nullable = false)
    @Getter
    @Setter
    private String pointA;

    @Column(name = "pointB", nullable = false)
    @Getter
    @Setter
    private String pointB;

    @Column(name = "transport_type", nullable = false)
    @Getter
    @Setter
    private String transportType;
}