package com.example.Travel.io.repositories;

import com.example.Travel.io.Model.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;
@Repository
public interface ClientRepository extends JpaRepository<Client,Long>
{
    Client findBylogin(String login);
    Client findBymail(String email);
    Client findByIdClient(int id);
    @Query("SELECT c FROM Client c JOIN c.trips t WHERE t.id = :tripId")
    List<Client> findAllClientsForTrip(@Param("tripId") Integer tripId);
    List<Client> findByLoginContaining(String login);
    @Query("SELECT c.friends FROM Client c WHERE c.idClient = ?1")
    List<Client> findFriendsById(Long id);
    @Transactional
    @Modifying
    @Query(value = "DELETE FROM client_trip WHERE client_id = ?1 AND trip_id = ?2", nativeQuery = true)
    void removeTripFromClient(Long clientId, int tripId);
}
