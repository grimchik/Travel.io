package com.example.Travel.io.repositories;
import com.example.Travel.io.Model.*;
import com.example.Travel.io.Model.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface SubTripRepository extends JpaRepository<SubTrip,Long>
{
}