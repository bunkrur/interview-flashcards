import { useState } from 'react';
import { aiAPI, flashcardsAPI, categoriesAPI } from '../services/api';
import LoadingSpinner from './LoadingSpinner';

function AIGenerationModal({ isOpen, onClose, onSuccess, categories }) {
  const [text, setText] = useState('');
  const [categoryId, setCategoryId] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [generatedFlashcards, setGeneratedFlashcards] = useState(null);
  const [selectedCards, setSelectedCards] = useState(new Set());

  const handleGenerate = async () => {
    if (!text.trim()) {
      setError('Please enter some text to generate flashcards from');
      return;
    }

    if (!categoryId) {
      setError('Please select a category');
      return;
    }

    setError('');
    setLoading(true);

    try {
      const response = await aiAPI.generateFlashcards({
        text: text.trim(),
        category_id: categoryId,
      });

      setGeneratedFlashcards(response.data.flashcards);
      // Select all cards by default
      const allCardIds = new Set(response.data.flashcards.map((_, index) => index));
      setSelectedCards(allCardIds);
    } catch (err) {
      console.error('Error generating flashcards:', err);
      setError(err.response?.data?.message || 'Failed to generate flashcards. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const handleSave = async () => {
    if (selectedCards.size === 0) {
      setError('Please select at least one flashcard to save');
      return;
    }

    setError('');
    setLoading(true);

    try {
      const flashcardsToSave = generatedFlashcards.filter((_, index) =>
        selectedCards.has(index)
      );

      await flashcardsAPI.createBulk({
        flashcards: flashcardsToSave,
        category_id: categoryId,
      });

      onSuccess();
      handleClose();
    } catch (err) {
      console.error('Error saving flashcards:', err);
      setError(err.response?.data?.message || 'Failed to save flashcards. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const handleClose = () => {
    setText('');
    setCategoryId('');
    setGeneratedFlashcards(null);
    setSelectedCards(new Set());
    setError('');
    onClose();
  };

  const toggleCardSelection = (index) => {
    const newSelection = new Set(selectedCards);
    if (newSelection.has(index)) {
      newSelection.delete(index);
    } else {
      newSelection.add(index);
    }
    setSelectedCards(newSelection);
  };

  const toggleSelectAll = () => {
    if (selectedCards.size === generatedFlashcards.length) {
      setSelectedCards(new Set());
    } else {
      const allCardIds = new Set(generatedFlashcards.map((_, index) => index));
      setSelectedCards(allCardIds);
    }
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-lg max-w-4xl w-full max-h-[90vh] overflow-y-auto">
        <div className="sticky top-0 bg-white border-b border-gray-200 p-6">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-2xl font-bold text-gray-900">
              {generatedFlashcards ? 'Review Generated Flashcards' : 'Generate Flashcards with AI'}
            </h2>
            <button
              onClick={handleClose}
              className="text-gray-400 hover:text-gray-600"
              disabled={loading}
            >
              <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>

          {error && (
            <div className="mb-4 p-4 bg-red-50 border border-red-200 rounded-lg text-red-700">
              {error}
            </div>
          )}
        </div>

        <div className="p-6">
          {!generatedFlashcards ? (
            <>
              <div className="space-y-4">
                <div>
                  <label className="label">Category</label>
                  <select
                    className="input"
                    value={categoryId}
                    onChange={(e) => setCategoryId(e.target.value)}
                    disabled={loading}
                  >
                    <option value="">Select a category</option>
                    {categories.map((cat) => (
                      <option key={cat.id} value={cat.id}>
                        {cat.name}
                      </option>
                    ))}
                  </select>
                </div>

                <div>
                  <label className="label">
                    Informational Text
                    <span className="text-sm text-gray-500 ml-2">
                      Paste documentation, articles, or notes to generate flashcards
                    </span>
                  </label>
                  <textarea
                    className="input min-h-[300px] font-mono text-sm"
                    placeholder="Paste your text here... For example:

React Hooks are functions that let you use state and other React features without writing a class. The useState hook is a function that accepts a single argument: the initial state. It returns an array with two elements: the current state value and a function to update it..."
                    value={text}
                    onChange={(e) => setText(e.target.value)}
                    disabled={loading}
                  />
                </div>
              </div>

              <div className="mt-6 flex justify-end gap-3">
                <button
                  onClick={handleClose}
                  className="btn btn-secondary"
                  disabled={loading}
                >
                  Cancel
                </button>
                <button
                  onClick={handleGenerate}
                  className="btn btn-primary"
                  disabled={loading || !text.trim() || !categoryId}
                >
                  {loading ? 'Generating...' : 'Generate Flashcards'}
                </button>
              </div>
            </>
          ) : (
            <>
              <div className="mb-4 flex items-center justify-between">
                <p className="text-gray-600">
                  Generated {generatedFlashcards.length} flashcard{generatedFlashcards.length !== 1 ? 's' : ''}.
                  Select the ones you want to save:
                </p>
                <button
                  onClick={toggleSelectAll}
                  className="text-sm text-blue-600 hover:text-blue-700"
                >
                  {selectedCards.size === generatedFlashcards.length ? 'Deselect All' : 'Select All'}
                </button>
              </div>

              <div className="space-y-4 mb-6">
                {generatedFlashcards.map((card, index) => (
                  <div
                    key={index}
                    className={`border rounded-lg p-4 cursor-pointer transition-all ${
                      selectedCards.has(index)
                        ? 'border-blue-500 bg-blue-50'
                        : 'border-gray-200 hover:border-gray-300'
                    }`}
                    onClick={() => toggleCardSelection(index)}
                  >
                    <div className="flex items-start gap-3">
                      <input
                        type="checkbox"
                        checked={selectedCards.has(index)}
                        onChange={() => toggleCardSelection(index)}
                        className="mt-1"
                      />
                      <div className="flex-1">
                        <div className="flex items-center gap-2 mb-2">
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
                        <h4 className="font-semibold text-gray-900 mb-2">{card.question}</h4>
                        <p className="text-gray-600 text-sm mb-2">{card.answer}</p>
                        {card.explanation && (
                          <p className="text-gray-500 text-sm italic">{card.explanation}</p>
                        )}
                        {card.code_snippet && (
                          <pre className="mt-2 p-2 bg-gray-800 text-white text-xs rounded overflow-x-auto">
                            <code>{card.code_snippet}</code>
                          </pre>
                        )}
                      </div>
                    </div>
                  </div>
                ))}
              </div>

              <div className="flex justify-end gap-3">
                <button
                  onClick={() => {
                    setGeneratedFlashcards(null);
                    setSelectedCards(new Set());
                  }}
                  className="btn btn-secondary"
                  disabled={loading}
                >
                  Back
                </button>
                <button
                  onClick={handleSave}
                  className="btn btn-primary"
                  disabled={loading || selectedCards.size === 0}
                >
                  {loading ? 'Saving...' : `Save ${selectedCards.size} Flashcard${selectedCards.size !== 1 ? 's' : ''}`}
                </button>
              </div>
            </>
          )}

          {loading && (
            <div className="mt-4">
              <LoadingSpinner message={generatedFlashcards ? 'Saving flashcards...' : 'Generating flashcards...'} />
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

export default AIGenerationModal;
