import express from 'express';
import {
  getDueCards,
  getNextCard,
  submitReview,
  resetCard
} from '../controllers/studyController.js';

const router = express.Router();

router.get('/due', getDueCards);
router.get('/next', getNextCard);
router.post('/review', submitReview);
router.post('/reset/:cardId', resetCard);

export default router;
