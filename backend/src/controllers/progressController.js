import StudySession from '../models/StudySession.js';
import CardReview from '../models/CardReview.js';
import { getDatabase } from '../utils/database.js';

export const getOverallStats = (req, res) => {
  try {
    const db = getDatabase();

    // Get basic study stats
    const studyStats = StudySession.getStats();

    // Get streak info
    const streakInfo = StudySession.getStreakInfo();

    // Get due cards count
    const dueCards = CardReview.getDueCards();

    // Get mastery levels
    const masteryLevels = db.prepare(`
      SELECT
        CASE
          WHEN repetitions = 0 THEN 'new'
          WHEN repetitions < 3 THEN 'learning'
          WHEN repetitions >= 3 AND repetitions < 6 THEN 'familiar'
          ELSE 'mastered'
        END as level,
        COUNT(*) as count
      FROM card_reviews
      GROUP BY level
    `).all();

    // Get total cards
    const totalCards = db.prepare('SELECT COUNT(*) as count FROM flashcards').get();

    res.json({
      study_stats: studyStats,
      streak: streakInfo,
      due_cards_count: dueCards.length,
      mastery_levels: masteryLevels,
      total_cards: totalCards.count
    });
  } catch (error) {
    console.error('Error fetching overall stats:', error);
    res.status(500).json({ error: 'Failed to fetch overall stats' });
  }
};

export const getCategoryStats = (req, res) => {
  try {
    const categoryId = parseInt(req.params.categoryId);

    // Get category-specific study stats
    const studyStats = StudySession.getStats(categoryId);

    // Get due cards for category
    const dueCards = CardReview.getDueCards(categoryId);

    res.json({
      study_stats: studyStats,
      due_cards_count: dueCards.length
    });
  } catch (error) {
    console.error('Error fetching category stats:', error);
    res.status(500).json({ error: 'Failed to fetch category stats' });
  }
};

export const getStudyHistory = (req, res) => {
  try {
    const filters = {
      category_id: req.query.category_id ? parseInt(req.query.category_id) : null,
      start_date: req.query.start_date,
      end_date: req.query.end_date,
      limit: req.query.limit ? parseInt(req.query.limit) : 100
    };

    const history = StudySession.getHistory(filters);
    res.json(history);
  } catch (error) {
    console.error('Error fetching study history:', error);
    res.status(500).json({ error: 'Failed to fetch study history' });
  }
};

export const getDailyActivity = (req, res) => {
  try {
    const days = req.query.days ? parseInt(req.query.days) : 30;
    const activity = StudySession.getDailyActivity(days);
    res.json(activity);
  } catch (error) {
    console.error('Error fetching daily activity:', error);
    res.status(500).json({ error: 'Failed to fetch daily activity' });
  }
};

export const resetProgress = (req, res) => {
  try {
    const result = CardReview.resetAllProgress();
    res.json(result);
  } catch (error) {
    console.error('Error resetting progress:', error);
    res.status(500).json({ error: 'Failed to reset progress' });
  }
};
