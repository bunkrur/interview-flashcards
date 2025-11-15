import express from 'express';
import { explainAnswer, askQuestion, generateFlashcards, suggestEmoji, enhanceFlashcard } from '../controllers/aiController.js';

const router = express.Router();

router.post('/explain', explainAnswer);
router.post('/ask', askQuestion);
router.post('/generate-flashcards', generateFlashcards);
router.post('/suggest-emoji', suggestEmoji);
router.post('/enhance-flashcard', enhanceFlashcard);

export default router;
