package com.example.Travel.io.repositories;

import com.example.Travel.io.Model.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface ClientRepository extends JpaRepository<Client,Long>
{
    Client findBylogin(String login);
    Client findByIdClient(int id);
    List<Client> findByLoginContaining(String login);
    @Query("SELECT c.friends FROM Client c WHERE c.idClient = ?1")
    List<Client> findFriendsById(Long id);
}
