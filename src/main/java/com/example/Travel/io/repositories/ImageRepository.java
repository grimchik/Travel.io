package com.example.Travel.io.repositories;

import com.example.Travel.io.Model.Client;
import com.example.Travel.io.Model.Image;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImageRepository extends JpaRepository<Image,Long> {
    Image findByClientIdClient(Integer ClientIdClient);
}
