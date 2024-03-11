package com.example.Travel.io.repositories;
import com.example.Travel.io.Model.*;
import com.example.Travel.io.Model.Client;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SubTripRepository extends JpaRepository<SubTrip,Long>
{
}