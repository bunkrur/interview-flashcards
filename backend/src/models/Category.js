import { getDatabase } from '../utils/database.js';

class Category {
  static getAll() {
    const db = getDatabase();
    return db.prepare(`
      SELECT
        c.*,
        COUNT(f.id) as card_count
      FROM categories c
      LEFT JOIN flashcards f ON c.id = f.category_id
      GROUP BY c.id
      ORDER BY c.name
    `).all();
  }

  static getById(id) {
    const db = getDatabase();
    const category = db.prepare(`
      SELECT
        c.*,
        COUNT(f.id) as card_count
      FROM categories c
      LEFT JOIN flashcards f ON c.id = f.category_id
      WHERE c.id = ?
      GROUP BY c.id
    `).get(id);

    return category;
  }

  static getBySlug(slug) {
    const db = getDatabase();
    return db.prepare(`
      SELECT
        c.*,
        COUNT(f.id) as card_count
      FROM categories c
      LEFT JOIN flashcards f ON c.id = f.category_id
      WHERE c.slug = ?
      GROUP BY c.id
    `).get(slug);
  }

  static create(data) {
    const db = getDatabase();
    const { name, slug, description, color, icon } = data;

    const result = db.prepare(`
      INSERT INTO categories (name, slug, description, color, icon)
      VALUES (?, ?, ?, ?, ?)
    `).run(name, slug, description, color, icon);

    return this.getById(result.lastInsertRowid);
  }

  static update(id, data) {
    const db = getDatabase();
    const { name, slug, description, color, icon } = data;

    db.prepare(`
      UPDATE categories
      SET name = ?, slug = ?, description = ?, color = ?, icon = ?
      WHERE id = ?
    `).run(name, slug, description, color, icon, id);

    return this.getById(id);
  }

  static delete(id) {
    const db = getDatabase();
    return db.prepare('DELETE FROM categories WHERE id = ?').run(id);
  }

  static getStats(id) {
    const db = getDatabase();
    return db.prepare(`
      SELECT
        COUNT(DISTINCT f.id) as total_cards,
        COUNT(DISTINCT ss.id) as total_reviews,
        SUM(CASE WHEN cr.next_review_date <= datetime('now') THEN 1 ELSE 0 END) as due_cards,
        ROUND(AVG(CASE WHEN cr.repetitions > 0 THEN cr.ease_factor END), 2) as avg_ease_factor,
        COUNT(DISTINCT CASE WHEN cr.repetitions >= 3 THEN f.id END) as mastered_cards
      FROM flashcards f
      LEFT JOIN card_reviews cr ON f.id = cr.card_id
      LEFT JOIN study_sessions ss ON f.id = ss.card_id
      WHERE f.category_id = ?
    `).get(id);
  }
}

export default Category;
