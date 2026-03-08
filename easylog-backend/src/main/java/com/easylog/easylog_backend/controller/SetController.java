package com.easylog.easylog_backend.controller;

import com.easylog.easylog_backend.model.Set;
import com.easylog.easylog_backend.repository.SetRepository;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.UUID;

@RestController
@RequestMapping("/sets")
public class SetController {

    private final SetRepository setRepository;

    public SetController(SetRepository setRepository){
        this.setRepository = setRepository;
    }

    @PostMapping
    public Set saveSet(@RequestBody Set set){
        return setRepository.save(set);
    }

    @GetMapping("/{id}")
    public Set getSetById(@PathVariable UUID id){
        return setRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Set not found"));
    }

    @DeleteMapping("/{id}")
    public void deleteSet(@PathVariable UUID id){
        setRepository.deleteById(id);
    }
}
