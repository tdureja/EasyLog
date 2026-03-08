package com.easylog.easylog_backend.controller;

import com.easylog.easylog_backend.model.ExerciseInstance;
import com.easylog.easylog_backend.repository.ExerciseInstanceRepository;
import org.apache.coyote.Response;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/exerciseInstances")
public class ExerciseInstanceController {

    private final ExerciseInstanceRepository exerciseInstanceRepository;

    public ExerciseInstanceController(ExerciseInstanceRepository exerciseInstanceRepository){
        this.exerciseInstanceRepository = exerciseInstanceRepository;
    }

    @PostMapping
    public ExerciseInstance saveExerciseInstance(@RequestBody ExerciseInstance exerciseInstance){
        return exerciseInstanceRepository.save(exerciseInstance);
    }

    @GetMapping
    public List<ExerciseInstance> getAllExerciseInstances(){
        return exerciseInstanceRepository.findAll();
    }

    @GetMapping("/{id}")
    public ExerciseInstance getExerciseInstanceById(@PathVariable UUID id){
        return exerciseInstanceRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Exercise Instance not found"));
    }

    @DeleteMapping("/{id}")
    public void deleteExerciseInstance(@PathVariable UUID id){
        exerciseInstanceRepository.deleteById(id);
    }

}
