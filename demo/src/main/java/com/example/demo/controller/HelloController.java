package com.example.demo.controller;

import com.example.demo.dto.request.ModelCreateRequest;
import com.example.demo.dto.request.ModelUpdateRequest;
import com.example.demo.service.ModelService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
public class HelloController {
    private final ModelService modelService;

    public HelloController(ModelService modelService) {
        this.modelService = modelService;
    }

    @GetMapping("/search")
    public ResponseEntity<?> search() {
        return ResponseEntity.ok(modelService.getAll());
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<?> update(@RequestBody @Valid ModelUpdateRequest request, @PathVariable Long id) {
        return ResponseEntity.ok(modelService.update(id, request));
    }

    @PostMapping(value = "/create")
    public ResponseEntity<?> create(@RequestBody @Valid ModelCreateRequest request) {
        return ResponseEntity.ok(modelService.create(request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable Long id) {
        modelService.delete(id);
        return ResponseEntity.ok("Delete success");
    }
}
