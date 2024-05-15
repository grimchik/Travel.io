package com.example.Travel.io.Model;

import com.example.Travel.io.Model.emuns.InviteStatus;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class InviteTravel {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Getter
    @Setter
    private Long id;

    @ManyToOne
    @JoinColumn(name = "from_client_id")
    @Getter
    @Setter
    private Client from;

    @ManyToOne
    @JoinColumn(name = "to_client_id")
    @Getter
    @Setter
    private Client to;

    @OneToOne(cascade = CascadeType.REFRESH,fetch = FetchType.EAGER)
    @Getter
    @Setter
    private Trip trip;

    @Enumerated(EnumType.ORDINAL)
    @Getter
    @Setter
    private InviteStatus status;
}
