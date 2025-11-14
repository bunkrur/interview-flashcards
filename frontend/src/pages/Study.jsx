import { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { studyAPI, aiAPI } from '../services/api';
import FlashCard from '../components/FlashCard';
import LoadingSpinner from '../components/LoadingSpinner';

function Study() {
  const { categoryId } = useParams();
  const [dueCards, setDueCards] = useState([]);
  const [currentCardIndex, setCurrentCardIndex] = useState(0);
  const [isFlipped, setIsFlipped] = useState(false);
  const [loading, setLoading] = useState(true);
  const [startTime, setStartTime] = useState(null);
  const [sessionComplete, setSessionComplete] = useState(false);
  const [aiExplanation, setAiExplanation] = useState(null);
  const [loadingAI, setLoadingAI] = useState(false);
  const [aiError, setAiError] = useState(null);

  useEffect(() => {
    loadDueCards();
  }, [categoryId]);

  // Add keyboard support for rating (0-5 keys)
  useEffect(() => {
    const handleKeyPress = (event) => {
      if (isFlipped && event.key >= '0' && event.key <= '5') {
        const rating = parseInt(event.key);
        handleRating(rating);
      }
    };

    window.addEventListener('keydown', handleKeyPress);
    return () => window.removeEventListener('keydown', handleKeyPress);
  }, [isFlipped, currentCardIndex, startTime]);

  const loadDueCards = async () => {
    try {
      const catId = categoryId ? parseInt(categoryId) : null;
      const response = await studyAPI.getDueCards(catId);
      setDueCards(response.data);
      setStartTime(Date.now());

      if (response.data.length === 0) {
        setSessionComplete(true);
      }
    } catch (error) {
      console.error('Error loading due cards:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleRating = async (rating) => {
    if (!dueCards[currentCardIndex] || !startTime) return;

    const card = dueCards[currentCardIndex];
    const responseTime = Math.floor((Date.now() - startTime) / 1000);

    try {
      await studyAPI.submitReview({
        card_id: card.id,
        category_id: card.category_id,
        quality_rating: rating,
        response_time_seconds: responseTime,
      });

      // Move to next card
      if (currentCardIndex < dueCards.length - 1) {
        setCurrentCardIndex(currentCardIndex + 1);
        setIsFlipped(false);
        setStartTime(Date.now());
        setAiExplanation(null);
        setAiError(null);
      } else {
        setSessionComplete(true);
      }
    } catch (error) {
      console.error('Error submitting review:', error);
    }
  };

  const handleAskAI = async () => {
    if (!dueCards[currentCardIndex]) return;

    const card = dueCards[currentCardIndex];
    setLoadingAI(true);
    setAiError(null);

    try {
      const response = await aiAPI.explainAnswer({
        question: card.question,
        answer: card.answer,
        category: card.category_name,
        explanation: card.explanation,
      });

      setAiExplanation(response.data.explanation);
    } catch (error) {
      console.error('Error getting AI explanation:', error);
      if (error.response?.data?.message) {
        setAiError(error.response.data.message);
      } else {
        setAiError('Failed to get AI explanation. Please try again.');
      }
    } finally {
      setLoadingAI(false);
    }
  };

  const ratingButtons = [
    { rating: 0, label: 'Forgot', description: 'Complete blackout', color: 'bg-red-600 hover:bg-red-700' },
    { rating: 1, label: 'Hard', description: 'Incorrect response', color: 'bg-orange-600 hover:bg-orange-700' },
    { rating: 2, label: 'Okay', description: 'Recalled with effort', color: 'bg-yellow-600 hover:bg-yellow-700' },
    { rating: 3, label: 'Good', description: 'Correct, some difficulty', color: 'bg-blue-600 hover:bg-blue-700' },
    { rating: 4, label: 'Easy', description: 'Correct, slight hesitation', color: 'bg-green-600 hover:bg-green-700' },
    { rating: 5, label: 'Perfect', description: 'Perfect response', color: 'bg-emerald-600 hover:bg-emerald-700' },
  ];

  if (loading) {
    return <LoadingSpinner message="Loading cards..." />;
  }

  if (sessionComplete || dueCards.length === 0) {
    return (
      <div className="max-w-2xl mx-auto text-center space-y-6">
        <div className="card">
          <div className="text-6xl mb-4">🎉</div>
          <h1 className="text-3xl font-bold text-gray-900 mb-4">
            {dueCards.length === 0 ? 'No Cards Due!' : 'Session Complete!'}
          </h1>
          <p className="text-lg text-gray-600 mb-6">
            {dueCards.length === 0
              ? 'You\'re all caught up! Come back later for more reviews.'
              : 'Great job! You\'ve reviewed all due cards.'}
          </p>
          <div className="flex gap-4 justify-center">
            <a href="/" className="btn btn-primary">
              Back to Home
            </a>
            <a href="/categories" className="btn btn-secondary">
              Browse Categories
            </a>
          </div>
        </div>
      </div>
    );
  }

  const currentCard = dueCards[currentCardIndex];
  const progress = ((currentCardIndex + 1) / dueCards.length) * 100;

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      {/* Progress Bar */}
      <div className="card">
        <div className="flex items-center justify-between mb-2">
          <span className="text-sm font-medium text-gray-700">
            Card {currentCardIndex + 1} of {dueCards.length}
          </span>
          <span className="text-sm text-gray-600">
            {Math.round(progress)}% Complete
          </span>
        </div>
        <div className="w-full bg-gray-200 rounded-full h-2">
          <div
            className="bg-primary-600 h-2 rounded-full transition-all duration-300"
            style={{ width: `${progress}%` }}
          ></div>
        </div>
      </div>

      {/* Flashcard */}
      <FlashCard
        card={currentCard}
        isFlipped={isFlipped}
        onFlip={setIsFlipped}
      />

      {/* Rating Buttons */}
      {isFlipped && (
        <>
          <div className="card">
            <h3 className="text-lg font-semibold text-gray-900 mb-4 text-center">
              How well did you know this?
            </h3>
            <div className="grid grid-cols-2 md:grid-cols-3 gap-3">
              {ratingButtons.map((btn) => (
                <button
                  key={btn.rating}
                  onClick={() => handleRating(btn.rating)}
                  className={`${btn.color} text-white px-4 py-3 rounded-lg font-medium transition-all hover:shadow-lg focus:outline-none focus:ring-2 focus:ring-offset-2`}
                >
                  <div className="font-bold">{btn.label}</div>
                  <div className="text-xs opacity-90">{btn.description}</div>
                </button>
              ))}
            </div>

            <div className="mt-4 text-center text-sm text-gray-600">
              <p>Keyboard shortcuts: Press 0-5 to rate</p>
            </div>
          </div>

          {/* Ask AI Section */}
          <div className="card">
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-lg font-semibold text-gray-900">
                Need more context?
              </h3>
              <button
                onClick={handleAskAI}
                disabled={loadingAI}
                className="btn btn-primary flex items-center gap-2"
              >
                {loadingAI ? (
                  <>
                    <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
                    <span>Getting explanation...</span>
                  </>
                ) : (
                  <>
                    <span>🤖</span>
                    <span>Ask AI</span>
                  </>
                )}
              </button>
            </div>

            {aiError && (
              <div className="bg-red-50 border border-red-200 rounded-lg p-4">
                <p className="text-red-800 text-sm">{aiError}</p>
              </div>
            )}

            {aiExplanation && (
              <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
                <div className="flex items-start gap-3">
                  <span className="text-2xl">🤖</span>
                  <div className="flex-1">
                    <h4 className="font-semibold text-blue-900 mb-2">AI Explanation</h4>
                    <div className="text-blue-900 text-sm whitespace-pre-wrap">
                      {aiExplanation}
                    </div>
                  </div>
                </div>
              </div>
            )}

            {!aiExplanation && !aiError && !loadingAI && (
              <p className="text-gray-600 text-sm">
                Click "Ask AI" to get additional context, examples, and deeper explanations about this answer.
              </p>
            )}
          </div>
        </>
      )}

      {!isFlipped && (
        <div className="text-center">
          <p className="text-gray-600">
            Click the card or press Space to reveal the answer
          </p>
        </div>
      )}
    </div>
  );
}

export default Study;
