package com.example.Travel.io.repositories;

import com.example.Travel.io.Model.Client;
import com.example.Travel.io.Model.Invite;
import com.example.Travel.io.Model.emuns.InviteStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface InviteRepository extends JpaRepository<Invite, Long> {
    Optional<Invite> findByFromLoginAndToLogin(String fromLogin, String toLogin);
    @Modifying
    @Query("update Invite i set i.status = :status where (i.from = :from and i.to = :to) or (i.from = :to and i.to = :from)")
    void updateInviteStatusBetweenUsers(Client from, Client to, InviteStatus status);
    List<Invite> findByTo(Client to);
}
