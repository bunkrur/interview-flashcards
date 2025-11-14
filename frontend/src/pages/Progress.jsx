import { useEffect, useState } from 'react';
import { progressAPI, flashcardsAPI } from '../services/api';
import LoadingSpinner from '../components/LoadingSpinner';
import StatsCard from '../components/StatsCard';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import { format, parseISO } from 'date-fns';

function Progress() {
  const [stats, setStats] = useState(null);
  const [activity, setActivity] = useState([]);
  const [history, setHistory] = useState([]);
  const [loading, setLoading] = useState(true);
  const [activityDays, setActivityDays] = useState(30);
  const [resetting, setResetting] = useState(false);
  const [showConfirm, setShowConfirm] = useState(false);

  useEffect(() => {
    loadProgressData();
  }, [activityDays]);

  const loadProgressData = async () => {
    try {
      const [statsRes, activityRes, historyRes] = await Promise.all([
        progressAPI.getOverallStats(),
        progressAPI.getDailyActivity(activityDays),
        progressAPI.getHistory({ limit: 50 }),
      ]);

      setStats(statsRes.data);
      setActivity(activityRes.data);
      setHistory(historyRes.data);
    } catch (error) {
      console.error('Error loading progress data:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleResetProgress = async () => {
    setResetting(true);
    try {
      await progressAPI.resetProgress();
      // Reload the data after reset
      await loadProgressData();
      setShowConfirm(false);
      alert('Progress has been reset successfully!');
    } catch (error) {
      console.error('Error resetting progress:', error);
      alert('Failed to reset progress. Please try again.');
    } finally {
      setResetting(false);
    }
  };

  const handleExport = async () => {
    try {
      await flashcardsAPI.exportToSQL();
    } catch (error) {
      console.error('Error exporting flashcards:', error);
      alert('Failed to export flashcards. Please try again.');
    }
  };

  if (loading) {
    return <LoadingSpinner message="Loading progress data..." />;
  }

  const successRate = stats?.study_stats?.total_reviews > 0
    ? Math.round((stats.study_stats.successful_reviews / stats.study_stats.total_reviews) * 100)
    : 0;

  return (
    <div className="space-y-8">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900 mb-2">Progress</h1>
          <p className="text-gray-600">Track your learning journey</p>
        </div>
        <div className="flex gap-3">
          <button
            onClick={handleExport}
            className="btn bg-blue-600 hover:bg-blue-700 text-white"
          >
            Export to SQL
          </button>
          <button
            onClick={() => setShowConfirm(true)}
            className="btn bg-red-600 hover:bg-red-700 text-white"
            disabled={resetting}
          >
            Reset Progress
          </button>
        </div>
      </div>

      {/* Confirmation Modal */}
      {showConfirm && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
          <div className="bg-white rounded-lg p-6 max-w-md w-full mx-4">
            <h2 className="text-2xl font-bold text-gray-900 mb-4">
              Confirm Reset
            </h2>
            <p className="text-gray-700 mb-6">
              Are you sure you want to reset all your progress? This will:
            </p>
            <ul className="list-disc list-inside text-gray-700 mb-6 space-y-2">
              <li>Reset all card review data to initial state</li>
              <li>Delete all study session history</li>
              <li>Reset your streak and statistics</li>
              <li>Make all cards available for review again</li>
            </ul>
            <p className="text-red-600 font-semibold mb-6">
              This action cannot be undone!
            </p>
            <div className="flex gap-3">
              <button
                onClick={() => setShowConfirm(false)}
                className="btn btn-secondary flex-1"
                disabled={resetting}
              >
                Cancel
              </button>
              <button
                onClick={handleResetProgress}
                className="btn bg-red-600 hover:bg-red-700 text-white flex-1"
                disabled={resetting}
              >
                {resetting ? 'Resetting...' : 'Yes, Reset All'}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Overview Stats */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <StatsCard
          title="Total Reviews"
          value={stats?.study_stats?.total_reviews || 0}
          subtitle={`${successRate}% success rate`}
          icon="📊"
          color="primary"
        />
        <StatsCard
          title="Current Streak"
          value={`${stats?.streak?.current_streak || 0} days`}
          subtitle={`Longest: ${stats?.streak?.longest_streak || 0} days`}
          icon="🔥"
          color="yellow"
        />
        <StatsCard
          title="Study Days"
          value={stats?.streak?.total_days || 0}
          icon="📅"
          color="green"
        />
        <StatsCard
          title="Avg. Response Time"
          value={stats?.study_stats?.avg_response_time ? `${stats.study_stats.avg_response_time}s` : 'N/A'}
          icon="⏱️"
          color="purple"
        />
      </div>

      {/* Mastery Levels */}
      {stats?.mastery_levels && stats.mastery_levels.length > 0 && (
        <div className="card">
          <h2 className="text-2xl font-bold text-gray-900 mb-6">
            Mastery Distribution
          </h2>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
            {stats.mastery_levels.map((level) => {
              const percentage = (level.count / stats.total_cards) * 100;
              const colors = {
                new: { bg: 'bg-gray-100', text: 'text-gray-800', bar: 'bg-gray-400' },
                learning: { bg: 'bg-blue-100', text: 'text-blue-800', bar: 'bg-blue-500' },
                familiar: { bg: 'bg-yellow-100', text: 'text-yellow-800', bar: 'bg-yellow-500' },
                mastered: { bg: 'bg-green-100', text: 'text-green-800', bar: 'bg-green-500' },
              };
              const color = colors[level.level] || colors.new;

              return (
                <div key={level.level} className="text-center">
                  <div className={`${color.bg} ${color.text} rounded-lg p-4 mb-2`}>
                    <div className="text-3xl font-bold">{level.count}</div>
                    <div className="text-sm capitalize mt-1">{level.level}</div>
                  </div>
                  <div className="w-full bg-gray-200 rounded-full h-2">
                    <div
                      className={`${color.bar} h-2 rounded-full`}
                      style={{ width: `${percentage}%` }}
                    ></div>
                  </div>
                  <div className="text-xs text-gray-600 mt-1">
                    {percentage.toFixed(1)}%
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      )}

      {/* Activity Chart */}
      {activity.length > 0 && (
        <div className="card">
          <div className="flex items-center justify-between mb-6">
            <h2 className="text-2xl font-bold text-gray-900">Daily Activity</h2>
            <select
              className="input w-auto"
              value={activityDays}
              onChange={(e) => setActivityDays(parseInt(e.target.value))}
            >
              <option value={7}>Last 7 days</option>
              <option value={14}>Last 14 days</option>
              <option value={30}>Last 30 days</option>
              <option value={90}>Last 90 days</option>
            </select>
          </div>
          <ResponsiveContainer width="100%" height={300}>
            <BarChart data={activity}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis
                dataKey="date"
                tickFormatter={(date) => format(parseISO(date), 'MM/dd')}
              />
              <YAxis />
              <Tooltip
                labelFormatter={(date) => format(parseISO(date), 'MMM dd, yyyy')}
              />
              <Legend />
              <Bar dataKey="review_count" fill="#3b82f6" name="Total Reviews" />
              <Bar
                dataKey="successful_reviews"
                fill="#10b981"
                name="Successful"
              />
            </BarChart>
          </ResponsiveContainer>
        </div>
      )}

      {/* Recent Activity */}
      {history.length > 0 && (
        <div className="card">
          <h2 className="text-2xl font-bold text-gray-900 mb-4">
            Recent Reviews
          </h2>
          <div className="space-y-3">
            {history.slice(0, 10).map((session) => (
              <div
                key={session.id}
                className="flex items-start justify-between p-3 bg-gray-50 rounded-lg"
              >
                <div className="flex-1">
                  <p className="font-medium text-gray-900 line-clamp-1">
                    {session.question}
                  </p>
                  <div className="flex items-center gap-2 mt-1 text-sm text-gray-600">
                    <span
                      className="px-2 py-0.5 rounded text-xs"
                      style={{
                        backgroundColor: `${session.category_color}20`,
                        color: session.category_color,
                      }}
                    >
                      {session.category_name}
                    </span>
                    <span
                      className={`px-2 py-0.5 rounded text-xs ${
                        session.difficulty === 'easy'
                          ? 'bg-green-100 text-green-800'
                          : session.difficulty === 'medium'
                          ? 'bg-yellow-100 text-yellow-800'
                          : 'bg-red-100 text-red-800'
                      }`}
                    >
                      {session.difficulty}
                    </span>
                    <span>{format(parseISO(session.reviewed_at), 'MMM dd, h:mm a')}</span>
                  </div>
                </div>
                <div className="flex items-center gap-2">
                  <span
                    className={`px-3 py-1 rounded-full text-sm font-medium ${
                      session.quality_rating >= 4
                        ? 'bg-green-100 text-green-800'
                        : session.quality_rating >= 3
                        ? 'bg-blue-100 text-blue-800'
                        : 'bg-red-100 text-red-800'
                    }`}
                  >
                    {session.quality_rating}/5
                  </span>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {history.length === 0 && (
        <div className="card text-center py-12">
          <p className="text-gray-600 text-lg mb-4">
            No study history yet
          </p>
          <a href="/study" className="btn btn-primary">
            Start Studying
          </a>
        </div>
      )}
    </div>
  );
}

export default Progress;
