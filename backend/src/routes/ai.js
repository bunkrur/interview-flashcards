import express from 'express';
import { explainAnswer, askQuestion } from '../controllers/aiController.js';

const router = express.Router();

router.post('/explain', explainAnswer);
router.post('/ask', askQuestion);

export default router;
