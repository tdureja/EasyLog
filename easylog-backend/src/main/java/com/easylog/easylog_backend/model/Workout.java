package com.easylog.easylog_backend.model;

import jakarta.persistence.*;
import jakarta.persistence.Id;
import java.util.UUID;
import java.time.LocalDate;
import org.hibernate.annotations.UuidGenerator;


@Entity
public class Workout {
    @Id
    @GeneratedValue()
    @UuidGenerator
    private UUID id;

    private LocalDate workoutDate;

    private String category;

    public Workout(){

    }

    public LocalDate getWorkoutDate(){
        return workoutDate;
    }

    public void setWorkoutDate(LocalDate workoutDate){
        this.workoutDate = workoutDate;
    }

    public String getCategory(){
        return category;
    }

    public void setCategory(String category){
        this.category = category;
    }

    public UUID getId(){
        return id;
    }
    
}
