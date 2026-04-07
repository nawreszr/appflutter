package com.example.etudiants.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import javax.persistence.*;
import java.time.LocalDate;
import java.time.Period;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Etudiant {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String cin;
    private String nom;
    private LocalDate dateNaissance;
    
    // Méthode pour calculer l'âge dynamiquement
    public int age() {
        if (this.dateNaissance == null) {
            return 0;
        }
        return Period.between(this.dateNaissance, LocalDate.now()).getYears();
    }
}