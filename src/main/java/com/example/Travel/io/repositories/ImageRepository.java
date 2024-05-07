package com.example.Travel.io.repositories;

import com.example.Travel.io.Model.Client;
import com.example.Travel.io.Model.Image;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import javax.transaction.Transactional;

public interface ImageRepository extends JpaRepository<Image,Long> {
    @Transactional
    @Modifying
    @Query("update Image i set i.name = :name, i.originalFileName = :originalFileName, i.contentType = :contentType, i.size = :size, i.image = :image where i.client.idClient = :clientId")
    void updateImageByIdClient(Long clientId, String name, String originalFileName, String contentType, Long size, byte[] image);
    Image findByClientIdClient(Long ClientIdClient);
}
