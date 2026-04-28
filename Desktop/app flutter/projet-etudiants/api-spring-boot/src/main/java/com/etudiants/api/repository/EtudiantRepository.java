package com.etudiants.api.repository;

import com.etudiants.api.entity.Etudiant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface EtudiantRepository extends JpaRepository<Etudiant, Long> {
    Etudiant findByCin(String cin);

    List<Etudiant> findByDepartement(String departement);
}
