import Category from '../models/Category.js';

export const getAllCategories = (req, res) => {
  try {
    const categories = Category.getAll();
    res.json(categories);
  } catch (error) {
    console.error('Error fetching categories:', error);
    res.status(500).json({ error: 'Failed to fetch categories' });
  }
};

export const getCategoryById = (req, res) => {
  try {
    const category = Category.getById(req.params.id);
    if (!category) {
      return res.status(404).json({ error: 'Category not found' });
    }
    res.json(category);
  } catch (error) {
    console.error('Error fetching category:', error);
    res.status(500).json({ error: 'Failed to fetch category' });
  }
};

export const getCategoryBySlug = (req, res) => {
  try {
    const category = Category.getBySlug(req.params.slug);
    if (!category) {
      return res.status(404).json({ error: 'Category not found' });
    }
    res.json(category);
  } catch (error) {
    console.error('Error fetching category:', error);
    res.status(500).json({ error: 'Failed to fetch category' });
  }
};

export const createCategory = (req, res) => {
  try {
    const category = Category.create(req.body);
    res.status(201).json(category);
  } catch (error) {
    console.error('Error creating category:', error);
    if (error.message.includes('UNIQUE constraint failed')) {
      return res.status(409).json({ error: 'Category name or slug already exists' });
    }
    res.status(500).json({ error: 'Failed to create category' });
  }
};

export const updateCategory = (req, res) => {
  try {
    const category = Category.update(req.params.id, req.body);
    if (!category) {
      return res.status(404).json({ error: 'Category not found' });
    }
    res.json(category);
  } catch (error) {
    console.error('Error updating category:', error);
    if (error.message.includes('UNIQUE constraint failed')) {
      return res.status(409).json({ error: 'Category name or slug already exists' });
    }
    res.status(500).json({ error: 'Failed to update category' });
  }
};

export const deleteCategory = (req, res) => {
  try {
    const result = Category.delete(req.params.id);
    if (result.changes === 0) {
      return res.status(404).json({ error: 'Category not found' });
    }
    res.status(204).send();
  } catch (error) {
    console.error('Error deleting category:', error);
    res.status(500).json({ error: 'Failed to delete category' });
  }
};

export const getCategoryStats = (req, res) => {
  try {
    const stats = Category.getStats(req.params.id);
    res.json(stats);
  } catch (error) {
    console.error('Error fetching category stats:', error);
    res.status(500).json({ error: 'Failed to fetch category stats' });
  }
};
