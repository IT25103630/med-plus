package com.medplus.repository;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.medplus.model.BaseModel;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public abstract class BaseFileRepository<T extends BaseModel> {
    
    protected ObjectMapper objectMapper;
    protected String filePath;
    protected Class<T[]> arrayClass;

    public BaseFileRepository(String filePath, Class<T[]> arrayClass) {
        this.objectMapper = new ObjectMapper();
        this.objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        this.filePath = filePath;
        this.arrayClass = arrayClass;
        ensureFileExists();
    }

    private void ensureFileExists() {
        try {
            Path path = Paths.get(filePath);
            if (!Files.exists(path.getParent())) {
                Files.createDirectories(path.getParent());
            }
            if (!Files.exists(path)) {
                Files.writeString(path, "[]");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<T> findAll() {
        try {
            T[] array = objectMapper.readValue(new File(filePath), arrayClass);
            if (array == null) return new ArrayList<>();
            return new ArrayList<>(java.util.Arrays.asList(array));
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public Optional<T> findById(String id) {
        return findAll().stream().filter(item -> item.getId().equals(id)).findFirst();
    }

    public void save(T item) {
        List<T> items = findAll();
        boolean found = false;
        for (int i = 0; i < items.size(); i++) {
            if (items.get(i).getId().equals(item.getId())) {
                items.set(i, item);
                found = true;
                break;
            }
        }
        if (!found) {
            items.add(item);
        }
        saveAll(items);
    }

    public void delete(String id) {
        List<T> items = findAll();
        items.removeIf(item -> item.getId().equals(id));
        saveAll(items);
    }

    public void saveAll(List<T> items) {
        try {
            objectMapper.writerWithDefaultPrettyPrinter().writeValue(new File(filePath), items);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
