import express from 'express';
import {
  getAllFlashcards,
  getFlashcardById,
  getFlashcardsByCategory,
  createFlashcard,
  updateFlashcard,
  deleteFlashcard,
  exportToSQL
} from '../controllers/flashcardController.js';

const router = express.Router();

router.get('/', getAllFlashcards);
router.get('/export', exportToSQL);
router.get('/:id', getFlashcardById);
router.get('/category/:categoryId', getFlashcardsByCategory);
router.post('/', createFlashcard);
router.put('/:id', updateFlashcard);
router.delete('/:id', deleteFlashcard);

export default router;
