package com.example.Travel.io.repositories;
import com.example.Travel.io.Model.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface TripRepository extends JpaRepository<Trip,Long>
{
     Trip findByName(String name);
}