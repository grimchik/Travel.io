package com.example.Travel.io.Model;

import lombok.*;

import javax.persistence.*;

@AllArgsConstructor
@NoArgsConstructor
@Entity
@Data
public class Achievement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idAchievement")
    private long idAchievement;

    @Column (name = "name")
    @Getter
    @Setter
    private String name;

    @Column (name = "description")
    @Getter
    @Setter
    private String description;
}
