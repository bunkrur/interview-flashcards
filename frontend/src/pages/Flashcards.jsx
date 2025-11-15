import { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { flashcardsAPI, categoriesAPI } from '../services/api';
import LoadingSpinner from '../components/LoadingSpinner';
import AIGenerationModal from '../components/AIGenerationModal';
import ViewFlashcardModal from '../components/ViewFlashcardModal';

function Flashcards() {
  const [flashcards, setFlashcards] = useState([]);
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showAIModal, setShowAIModal] = useState(false);
  const [showViewModal, setShowViewModal] = useState(false);
  const [selectedFlashcard, setSelectedFlashcard] = useState(null);
  const [filters, setFilters] = useState({
    category_id: '',
    difficulty: '',
    search: '',
  });

  useEffect(() => {
    loadCategories();
  }, []);

  useEffect(() => {
    loadFlashcards();
  }, [filters]);

  const loadCategories = async () => {
    try {
      const response = await categoriesAPI.getAll();
      setCategories(response.data);
    } catch (error) {
      console.error('Error loading categories:', error);
    }
  };

  const loadFlashcards = async () => {
    try {
      setLoading(true);
      const cleanFilters = {};
      if (filters.category_id) cleanFilters.category_id = filters.category_id;
      if (filters.difficulty) cleanFilters.difficulty = filters.difficulty;
      if (filters.search) cleanFilters.search = filters.search;

      const response = await flashcardsAPI.getAll(cleanFilters);
      setFlashcards(response.data);
    } catch (error) {
      console.error('Error loading flashcards:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleFilterChange = (key, value) => {
    setFilters({ ...filters, [key]: value });
  };

  const handleView = (card) => {
    setSelectedFlashcard(card);
    setShowViewModal(true);
  };

  const handleDelete = async (id) => {
    if (!confirm('Are you sure you want to delete this flashcard?')) return;

    try {
      await flashcardsAPI.delete(id);
      loadFlashcards();
    } catch (error) {
      console.error('Error deleting flashcard:', error);
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900 mb-2">Flashcards</h1>
          <p className="text-gray-600">
            Manage your flashcard collection
          </p>
        </div>
        <div className="flex gap-2">
          <button
            onClick={() => setShowAIModal(true)}
            className="btn btn-secondary flex items-center gap-2"
          >
            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 10V3L4 14h7v7l9-11h-7z" />
            </svg>
            Generate with AI
          </button>
          <Link to="/flashcards/new" className="btn btn-primary">
            Create Flashcard
          </Link>
        </div>
      </div>

      {/* Filters */}
      <div className="card">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div>
            <label className="label">Search</label>
            <input
              type="text"
              className="input"
              placeholder="Search questions..."
              value={filters.search}
              onChange={(e) => handleFilterChange('search', e.target.value)}
            />
          </div>
          <div>
            <label className="label">Category</label>
            <select
              className="input"
              value={filters.category_id}
              onChange={(e) => handleFilterChange('category_id', e.target.value)}
            >
              <option value="">All Categories</option>
              {categories.map((cat) => (
                <option key={cat.id} value={cat.id}>
                  {cat.name}
                </option>
              ))}
            </select>
          </div>
          <div>
            <label className="label">Difficulty</label>
            <select
              className="input"
              value={filters.difficulty}
              onChange={(e) => handleFilterChange('difficulty', e.target.value)}
            >
              <option value="">All Difficulties</option>
              <option value="easy">Easy</option>
              <option value="medium">Medium</option>
              <option value="hard">Hard</option>
            </select>
          </div>
        </div>
      </div>

      {/* Results */}
      {loading ? (
        <LoadingSpinner message="Loading flashcards..." />
      ) : flashcards.length === 0 ? (
        <div className="card text-center py-12">
          <p className="text-gray-600 text-lg mb-4">No flashcards found</p>
          <Link to="/flashcards/new" className="btn btn-primary">
            Create Your First Flashcard
          </Link>
        </div>
      ) : (
        <div className="space-y-4">
          <div className="text-sm text-gray-600">
            Showing {flashcards.length} flashcard{flashcards.length !== 1 ? 's' : ''}
          </div>
          {flashcards.map((card) => (
            <div key={card.id} className="card hover:shadow-lg transition-shadow">
              <div className="flex items-start justify-between gap-4">
                <div className="flex-1">
                  <div className="flex items-center gap-2 mb-2">
                    <span
                      className="px-2 py-1 rounded text-xs font-medium"
                      style={{
                        backgroundColor: `${card.category_color}20`,
                        color: card.category_color,
                      }}
                    >
                      {card.category_name}
                    </span>
                    <span
                      className={`px-2 py-1 rounded text-xs font-medium ${
                        card.difficulty === 'easy'
                          ? 'bg-green-100 text-green-800'
                          : card.difficulty === 'medium'
                          ? 'bg-yellow-100 text-yellow-800'
                          : 'bg-red-100 text-red-800'
                      }`}
                    >
                      {card.difficulty}
                    </span>
                  </div>
                  <h3 className="text-lg font-semibold text-gray-900 mb-2">
                    {card.question}
                  </h3>
                  <p className="text-gray-600 line-clamp-2">{card.answer}</p>
                  {card.times_seen > 0 && (
                    <div className="mt-2 text-sm text-gray-500">
                      Studied {card.times_seen} times
                      {card.times_correct > 0 && ` • ${Math.round((card.times_correct / card.times_seen) * 100)}% correct`}
                    </div>
                  )}
                </div>
                <div className="flex gap-2">
                  <button
                    onClick={() => handleView(card)}
                    className="btn btn-secondary text-sm"
                  >
                    View
                  </button>
                  <Link
                    to={`/flashcards/${card.id}/edit`}
                    className="btn btn-secondary text-sm"
                  >
                    Edit
                  </Link>
                  <button
                    onClick={() => handleDelete(card.id)}
                    className="btn btn-danger text-sm"
                  >
                    Delete
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}

      <AIGenerationModal
        isOpen={showAIModal}
        onClose={() => setShowAIModal(false)}
        onSuccess={loadFlashcards}
        categories={categories}
      />

      <ViewFlashcardModal
        isOpen={showViewModal}
        onClose={() => setShowViewModal(false)}
        flashcard={selectedFlashcard}
      />
    </div>
  );
}

export default Flashcards;
