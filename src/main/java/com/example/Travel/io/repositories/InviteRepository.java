package com.example.Travel.io.repositories;

import com.example.Travel.io.Model.Client;
import com.example.Travel.io.Model.Invite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface InviteRepository extends JpaRepository<Invite, Long> {
    Optional<Invite> findByFromLoginAndToLogin(String fromLogin, String toLogin);
    List<Invite> findByTo(Client to);
}
