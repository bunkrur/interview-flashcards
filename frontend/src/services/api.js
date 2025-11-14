import axios from 'axios';

const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:3001/api';

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Categories
export const categoriesAPI = {
  getAll: () => api.get('/categories'),
  getById: (id) => api.get(`/categories/${id}`),
  getBySlug: (slug) => api.get(`/categories/slug/${slug}`),
  getStats: (id) => api.get(`/categories/${id}/stats`),
  create: (data) => api.post('/categories', data),
  update: (id, data) => api.put(`/categories/${id}`, data),
  delete: (id) => api.delete(`/categories/${id}`),
};

// Flashcards
export const flashcardsAPI = {
  getAll: (filters) => api.get('/flashcards', { params: filters }),
  getById: (id) => api.get(`/flashcards/${id}`),
  getByCategory: (categoryId) => api.get(`/flashcards/category/${categoryId}`),
  create: (data) => api.post('/flashcards', data),
  update: (id, data) => api.put(`/flashcards/${id}`, data),
  delete: (id) => api.delete(`/flashcards/${id}`),
  exportToSQL: () => {
    // Trigger file download
    const downloadUrl = `${API_BASE_URL}/flashcards/export`;
    const link = document.createElement('a');
    link.href = downloadUrl;
    link.download = '';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    return Promise.resolve();
  },
};

// Study
export const studyAPI = {
  getDueCards: (categoryId) => api.get('/study/due', { params: { category_id: categoryId } }),
  getNextCard: (categoryId) => api.get('/study/next', { params: { category_id: categoryId } }),
  submitReview: (data) => api.post('/study/review', data),
  resetCard: (cardId) => api.post(`/study/reset/${cardId}`),
};

// Progress
export const progressAPI = {
  getOverallStats: () => api.get('/progress/stats'),
  getCategoryStats: (categoryId) => api.get(`/progress/category/${categoryId}/stats`),
  getHistory: (filters) => api.get('/progress/history', { params: filters }),
  getDailyActivity: (days) => api.get('/progress/activity', { params: { days } }),
  resetProgress: () => api.post('/progress/reset'),
};

// AI
export const aiAPI = {
  explainAnswer: (data) => api.post('/ai/explain', data),
  askQuestion: (data) => api.post('/ai/ask', data),
};

export default api;
