import { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import { categoriesAPI, flashcardsAPI, studyAPI } from '../services/api';
import LoadingSpinner from '../components/LoadingSpinner';
import StatsCard from '../components/StatsCard';

function CategoryDetail() {
  const { slug } = useParams();
  const [category, setCategory] = useState(null);
  const [cards, setCards] = useState([]);
  const [dueCards, setDueCards] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadCategoryData();
  }, [slug]);

  const loadCategoryData = async () => {
    try {
      const categoryRes = await categoriesAPI.getBySlug(slug);
      const categoryData = categoryRes.data;
      setCategory(categoryData);

      const [cardsRes, dueCardsRes] = await Promise.all([
        flashcardsAPI.getByCategory(categoryData.id),
        studyAPI.getDueCards(categoryData.id),
      ]);

      setCards(cardsRes.data);
      setDueCards(dueCardsRes.data);
    } catch (error) {
      console.error('Error loading category data:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return <LoadingSpinner message="Loading category..." />;
  }

  if (!category) {
    return (
      <div className="text-center py-12">
        <p className="text-gray-600 text-lg">Category not found</p>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="card" style={{ borderLeft: `4px solid ${category.color}` }}>
        <div className="flex items-start justify-between">
          <div className="flex items-start gap-4">
            <div
              className="text-5xl p-4 rounded-lg"
              style={{ backgroundColor: `${category.color}20` }}
            >
              {category.icon}
            </div>
            <div>
              <h1 className="text-3xl font-bold text-gray-900 mb-2">
                {category.name}
              </h1>
              {category.description && (
                <p className="text-gray-600">{category.description}</p>
              )}
            </div>
          </div>
        </div>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <StatsCard
          title="Total Cards"
          value={cards.length}
          icon="📚"
          color="primary"
        />
        <StatsCard
          title="Due for Review"
          value={dueCards.length}
          icon="⏰"
          color="yellow"
        />
        <StatsCard
          title="Mastered"
          value={cards.filter((c) => c.repetitions >= 3).length}
          icon="⭐"
          color="green"
        />
      </div>

      {/* Action Buttons */}
      <div className="flex gap-4">
        <Link
          to={`/study/${category.id}`}
          className="btn btn-primary flex-1 text-center"
        >
          Study {dueCards.length > 0 ? `(${dueCards.length} due)` : 'All Cards'}
        </Link>
        <Link
          to={`/flashcards/new?category=${category.id}`}
          className="btn btn-secondary"
        >
          Add Card
        </Link>
      </div>

      {/* Cards List */}
      <div className="card">
        <h2 className="text-2xl font-bold text-gray-900 mb-4">
          Flashcards ({cards.length})
        </h2>

        {cards.length === 0 ? (
          <p className="text-gray-600 text-center py-8">
            No flashcards in this category yet
          </p>
        ) : (
          <div className="space-y-4">
            {cards.map((card) => (
              <div
                key={card.id}
                className="p-4 border border-gray-200 rounded-lg hover:border-primary-300 hover:bg-gray-50 transition-colors"
              >
                <div className="flex items-start justify-between">
                  <div className="flex-1">
                    <p className="font-medium text-gray-900 mb-1">
                      {card.question}
                    </p>
                    <div className="flex items-center gap-2 text-sm text-gray-500">
                      <span
                        className={`px-2 py-1 rounded text-xs ${
                          card.difficulty === 'easy'
                            ? 'bg-green-100 text-green-800'
                            : card.difficulty === 'medium'
                            ? 'bg-yellow-100 text-yellow-800'
                            : 'bg-red-100 text-red-800'
                        }`}
                      >
                        {card.difficulty}
                      </span>
                      {card.repetitions > 0 && (
                        <span>Reviewed {card.repetitions} times</span>
                      )}
                    </div>
                  </div>
                  <Link
                    to={`/flashcards/${card.id}/edit`}
                    className="text-primary-600 hover:text-primary-700 text-sm font-medium"
                  >
                    Edit
                  </Link>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}

export default CategoryDetail;
