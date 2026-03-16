package com.easylog.easylog_backend.controller;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import com.easylog.easylog_backend.repository.WorkoutRepository;
import com.easylog.easylog_backend.model.Workout;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Optional;
import java.util.UUID;


@RestController
@RequestMapping("/workouts")
public class WorkoutController {

    private final WorkoutRepository workoutRepository;

    public WorkoutController(WorkoutRepository workoutRepository){
        this.workoutRepository = workoutRepository;
    }

    @PostMapping
    public Workout saveWorkout(@RequestBody Workout workout){
        return workoutRepository.save(workout);
    }

    @GetMapping
    public List<Workout> getAllWorkouts(){
        return workoutRepository.findAll();
    }

    @GetMapping("/{id}")
    public Workout getWorkoutById(@PathVariable UUID id){
        return workoutRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Workout not found"));
    }

    @DeleteMapping("/{id}")
    public void deleteWorkout(@PathVariable UUID id){
        if (!workoutRepository.existsById(id)){
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Workout not found");
        }

        workoutRepository.deleteById(id);
    }

    @PutMapping("/{id}")
    public void updateWorkout(@PathVariable UUID id, @RequestBody Workout workout){
        Optional<Workout> optionalWorkout = workoutRepository.findById(id);

        if(optionalWorkout.isPresent()){
            Workout existingWorkout = optionalWorkout.get();
            existingWorkout.setWorkoutDate(workout.getWorkoutDate());
            existingWorkout.setCategory(workout.getCategory());
            workoutRepository.save(existingWorkout);
        }
    }

}
