package com.easylog.easylog_backend.controller;


import com.easylog.easylog_backend.model.Exercise;
import com.easylog.easylog_backend.repository.ExerciseRepository;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/exercises")
public class ExerciseController {

    private final ExerciseRepository exerciseRepository;

    public ExerciseController(ExerciseRepository exerciseRepository){
        this.exerciseRepository = exerciseRepository;
    }

    @PostMapping
    public Exercise saveExercise(@RequestBody Exercise exercise){
        return exerciseRepository.save(exercise);
    }

    @GetMapping
    public List<Exercise> getAllExercises(){
        return exerciseRepository.findAll();
    }

    @GetMapping("/{id}")
    public Exercise getExerciseById(@PathVariable UUID id){
        return exerciseRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Exercise not found"));
    }
}
