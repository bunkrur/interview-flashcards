import CardReview from '../models/CardReview.js';
import StudySession from '../models/StudySession.js';

export const getDueCards = (req, res) => {
  try {
    const categoryId = req.query.category_id ? parseInt(req.query.category_id) : null;
    const dueCards = CardReview.getDueCards(categoryId);
    res.json(dueCards);
  } catch (error) {
    console.error('Error fetching due cards:', error);
    res.status(500).json({ error: 'Failed to fetch due cards' });
  }
};

export const getNextCard = (req, res) => {
  try {
    const categoryId = req.query.category_id ? parseInt(req.query.category_id) : null;
    const nextCard = CardReview.getNextCard(categoryId);

    if (!nextCard) {
      return res.json({ message: 'No cards due for review', card: null });
    }

    res.json(nextCard);
  } catch (error) {
    console.error('Error fetching next card:', error);
    res.status(500).json({ error: 'Failed to fetch next card' });
  }
};

export const submitReview = (req, res) => {
  try {
    const { card_id, category_id, quality_rating, response_time_seconds } = req.body;

    if (!card_id || !category_id || quality_rating === undefined) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    if (quality_rating < 0 || quality_rating > 5) {
      return res.status(400).json({ error: 'Quality rating must be between 0 and 5' });
    }

    // Update card review using SM-2 algorithm
    const updatedReview = CardReview.updateReview(card_id, quality_rating, response_time_seconds);

    // Create study session record
    const session = StudySession.create({
      card_id,
      category_id,
      quality_rating,
      response_time_seconds
    });

    res.json({
      review: updatedReview,
      session: session,
      message: 'Review submitted successfully'
    });
  } catch (error) {
    console.error('Error submitting review:', error);
    res.status(500).json({ error: 'Failed to submit review' });
  }
};

export const resetCard = (req, res) => {
  try {
    const cardId = req.params.cardId;
    const resetReview = CardReview.resetCard(cardId);
    res.json(resetReview);
  } catch (error) {
    console.error('Error resetting card:', error);
    res.status(500).json({ error: 'Failed to reset card' });
  }
};
