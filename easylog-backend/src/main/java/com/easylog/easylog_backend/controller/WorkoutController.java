package com.easylog.easylog_backend.controller;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import com.easylog.easylog_backend.repository.WorkoutRepository;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import com.easylog.easylog_backend.model.Workout;



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

}
