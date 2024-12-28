package com.example.demo.service;

import com.example.demo.dto.request.ModelCreateRequest;
import com.example.demo.dto.request.ModelUpdateRequest;
import com.example.demo.dto.response.ModelResponseDto;
import org.springframework.data.domain.Page;

import java.util.List;

public interface ModelService {
    ModelResponseDto create(ModelCreateRequest request);

    ModelResponseDto update(Long id,ModelUpdateRequest request);

    ModelResponseDto get(Long id);

    List<ModelResponseDto> getAll();

    void delete(Long id);
}
