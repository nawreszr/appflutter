package com.example.etudiants.steps;

import com.example.etudiants.entity.Etudiant;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;
import io.cucumber.java.en.Then;
import org.junit.jupiter.api.Assertions;
import java.time.LocalDate;

public class EtudiantSteps {
    
    private Etudiant etudiant;
    private int ageCalcule;
    
    @Given("un étudiant avec la date de naissance {string}")
    public void unEtudiantAvecLaDateDeNaissance(String dateNaissance) {
        etudiant = new Etudiant();
        etudiant.setDateNaissance(LocalDate.parse(dateNaissance));
    }
    
    @When("on calcule son âge")
    public void onCalculeSonAge() {
        ageCalcule = etudiant.age();
    }
    
    @Then("l'âge retourné doit être {int}")
    public void lAgeRetourneDoitEtre(int ageAttendu) {
        Assertions.assertEquals(ageAttendu, ageCalcule);
    }
}