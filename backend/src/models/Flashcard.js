import { getDatabase } from '../utils/database.js';

class Flashcard {
  static getAll(filters = {}) {
    const db = getDatabase();
    let query = `
      SELECT
        f.*,
        c.name as category_name,
        c.slug as category_slug,
        c.color as category_color,
        cr.ease_factor,
        cr.interval,
        cr.repetitions,
        cr.next_review_date,
        cr.times_seen,
        cr.times_correct
      FROM flashcards f
      JOIN categories c ON f.category_id = c.id
      LEFT JOIN card_reviews cr ON f.id = cr.card_id
      WHERE 1=1
    `;

    const params = [];

    if (filters.category_id) {
      query += ' AND f.category_id = ?';
      params.push(filters.category_id);
    }

    if (filters.difficulty) {
      query += ' AND f.difficulty = ?';
      params.push(filters.difficulty);
    }

    if (filters.search) {
      query += ' AND (f.question LIKE ? OR f.answer LIKE ? OR f.explanation LIKE ?)';
      const searchTerm = `%${filters.search}%`;
      params.push(searchTerm, searchTerm, searchTerm);
    }

    query += ' ORDER BY f.created_at DESC';

    if (filters.limit) {
      query += ' LIMIT ?';
      params.push(filters.limit);
    }

    return db.prepare(query).all(...params);
  }

  static getById(id) {
    const db = getDatabase();
    return db.prepare(`
      SELECT
        f.*,
        c.name as category_name,
        c.slug as category_slug,
        c.color as category_color,
        cr.ease_factor,
        cr.interval,
        cr.repetitions,
        cr.next_review_date,
        cr.times_seen,
        cr.times_correct,
        cr.quality_responses
      FROM flashcards f
      JOIN categories c ON f.category_id = c.id
      LEFT JOIN card_reviews cr ON f.id = cr.card_id
      WHERE f.id = ?
    `).get(id);
  }

  static getByCategoryId(categoryId) {
    const db = getDatabase();
    return db.prepare(`
      SELECT
        f.*,
        cr.ease_factor,
        cr.interval,
        cr.repetitions,
        cr.next_review_date,
        cr.times_seen,
        cr.times_correct
      FROM flashcards f
      LEFT JOIN card_reviews cr ON f.id = cr.card_id
      WHERE f.category_id = ?
      ORDER BY f.created_at DESC
    `).all(categoryId);
  }

  static create(data) {
    const db = getDatabase();
    const { category_id, question, answer, code_snippet, difficulty, explanation } = data;

    const result = db.prepare(`
      INSERT INTO flashcards (category_id, question, answer, code_snippet, difficulty, explanation)
      VALUES (?, ?, ?, ?, ?, ?)
    `).run(category_id, question, answer, code_snippet || null, difficulty || 'medium', explanation || null);

    const cardId = result.lastInsertRowid;

    // Initialize card review record
    db.prepare(`
      INSERT INTO card_reviews (card_id, ease_factor, interval, repetitions, next_review_date)
      VALUES (?, 2.5, 1, 0, datetime('now'))
    `).run(cardId);

    return this.getById(cardId);
  }

  static update(id, data) {
    const db = getDatabase();
    const { category_id, question, answer, code_snippet, difficulty, explanation } = data;

    db.prepare(`
      UPDATE flashcards
      SET category_id = ?, question = ?, answer = ?, code_snippet = ?, difficulty = ?, explanation = ?, updated_at = CURRENT_TIMESTAMP
      WHERE id = ?
    `).run(category_id, question, answer, code_snippet || null, difficulty, explanation || null, id);

    return this.getById(id);
  }

  static delete(id) {
    const db = getDatabase();
    return db.prepare('DELETE FROM flashcards WHERE id = ?').run(id);
  }
}

export default Flashcard;
