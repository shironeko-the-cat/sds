package com.example.demo.service;

import com.example.demo.dto.request.ModelBaseRequest;
import com.example.demo.dto.request.ModelCreateRequest;
import com.example.demo.dto.request.ModelUpdateRequest;
import com.example.demo.dto.response.ModelResponseDto;
import com.example.demo.entity.Model;
import com.example.demo.repository.ModelRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ModelServiceImpl implements ModelService {
    public ModelServiceImpl(ModelRepository modelRepository) {
        this.modelRepository = modelRepository;
    }

    private final ModelRepository modelRepository;

    @Override
    public ModelResponseDto create(ModelCreateRequest request) {
        Model model = persist(request, new Model());
        return toResponse(model);
    }

    @Override
    public ModelResponseDto update(Long id,ModelUpdateRequest request) {
        Model model = modelRepository.findById(id).orElseThrow(EntityNotFoundException::new);
        return toResponse(persist(request, model));
    }

    @Override
    public ModelResponseDto get(Long id) {
        Model model = modelRepository.findById(id).orElseThrow(EntityNotFoundException::new);
        return toResponse(model);
    }

    @Override
    public List<ModelResponseDto> getAll() {
        List<Model> results = modelRepository.findAll();
        return results.stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Override
    public void delete(Long id) {
        modelRepository.deleteById(id);
    }

    private <T extends ModelBaseRequest> Model persist(T request, Model model) {
        BeanUtils.copyProperties(request, model);
        return modelRepository.save(model);
    }

    private ModelResponseDto toResponse(Model model) {
        ModelResponseDto modelResponseDto = new ModelResponseDto();
        BeanUtils.copyProperties(model, modelResponseDto);
        return modelResponseDto;
    }
}
