import Flashcard from '../models/Flashcard.js';
import { getDatabase } from '../utils/database.js';

export const getAllFlashcards = (req, res) => {
  try {
    const filters = {
      category_id: req.query.category_id,
      difficulty: req.query.difficulty,
      search: req.query.search,
      limit: req.query.limit ? parseInt(req.query.limit) : null
    };

    const flashcards = Flashcard.getAll(filters);
    res.json(flashcards);
  } catch (error) {
    console.error('Error fetching flashcards:', error);
    res.status(500).json({ error: 'Failed to fetch flashcards' });
  }
};

export const getFlashcardById = (req, res) => {
  try {
    const flashcard = Flashcard.getById(req.params.id);
    if (!flashcard) {
      return res.status(404).json({ error: 'Flashcard not found' });
    }
    res.json(flashcard);
  } catch (error) {
    console.error('Error fetching flashcard:', error);
    res.status(500).json({ error: 'Failed to fetch flashcard' });
  }
};

export const getFlashcardsByCategory = (req, res) => {
  try {
    const flashcards = Flashcard.getByCategoryId(req.params.categoryId);
    res.json(flashcards);
  } catch (error) {
    console.error('Error fetching flashcards:', error);
    res.status(500).json({ error: 'Failed to fetch flashcards' });
  }
};

export const createFlashcard = (req, res) => {
  try {
    const flashcard = Flashcard.create(req.body);
    res.status(201).json(flashcard);
  } catch (error) {
    console.error('Error creating flashcard:', error);
    res.status(500).json({ error: 'Failed to create flashcard' });
  }
};

export const createBulkFlashcards = (req, res) => {
  try {
    const { flashcards, category_id } = req.body;

    if (!Array.isArray(flashcards) || flashcards.length === 0) {
      return res.status(400).json({ error: 'Flashcards array is required' });
    }

    if (!category_id) {
      return res.status(400).json({ error: 'Category ID is required' });
    }

    const createdFlashcards = flashcards.map(card => {
      return Flashcard.create({
        ...card,
        category_id
      });
    });

    res.status(201).json({
      count: createdFlashcards.length,
      flashcards: createdFlashcards
    });
  } catch (error) {
    console.error('Error creating bulk flashcards:', error);
    res.status(500).json({ error: 'Failed to create flashcards' });
  }
};

export const updateFlashcard = (req, res) => {
  try {
    const flashcard = Flashcard.update(req.params.id, req.body);
    if (!flashcard) {
      return res.status(404).json({ error: 'Flashcard not found' });
    }
    res.json(flashcard);
  } catch (error) {
    console.error('Error updating flashcard:', error);
    res.status(500).json({ error: 'Failed to update flashcard' });
  }
};

export const deleteFlashcard = (req, res) => {
  try {
    const result = Flashcard.delete(req.params.id);
    if (result.changes === 0) {
      return res.status(404).json({ error: 'Flashcard not found' });
    }
    res.status(204).send();
  } catch (error) {
    console.error('Error deleting flashcard:', error);
    res.status(500).json({ error: 'Failed to delete flashcard' });
  }
};

export const exportToSQL = (req, res) => {
  try {
    const db = getDatabase();

    // Get all categories
    const categories = db.prepare('SELECT * FROM categories ORDER BY id').all();

    // Get all flashcards ordered by category
    const flashcards = db.prepare(`
      SELECT * FROM flashcards
      ORDER BY category_id, id
    `).all();

    // Helper function to escape single quotes in SQL strings
    const escapeSql = (str) => {
      if (!str) return '';
      return str.replace(/'/g, "''");
    };

    // Generate SQL content
    let sql = `-- Flashcard Database Export
-- Generated on ${new Date().toISOString()}
-- Total Categories: ${categories.length}
-- Total Flashcards: ${flashcards.length}

-- Categories
INSERT INTO categories (name, slug, description, color, icon) VALUES\n`;

    // Add categories
    const categoryValues = categories.map(cat =>
      `    ('${escapeSql(cat.name)}', '${escapeSql(cat.slug)}', '${escapeSql(cat.description)}', '${escapeSql(cat.color)}', '${escapeSql(cat.icon)}')`
    );
    sql += categoryValues.join(',\n') + ';\n\n';

    // Group flashcards by category
    const flashcardsByCategory = {};
    flashcards.forEach(card => {
      if (!flashcardsByCategory[card.category_id]) {
        flashcardsByCategory[card.category_id] = [];
      }
      flashcardsByCategory[card.category_id].push(card);
    });

    // Add flashcards organized by category
    for (const categoryId in flashcardsByCategory) {
      const category = categories.find(c => c.id === parseInt(categoryId));
      const cards = flashcardsByCategory[categoryId];

      sql += `-- Flashcards for ${category.name} (${cards.length} cards)\n`;
      sql += 'INSERT INTO flashcards (category_id, question, answer, difficulty, explanation, code_snippet) VALUES\n';

      const cardValues = cards.map(card => {
        const codeSnippet = card.code_snippet ? `'${escapeSql(card.code_snippet)}'` : 'NULL';
        const explanation = card.explanation ? `'${escapeSql(card.explanation)}'` : 'NULL';
        return `    (${card.category_id}, '${escapeSql(card.question)}', '${escapeSql(card.answer)}', '${card.difficulty}', ${explanation}, ${codeSnippet})`;
      });

      sql += cardValues.join(',\n') + ';\n\n';
    }

    // Set headers for file download
    const filename = `flashcards_export_${new Date().toISOString().split('T')[0]}.sql`;
    res.setHeader('Content-Type', 'application/sql');
    res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);
    res.send(sql);

  } catch (error) {
    console.error('Error exporting flashcards:', error);
    res.status(500).json({ error: 'Failed to export flashcards' });
  }
};
