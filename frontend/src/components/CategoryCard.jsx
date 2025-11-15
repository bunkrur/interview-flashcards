import { Link, useNavigate } from 'react-router-dom';
import { useState } from 'react';
import { categoriesAPI } from '../services/api';

function CategoryCard({ category, onDelete }) {
  const { id, name, slug, description, color, icon, card_count } = category;
  const [showConfirm, setShowConfirm] = useState(false);
  const [deleting, setDeleting] = useState(false);
  const navigate = useNavigate();

  const handleDelete = async (e) => {
    e.preventDefault();
    e.stopPropagation();

    setDeleting(true);
    try {
      await categoriesAPI.delete(id);
      if (onDelete) {
        onDelete(id);
      }
    } catch (error) {
      console.error('Error deleting category:', error);
      alert('Failed to delete category. Please try again.');
    } finally {
      setDeleting(false);
      setShowConfirm(false);
    }
  };

  const handleDeleteClick = (e) => {
    e.preventDefault();
    e.stopPropagation();
    setShowConfirm(true);
  };

  const handleCancelDelete = (e) => {
    e.preventDefault();
    e.stopPropagation();
    setShowConfirm(false);
  };

  return (
    <div className="card hover:shadow-lg transition-shadow duration-200 group relative">
      {showConfirm && (
        <div className="absolute inset-0 bg-white bg-opacity-95 z-10 rounded-lg flex flex-col items-center justify-center p-6">
          <div className="text-center mb-4">
            <div className="text-4xl mb-3">⚠️</div>
            <h4 className="font-semibold text-gray-900 mb-2">Delete "{name}"?</h4>
            <p className="text-sm text-gray-600 mb-1">
              This will permanently delete this category and all {card_count} flashcard{card_count !== 1 ? 's' : ''}.
            </p>
            <p className="text-sm text-red-600 font-medium">This action cannot be undone.</p>
          </div>
          <div className="flex gap-3">
            <button
              onClick={handleCancelDelete}
              className="btn btn-secondary"
              disabled={deleting}
            >
              Cancel
            </button>
            <button
              onClick={handleDelete}
              className="btn btn-danger"
              disabled={deleting}
            >
              {deleting ? 'Deleting...' : 'Delete Category'}
            </button>
          </div>
        </div>
      )}

      <Link to={`/category/${slug}`} className="block">
        <div className="flex items-start justify-between mb-4">
          <div
            className="text-4xl p-3 rounded-lg"
            style={{ backgroundColor: `${color}20` }}
          >
            {icon}
          </div>
          <div className="flex items-center gap-2">
            <span className="text-sm text-gray-500 bg-gray-100 px-2 py-1 rounded">
              {card_count} {card_count === 1 ? 'card' : 'cards'}
            </span>
            <button
              onClick={handleDeleteClick}
              className="opacity-0 group-hover:opacity-100 transition-opacity p-2 hover:bg-red-50 rounded text-red-600 hover:text-red-700"
              title="Delete category"
            >
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
              </svg>
            </button>
          </div>
        </div>

        <h3 className="text-xl font-semibold text-gray-900 mb-2 group-hover:text-primary-600 transition-colors">
          {name}
        </h3>

        {description && (
          <p className="text-gray-600 text-sm line-clamp-2">{description}</p>
        )}
      </Link>
    </div>
  );
}

export default CategoryCard;
