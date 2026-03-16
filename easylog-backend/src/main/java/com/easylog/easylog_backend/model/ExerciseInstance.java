package com.easylog.easylog_backend.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import org.hibernate.annotations.UuidGenerator;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
public class ExerciseInstance{

    @Id
    @GeneratedValue
    @UuidGenerator
    private UUID id;

    @ManyToOne
    @JsonIgnore
    private Workout workout;

    @ManyToOne
    private Exercise exercise;

    @Enumerated(EnumType.STRING)
    private WeightUnit unit;

    @OneToMany(mappedBy = "exerciseInstance", cascade = CascadeType.ALL)
    private List<Set> sets = new ArrayList<>(); // need to create Set

    public ExerciseInstance(){}

    public UUID getId(){
        return id;
    }

    public Workout getWorkout(){
        return workout;
    }

    public Exercise getExercise(){
        return exercise;
    }

    public WeightUnit getUnit(){
        return unit;
    }

    public List<Set> getSets(){
        return sets;
    }

    public void setWorkout(Workout workout){
        this.workout = workout;
    }

    public void setExercise(Exercise exercise){
        this.exercise = exercise;
    }

    public void setUnit(WeightUnit unit){
        this.unit = unit;
    }

    //TODO: addSet (after set entity exists)
    public void addSet(Set set){
        sets.add(set);
    }
}

