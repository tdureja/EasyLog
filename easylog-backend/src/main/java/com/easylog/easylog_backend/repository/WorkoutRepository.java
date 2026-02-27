package com.easylog.easylog_backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.easylog.easylog_backend.model.Workout;
import java.util.UUID;


public interface WorkoutRepository extends JpaRepository<Workout, UUID> {

}
