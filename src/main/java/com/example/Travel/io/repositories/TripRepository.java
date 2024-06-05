package com.example.Travel.io.repositories;
import com.example.Travel.io.Model.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Repository
public interface TripRepository extends JpaRepository<Trip,Long>
{
     Trip findByName(String name);
     void deleteByName(String string);
     @Query("SELECT t FROM Trip t JOIN t.clients c WHERE c.id = :clientId")
     List<Trip> findAllByClientId(@Param("clientId") Long clientId);
     @Modifying
     @Transactional
     @Query("update Trip t set t.name = :name where t.id = :tripId")
     void updateTripNameById(@Param("tripId") Integer tripId, @Param("name") String name);
}