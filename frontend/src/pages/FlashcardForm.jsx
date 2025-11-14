import { useEffect, useState } from 'react';
import { useParams, useNavigate, useSearchParams } from 'react-router-dom';
import { flashcardsAPI, categoriesAPI } from '../services/api';
import LoadingSpinner from '../components/LoadingSpinner';

function FlashcardForm() {
  const { id } = useParams();
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const isEditing = Boolean(id);

  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [formData, setFormData] = useState({
    category_id: searchParams.get('category') || '',
    question: '',
    answer: '',
    code_snippet: '',
    difficulty: 'medium',
    explanation: '',
  });

  useEffect(() => {
    loadData();
  }, [id]);

  const loadData = async () => {
    try {
      const categoriesRes = await categoriesAPI.getAll();
      setCategories(categoriesRes.data);

      if (id) {
        const cardRes = await flashcardsAPI.getById(id);
        const card = cardRes.data;
        setFormData({
          category_id: card.category_id,
          question: card.question,
          answer: card.answer,
          code_snippet: card.code_snippet || '',
          difficulty: card.difficulty,
          explanation: card.explanation || '',
        });
      }
    } catch (error) {
      console.error('Error loading data:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!formData.category_id || !formData.question || !formData.answer) {
      alert('Please fill in all required fields');
      return;
    }

    setSaving(true);

    try {
      const data = {
        ...formData,
        category_id: parseInt(formData.category_id),
      };

      if (isEditing) {
        await flashcardsAPI.update(id, data);
      } else {
        await flashcardsAPI.create(data);
      }

      navigate('/flashcards');
    } catch (error) {
      console.error('Error saving flashcard:', error);
      alert('Failed to save flashcard');
    } finally {
      setSaving(false);
    }
  };

  if (loading) {
    return <LoadingSpinner message="Loading..." />;
  }

  return (
    <div className="max-w-3xl mx-auto">
      <div className="mb-6">
        <h1 className="text-3xl font-bold text-gray-900 mb-2">
          {isEditing ? 'Edit Flashcard' : 'Create New Flashcard'}
        </h1>
        <p className="text-gray-600">
          {isEditing
            ? 'Update the flashcard details below'
            : 'Fill in the details to create a new flashcard'}
        </p>
      </div>

      <form onSubmit={handleSubmit} className="card space-y-6">
        {/* Category */}
        <div>
          <label className="label">
            Category <span className="text-red-500">*</span>
          </label>
          <select
            name="category_id"
            className="input"
            value={formData.category_id}
            onChange={handleChange}
            required
          >
            <option value="">Select a category</option>
            {categories.map((cat) => (
              <option key={cat.id} value={cat.id}>
                {cat.icon} {cat.name}
              </option>
            ))}
          </select>
        </div>

        {/* Question */}
        <div>
          <label className="label">
            Question <span className="text-red-500">*</span>
          </label>
          <textarea
            name="question"
            className="input"
            rows="3"
            placeholder="Enter the question..."
            value={formData.question}
            onChange={handleChange}
            required
          ></textarea>
        </div>

        {/* Answer */}
        <div>
          <label className="label">
            Answer <span className="text-red-500">*</span>
          </label>
          <textarea
            name="answer"
            className="input"
            rows="4"
            placeholder="Enter the answer..."
            value={formData.answer}
            onChange={handleChange}
            required
          ></textarea>
        </div>

        {/* Code Snippet */}
        <div>
          <label className="label">Code Snippet (Optional)</label>
          <textarea
            name="code_snippet"
            className="input font-mono text-sm"
            rows="6"
            placeholder="Paste code example here..."
            value={formData.code_snippet}
            onChange={handleChange}
          ></textarea>
        </div>

        {/* Difficulty */}
        <div>
          <label className="label">
            Difficulty <span className="text-red-500">*</span>
          </label>
          <select
            name="difficulty"
            className="input"
            value={formData.difficulty}
            onChange={handleChange}
            required
          >
            <option value="easy">Easy</option>
            <option value="medium">Medium</option>
            <option value="hard">Hard</option>
          </select>
        </div>

        {/* Explanation */}
        <div>
          <label className="label">Explanation (Optional)</label>
          <textarea
            name="explanation"
            className="input"
            rows="3"
            placeholder="Add additional context or explanation..."
            value={formData.explanation}
            onChange={handleChange}
          ></textarea>
        </div>

        {/* Buttons */}
        <div className="flex gap-4 pt-4">
          <button
            type="submit"
            className="btn btn-primary flex-1"
            disabled={saving}
          >
            {saving
              ? 'Saving...'
              : isEditing
              ? 'Update Flashcard'
              : 'Create Flashcard'}
          </button>
          <button
            type="button"
            onClick={() => navigate('/flashcards')}
            className="btn btn-secondary"
            disabled={saving}
          >
            Cancel
          </button>
        </div>
      </form>
    </div>
  );
}

export default FlashcardForm;
