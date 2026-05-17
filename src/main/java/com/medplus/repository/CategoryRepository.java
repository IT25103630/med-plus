package com.medplus.repository;

import com.medplus.model.Category;
import org.springframework.stereotype.Repository;

/**
 * Repository for Category data storage in categories.json.
 */
@Repository
public class CategoryRepository extends BaseFileRepository<Category> {
    public CategoryRepository() {
        super("data/categories.json", Category[].class);
    }
}
