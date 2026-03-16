package com.easylog.easylog_backend.repository;

import com.easylog.easylog_backend.model.ExerciseInstance;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface ExerciseInstanceRepository extends JpaRepository<ExerciseInstance, UUID> {

    List<ExerciseInstance> findByWorkoutId(UUID workoutId);

}
