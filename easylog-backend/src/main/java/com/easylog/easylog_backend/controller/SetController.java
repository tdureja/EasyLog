package com.easylog.easylog_backend.controller;

import com.easylog.easylog_backend.model.ExerciseInstance;
import com.easylog.easylog_backend.model.Set;
import com.easylog.easylog_backend.repository.ExerciseInstanceRepository;
import com.easylog.easylog_backend.repository.SetRepository;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/sets")
public class SetController {

    private final SetRepository setRepository;
    private final ExerciseInstanceRepository exerciseInstanceRepository;

    public SetController(SetRepository setRepository, ExerciseInstanceRepository exerciseInstanceRepository){
        this.setRepository = setRepository;
        this.exerciseInstanceRepository = exerciseInstanceRepository;
    }

    @PostMapping
    public Set saveSet(@RequestBody Set set){
        return setRepository.save(set);
    }

    @GetMapping("/{id}")
    public Set getSetById(@PathVariable UUID id){
        return setRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Set not found"));

    }

    @DeleteMapping("/{id}")
    public void deleteSet(@PathVariable UUID id){
        if (!setRepository.existsById(id)){
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Set not found");
        }

        setRepository.deleteById(id);
    }

    @PostMapping("/exerciseInstances/{id}")
    public Set addSetToExercise(@PathVariable UUID id, @RequestBody Set set){

        ExerciseInstance exerciseInstance = exerciseInstanceRepository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Exercise Instance not found"));

        set.setExerciseInstance(exerciseInstance);
        return setRepository.save(set);
    }

    @GetMapping("/exerciseInstances/{id}")
    public List<Set> getSetsForExerciseInstance(@PathVariable UUID id){
        return setRepository.findByExerciseInstanceId(id);
    }

}
