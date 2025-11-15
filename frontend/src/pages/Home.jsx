import { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { progressAPI, studyAPI } from '../services/api';
import LoadingSpinner from '../components/LoadingSpinner';
import StatsCard from '../components/StatsCard';

function Home() {
  const [stats, setStats] = useState(null);
  const [dueCardsCount, setDueCardsCount] = useState(0);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadStats();
  }, []);

  const loadStats = async () => {
    try {
      const [statsRes, dueCardsRes] = await Promise.all([
        progressAPI.getOverallStats(),
        studyAPI.getDueCards(),
      ]);

      setStats(statsRes.data);
      setDueCardsCount(dueCardsRes.data.length);
    } catch (error) {
      console.error('Error loading stats:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return <LoadingSpinner message="Loading your stats..." />;
  }

  return (
    <div className="space-y-8">
      <div className="text-center">
        <h1 className="text-4xl font-bold text-gray-900 mb-4">
          Welcome to Flashcards
        </h1>
        <p className="text-lg text-gray-600">
          Master tech knowledge with spaced repetition
        </p>
      </div>

      {/* Stats Overview */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <StatsCard
          title="Cards Due Today"
          value={dueCardsCount}
          icon="📚"
          color="primary"
        />
        <StatsCard
          title="Total Reviews"
          value={stats?.study_stats?.total_reviews || 0}
          icon="✅"
          color="green"
        />
        <StatsCard
          title="Current Streak"
          value={`${stats?.streak?.current_streak || 0} days`}
          subtitle={`Longest: ${stats?.streak?.longest_streak || 0} days`}
          icon="🔥"
          color="yellow"
        />
        <StatsCard
          title="Total Cards"
          value={stats?.total_cards || 0}
          icon="📇"
          color="purple"
        />
      </div>

      {/* Mastery Levels */}
      {stats?.mastery_levels && stats.mastery_levels.length > 0 && (
        <div className="card">
          <h2 className="text-2xl font-bold text-gray-900 mb-4">
            Mastery Progress
          </h2>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            {stats.mastery_levels.map((level) => (
              <div key={level.level} className="text-center">
                <div className="text-3xl font-bold text-gray-900">
                  {level.count}
                </div>
                <div className="text-sm text-gray-600 capitalize mt-1">
                  {level.level}
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Quick Actions */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <Link
          to="/study"
          className="card hover:shadow-lg transition-shadow text-center group"
        >
          <div className="text-5xl mb-4">📖</div>
          <h3 className="text-xl font-semibold text-gray-900 mb-2 group-hover:text-primary-600">
            Start Studying
          </h3>
          <p className="text-gray-600">
            Review {dueCardsCount} cards due today
          </p>
        </Link>

        <Link
          to="/categories"
          className="card hover:shadow-lg transition-shadow text-center group"
        >
          <div className="text-5xl mb-4">📁</div>
          <h3 className="text-xl font-semibold text-gray-900 mb-2 group-hover:text-primary-600">
            Browse Categories
          </h3>
          <p className="text-gray-600">
            Explore topics and study by category
          </p>
        </Link>

        <Link
          to="/flashcards/new"
          className="card hover:shadow-lg transition-shadow text-center group"
        >
          <div className="text-5xl mb-4">➕</div>
          <h3 className="text-xl font-semibold text-gray-900 mb-2 group-hover:text-primary-600">
            Create Flashcard
          </h3>
          <p className="text-gray-600">Add new cards to your collection</p>
        </Link>
      </div>
    </div>
  );
}

export default Home;
