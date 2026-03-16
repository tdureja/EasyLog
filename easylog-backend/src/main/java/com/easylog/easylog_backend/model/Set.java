package com.easylog.easylog_backend.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import org.hibernate.annotations.UuidGenerator;

import java.util.UUID;

@Entity
public class Set {

    @Id
    @GeneratedValue
    @UuidGenerator
    private UUID id;

    private int reps;
    private double weight;

    @ManyToOne
    @JsonIgnore
    private ExerciseInstance exerciseInstance;

    public Set(){}

    public UUID getId(){
        return id;
    }

    public ExerciseInstance getExerciseInstance(){
        return exerciseInstance;
    }

    public int getReps(){
        return reps;
    }

    public double getWeight(){
        return weight;
    }

    public void setExerciseInstance(ExerciseInstance exerciseInstance){
        this.exerciseInstance = exerciseInstance;
    }

    public void setReps(int reps){
        this.reps = reps;
    }

    public void setWeight(double weight){
        this.weight = weight;
    }


}
