package com.etudiants.api.controller;

import com.etudiants.api.entity.Etudiant;
import com.etudiants.api.service.EtudiantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/etudiants")
@CrossOrigin(origins = "*", maxAge = 3600)
public class EtudiantController {
    
    @Autowired
    private EtudiantService etudiantService;
    
    @GetMapping
    public ResponseEntity<List<Etudiant>> getAllEtudiants() {
        return ResponseEntity.ok(etudiantService.getAllEtudiants());
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<Etudiant> getEtudiantById(@PathVariable Long id) {
        return etudiantService.getEtudiantById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/departement/{departement}")
    public ResponseEntity<List<Etudiant>> getEtudiantsByDepartement(@PathVariable String departement) {
        return ResponseEntity.ok(etudiantService.getEtudiantsByDepartement(departement));
    }
    
    @PostMapping
    public ResponseEntity<Etudiant> createEtudiant(@RequestBody Etudiant etudiant) {
        return ResponseEntity.ok(etudiantService.saveEtudiant(etudiant));
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<Etudiant> updateEtudiant(@PathVariable Long id, @RequestBody Etudiant etudiant) {
        return etudiantService.getEtudiantById(id)
                .map(existing -> {
                    etudiant.setId(id);
                    return ResponseEntity.ok(etudiantService.saveEtudiant(etudiant));
                })
                .orElse(ResponseEntity.notFound().build());
    }
    
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteEtudiant(@PathVariable Long id) {
        if (etudiantService.getEtudiantById(id).isPresent()) {
            etudiantService.deleteEtudiant(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}
