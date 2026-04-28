package com.etudiants.grading.service;

import com.etudiants.grading.client.EtudiantClient;
import com.etudiants.grading.entity.Note;
import com.etudiants.grading.repository.NoteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Optional;

@Service
public class NoteService {

    @Autowired
    private NoteRepository noteRepository;

    @Autowired
    private EtudiantClient etudiantClient;

    public List<Note> getAllNotes() {
        return noteRepository.findAll();
    }

    public Optional<Note> getNoteById(Long id) {
        return noteRepository.findById(id);
    }

    public List<Note> getNotesByStudentId(Long studentId) {
        return noteRepository.findByStudentId(studentId);
    }

    public Note saveNote(Note note) {
        // Vérifier que l'étudiant existe via Feign
        try {
            etudiantClient.getEtudiantById(note.getStudentId());
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                "Étudiant avec ID " + note.getStudentId() + " n'existe pas");
        }

        // Valider la valeur de la note (0-20)
        if (note.getValeur() < 0 || note.getValeur() > 20) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                "La valeur de la note doit être entre 0 et 20");
        }

        return noteRepository.save(note);
    }

    public void deleteNote(Long id) {
        if (!noteRepository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,
                "Note avec ID " + id + " n'existe pas");
        }
        noteRepository.deleteById(id);
    }
}