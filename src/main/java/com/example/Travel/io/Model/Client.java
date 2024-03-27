package com.example.Travel.io.Model;
import javax.persistence.*;
import lombok.*;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import com.example.Travel.io.Model.emuns.*;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;

import static com.example.Travel.io.Model.emuns.Role.ROLE_USER;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "Client")
public class Client  implements UserDetails {
    public Client(int id,String lg,String pas,String mail,String phone, boolean act )
    {
        this.login = lg;
        this.mail=mail;
        this.password=pas;
        init();
        this.active=act;
        this.phoneNumber=phone;
        this.roles.add(ROLE_USER);
    }
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_client")
    @Getter
    @Setter
    private int idClient;

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

    @Column(name = "phone_number", unique = true, nullable = false)
    @Getter
    @Setter
    private String phoneNumber;
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

    public void setActive(boolean active) {
        this.active = active;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    @Getter
    @Setter
    private LocalDateTime dateOfCreated;
    @PrePersist

    public void init()
    {
        dateOfCreated=LocalDateTime.now();
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