Feature: Calcul de l'âge d'un étudiant
  
  Scenario: Étudiant né il y a 22 ans
    Given un étudiant avec la date de naissance "2002-04-07"
    When on calcule son âge
    Then l'âge retourné doit être 22
    
  Scenario: Étudiant né aujourd'hui
    Given un étudiant avec la date de naissance "2026-04-07"
    When on calcule son âge
    Then l'âge retourné doit être 0
    
  Scenario: Étudiant né il y a 18 ans
    Given un étudiant avec la date de naissance "2008-04-07"
    When on calcule son âge
    Then l'âge retourné doit être 18