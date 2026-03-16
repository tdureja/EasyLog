package com.easylog.easylog_backend.controller;

import com.easylog.easylog_backend.model.Exercise;
import com.easylog.easylog_backend.model.ExerciseInstance;
import com.easylog.easylog_backend.model.Workout;
import com.easylog.easylog_backend.repository.ExerciseInstanceRepository;
import com.easylog.easylog_backend.repository.WorkoutRepository;
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
    private final WorkoutRepository workoutRepository;

    public ExerciseInstanceController(ExerciseInstanceRepository exerciseInstanceRepository, WorkoutRepository workoutRepository){
        this.exerciseInstanceRepository = exerciseInstanceRepository;
        this.workoutRepository = workoutRepository;
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
        if (!exerciseInstanceRepository.existsById(id)){
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Exercise Instance not found");
        }

        exerciseInstanceRepository.deleteById(id);
    }

    @PostMapping("/workouts/{id}")
    public ExerciseInstance addExerciseInstanceToWorkout(@PathVariable UUID id, @RequestBody ExerciseInstance instance){
        Workout workout = workoutRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Workout not found"));

        instance.setWorkout(workout);

        return exerciseInstanceRepository.save(instance);
    }

    @GetMapping("/workouts/{id}")
    public List<ExerciseInstance> getExercisesForWorkout(@PathVariable UUID id){
        return exerciseInstanceRepository.findByWorkoutId(id);
    }

}
