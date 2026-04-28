package com.etudiants.api.service;

import com.etudiants.api.entity.Etudiant;
import com.etudiants.api.repository.EtudiantRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class EtudiantService {
    
    @Autowired
    private EtudiantRepository etudiantRepository;
    
    public List<Etudiant> getAllEtudiants() {
        return etudiantRepository.findAll();
    }
    
    public Optional<Etudiant> getEtudiantById(Long id) {
        return etudiantRepository.findById(id);
    }

    public List<Etudiant> getEtudiantsByDepartement(String departement) {
        return etudiantRepository.findByDepartement(departement);
    }
    
    public Etudiant saveEtudiant(Etudiant etudiant) {
        return etudiantRepository.save(etudiant);
    }
    
    public void deleteEtudiant(Long id) {
        etudiantRepository.deleteById(id);
    }
    
    public Etudiant getEtudiantByCin(String cin) {
        return etudiantRepository.findByCin(cin);
    }
}
