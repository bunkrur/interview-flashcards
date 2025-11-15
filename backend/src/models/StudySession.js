import { getDatabase } from '../utils/database.js';

class StudySession {
  static create(data) {
    const db = getDatabase();
    const { card_id, category_id, quality_rating, response_time_seconds } = data;

    const result = db.prepare(`
      INSERT INTO study_sessions (card_id, category_id, quality_rating, response_time_seconds)
      VALUES (?, ?, ?, ?)
    `).run(card_id, category_id, quality_rating, response_time_seconds || null);

    return this.getById(result.lastInsertRowid);
  }

  static getById(id) {
    const db = getDatabase();
    return db.prepare(`
      SELECT
        ss.*,
        f.question,
        c.name as category_name
      FROM study_sessions ss
      JOIN flashcards f ON ss.card_id = f.id
      JOIN categories c ON ss.category_id = c.id
      WHERE ss.id = ?
    `).get(id);
  }

  static getHistory(filters = {}) {
    const db = getDatabase();
    let query = `
      SELECT
        ss.*,
        f.question,
        f.difficulty,
        c.name as category_name,
        c.color as category_color
      FROM study_sessions ss
      JOIN flashcards f ON ss.card_id = f.id
      JOIN categories c ON ss.category_id = c.id
      WHERE 1=1
    `;

    const params = [];

    if (filters.category_id) {
      query += ' AND ss.category_id = ?';
      params.push(filters.category_id);
    }

    if (filters.start_date) {
      query += ' AND ss.reviewed_at >= ?';
      params.push(filters.start_date);
    }

    if (filters.end_date) {
      query += ' AND ss.reviewed_at <= ?';
      params.push(filters.end_date);
    }

    query += ' ORDER BY ss.reviewed_at DESC';

    if (filters.limit) {
      query += ' LIMIT ?';
      params.push(filters.limit);
    }

    return db.prepare(query).all(...params);
  }

  static getStats(categoryId = null) {
    const db = getDatabase();
    let query = `
      SELECT
        COUNT(*) as total_reviews,
        SUM(CASE WHEN quality_rating >= 3 THEN 1 ELSE 0 END) as successful_reviews,
        ROUND(AVG(quality_rating), 2) as avg_quality,
        ROUND(AVG(response_time_seconds), 0) as avg_response_time,
        COUNT(DISTINCT card_id) as unique_cards_studied,
        COUNT(DISTINCT DATE(reviewed_at)) as study_days,
        MAX(DATE(reviewed_at)) as last_study_date
      FROM study_sessions
      WHERE 1=1
    `;

    const params = [];

    if (categoryId) {
      query += ' AND category_id = ?';
      params.push(categoryId);
    }

    return db.prepare(query).get(...params);
  }

  static getStreakInfo() {
    const db = getDatabase();

    // Get all study dates
    const studyDates = db.prepare(`
      SELECT DISTINCT DATE(reviewed_at) as study_date
      FROM study_sessions
      ORDER BY study_date DESC
    `).all();

    if (studyDates.length === 0) {
      return { current_streak: 0, longest_streak: 0, total_days: 0 };
    }

    let currentStreak = 0;
    let longestStreak = 0;
    let tempStreak = 1;

    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const yesterday = new Date(today);
    yesterday.setDate(yesterday.getDate() - 1);

    const lastStudyDate = new Date(studyDates[0].study_date);
    lastStudyDate.setHours(0, 0, 0, 0);

    // Check if current streak is active (studied today or yesterday)
    if (lastStudyDate.getTime() === today.getTime() || lastStudyDate.getTime() === yesterday.getTime()) {
      currentStreak = 1;

      // Calculate current streak
      for (let i = 1; i < studyDates.length; i++) {
        const currentDate = new Date(studyDates[i].study_date);
        const prevDate = new Date(studyDates[i - 1].study_date);

        const diffDays = Math.round((prevDate - currentDate) / (1000 * 60 * 60 * 24));

        if (diffDays === 1) {
          currentStreak++;
        } else {
          break;
        }
      }
    }

    // Calculate longest streak
    for (let i = 1; i < studyDates.length; i++) {
      const currentDate = new Date(studyDates[i].study_date);
      const prevDate = new Date(studyDates[i - 1].study_date);

      const diffDays = Math.round((prevDate - currentDate) / (1000 * 60 * 60 * 24));

      if (diffDays === 1) {
        tempStreak++;
      } else {
        longestStreak = Math.max(longestStreak, tempStreak);
        tempStreak = 1;
      }
    }

    longestStreak = Math.max(longestStreak, tempStreak);

    return {
      current_streak: currentStreak,
      longest_streak: longestStreak,
      total_days: studyDates.length
    };
  }

  static getDailyActivity(days = 30) {
    const db = getDatabase();

    const startDate = new Date();
    startDate.setDate(startDate.getDate() - days);

    return db.prepare(`
      SELECT
        DATE(reviewed_at) as date,
        COUNT(*) as review_count,
        COUNT(DISTINCT card_id) as unique_cards,
        SUM(CASE WHEN quality_rating >= 3 THEN 1 ELSE 0 END) as successful_reviews
      FROM study_sessions
      WHERE reviewed_at >= ?
      GROUP BY DATE(reviewed_at)
      ORDER BY date ASC
    `).all(startDate.toISOString());
  }
}

export default StudySession;
