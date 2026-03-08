package com.easylog.easylog_backend.model;

import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import org.hibernate.annotations.UuidGenerator;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

// mirroring exerciseDef model from swift
@Entity
public class Exercise {

    @Id
    @GeneratedValue()
    @UuidGenerator
    private UUID id;

    private String name;

    // which categories exercise can belong to (for sorting later)
    @ElementCollection
    private List<String> categories = new ArrayList<>();

    public Exercise(){

    }

    // getname
    public String getName() {
        return name;
    }
    // setname
    public void setName(String name){
        this.name = name;
    }
    // getcategories
    public List<String> getCategories(){
        return categories;
    }
    // addcategory
    public void addCategory(String category){
        this.categories.add(category);
    }

    public UUID getId(){
        return id;
    }

}
