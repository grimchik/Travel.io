package com.example.Travel.io.Model;
import javax.persistence.*;
import lombok.*;
import org.springframework.mock.web.MockMultipartFile;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;
import org.springframework.web.multipart.MultipartFile;
import com.example.Travel.io.Model.emuns.*;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.multipart.MultipartFile;
import static com.example.Travel.io.Model.emuns.Role.ROLE_USER;
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "Client")
public class Client  implements UserDetails {
    public Client(int id,String lg,String pas,String mail, boolean act )
    {
        this.login = lg;
        this.mail=mail;
        this.password=pas;
        init();
        this.active=act;
        this.roles.add(ROLE_USER);
    }
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idСlient")
    @Getter
    @Setter
    private Long idClient;
    @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinTable(name = "client_trip",
            joinColumns = @JoinColumn(name = "client_id"),
            inverseJoinColumns = @JoinColumn(name = "trip_id"))
    private Set<Trip> trips;

    @Column(name = "login", unique = true, nullable = false)
    @Getter
    @Setter
    private String login;

    @Column(name = "password",length = 1000, nullable = false)
    @Getter
    @Setter
    private String password;

    @Column(name = "mail", unique = true, nullable = false)
    @Getter
    @Setter
    private String mail;

    @Column(name = "active")
    @Getter
    @Setter
    private boolean active;
    @ElementCollection(targetClass = Role.class,fetch = FetchType.EAGER)
    @CollectionTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"))
    @Enumerated(EnumType.STRING)
    @Getter
    @Setter
    private Set<Role> roles = new HashSet<>();
    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "client")
    @Getter
    private Image image;

    private Long imageId;
    public void setActive(boolean active) {
        this.active = active;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Set<Role> getRoles() {
        return roles;
    }
    @ManyToMany(fetch = FetchType.LAZY, cascade=CascadeType.ALL)
    @Getter
    @Setter
    private Set<Client> friends;
    @ManyToMany(fetch = FetchType.LAZY, cascade=CascadeType.ALL)
    @Getter
    @Setter
    private Set<Achievement> achievements;
    @Getter
    @Setter
    private LocalDateTime dateOfCreated;
    @PrePersist

    public void init()
    {
        dateOfCreated=LocalDateTime.now();
    }
    public MultipartFile loadFileAsMultipartFile(String filePath) throws IOException {
        File file = new File(filePath);
        FileInputStream input = new FileInputStream(file);
        MultipartFile multipartFile = new MockMultipartFile("file",
                file.getName(), "image/png", input);
        return multipartFile;
    }
    public void setDefaultAvatar() throws IOException
    {
        var avatar=loadFileAsMultipartFile("C:\\Travel.io\\Travel.io\\src\\main\\resources\\static\\Avatar.png");
        this.image=new Image();
        this.image.setName(avatar.getName());
        this.image.setOriginalFileName(avatar.getOriginalFilename());
        this.image.setContentType(avatar.getContentType());
        this.image.setSize(avatar.getSize());
        this.image.setImage(avatar.getBytes());
        this.image.setClient(this);
    }
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return roles;
    }

    @Override
    public String getPassword() {
        return password;
    }
    @Override
    public String toString()
    {
        return "Login - " +this.login + "Mail - " + this.mail ;
    }
    @Override
    public String getUsername() {
        return login;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return active;
    }
}