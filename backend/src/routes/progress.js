import express from 'express';
import {
  getOverallStats,
  getCategoryStats,
  getStudyHistory,
  getDailyActivity,
  resetProgress
} from '../controllers/progressController.js';

const router = express.Router();

router.get('/stats', getOverallStats);
router.get('/category/:categoryId/stats', getCategoryStats);
router.get('/history', getStudyHistory);
router.get('/activity', getDailyActivity);
router.post('/reset', resetProgress);

export default router;
