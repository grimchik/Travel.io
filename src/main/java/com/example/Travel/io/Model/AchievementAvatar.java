package com.example.Travel.io.Model;

import lombok.*;

import javax.persistence.*;

@Entity
@Table(name="AchievementAvatar")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AchievementAvatar {
        @Id
        @Column(name="id")
        @GeneratedValue(strategy = GenerationType.AUTO)
        @Getter
        @Setter
        private Long id;
        @Column(name="name")
        @Getter
        @Setter
        private String name;
        @Column(name="original_file")
        @Getter
        @Setter
        private String originalFileName;
        @Column(name="size")
        @Getter
        @Setter
        private Long size;
        @Column(name="content_type")
        @Getter
        @Setter
        private String contentType;
        @Lob
        @Getter
        @Setter
        private byte[] image;
        @OneToOne(cascade = CascadeType.REFRESH,fetch = FetchType.EAGER)
        @Getter
        @Setter
        private Achievement achievement;
}
