package com.easylog.easylog_backend.repository;

import com.easylog.easylog_backend.model.Set;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface SetRepository extends JpaRepository<Set, UUID> {

    List<Set> findByExerciseInstanceId(UUID exerciseInstanceId);

}
