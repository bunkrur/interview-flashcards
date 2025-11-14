import { getDatabase } from '../utils/database.js';

class CardReview {
  static getByCardId(cardId) {
    const db = getDatabase();
    return db.prepare(`
      SELECT * FROM card_reviews WHERE card_id = ?
    `).get(cardId);
  }

  static getDueCards(categoryId = null) {
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
      JOIN card_reviews cr ON f.id = cr.card_id
      WHERE cr.next_review_date <= datetime('now')
    `;

    const params = [];

    if (categoryId) {
      query += ' AND f.category_id = ?';
      params.push(categoryId);
    }

    query += ' ORDER BY cr.next_review_date ASC';

    return db.prepare(query).all(...params);
  }

  static getNextCard(categoryId = null) {
    const dueCards = this.getDueCards(categoryId);
    return dueCards.length > 0 ? dueCards[0] : null;
  }

  static updateReview(cardId, qualityRating, responseTime = null) {
    const db = getDatabase();
    const review = this.getByCardId(cardId);

    if (!review) {
      throw new Error('Review record not found');
    }

    // SM-2 Algorithm implementation
    const { ease_factor: oldEF, repetitions: oldReps, interval: oldInterval } = review;

    let newEF = oldEF;
    let newReps = oldReps;
    let newInterval = oldInterval;

    // Calculate new ease factor
    newEF = oldEF + (0.1 - (5 - qualityRating) * (0.08 + (5 - qualityRating) * 0.02));
    newEF = Math.max(1.3, newEF); // Minimum ease factor is 1.3

    if (qualityRating < 3) {
      // Failed recall - reset
      newReps = 0;
      newInterval = 1;
    } else {
      // Successful recall - increase interval
      newReps = oldReps + 1;

      if (newReps === 1) {
        newInterval = 1;
      } else if (newReps === 2) {
        newInterval = 6;
      } else {
        newInterval = Math.round(oldInterval * newEF);
      }
    }

    // Calculate next review date
    const nextReviewDate = new Date();
    nextReviewDate.setDate(nextReviewDate.getDate() + newInterval);

    // Update quality_responses array
    const qualityResponses = JSON.parse(review.quality_responses || '[]');
    qualityResponses.push({
      rating: qualityRating,
      timestamp: new Date().toISOString(),
      ease_factor: newEF,
      interval: newInterval
    });

    // Keep only last 50 responses
    if (qualityResponses.length > 50) {
      qualityResponses.shift();
    }

    // Update card_reviews
    db.prepare(`
      UPDATE card_reviews
      SET
        ease_factor = ?,
        interval = ?,
        repetitions = ?,
        next_review_date = ?,
        last_reviewed_at = CURRENT_TIMESTAMP,
        quality_responses = ?,
        times_seen = times_seen + 1,
        times_correct = times_correct + ?
      WHERE card_id = ?
    `).run(
      newEF,
      newInterval,
      newReps,
      nextReviewDate.toISOString(),
      JSON.stringify(qualityResponses),
      qualityRating >= 3 ? 1 : 0,
      cardId
    );

    return this.getByCardId(cardId);
  }

  static resetCard(cardId) {
    const db = getDatabase();
    db.prepare(`
      UPDATE card_reviews
      SET
        ease_factor = 2.5,
        interval = 1,
        repetitions = 0,
        next_review_date = datetime('now'),
        quality_responses = '[]',
        times_seen = 0,
        times_correct = 0
      WHERE card_id = ?
    `).run(cardId);

    return this.getByCardId(cardId);
  }

  static resetAllProgress() {
    const db = getDatabase();

    // Reset all card reviews to initial state
    db.prepare(`
      UPDATE card_reviews
      SET
        ease_factor = 2.5,
        interval = 1,
        repetitions = 0,
        next_review_date = datetime('now'),
        quality_responses = '[]',
        times_seen = 0,
        times_correct = 0,
        last_reviewed_at = NULL
    `).run();

    // Delete all study sessions
    db.prepare('DELETE FROM study_sessions').run();

    return { message: 'All progress has been reset' };
  }
}

export default CardReview;
