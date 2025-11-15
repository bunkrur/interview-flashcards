import { useState, useEffect } from 'react';
import { categoriesAPI, aiAPI } from '../services/api';
import LoadingSpinner from './LoadingSpinner';

// Common emoji suggestions for categories
const COMMON_EMOJIS = [
  '📚', '💻', '🎓', '🚀', '🔧', '🌐', '🗄️', '🔒',
  '⚡', '🎯', '📊', '🐍', '☕', '🐳', '☸️', '🔥',
  '💡', '🛠️', '📱', '🎨', '🏗️', '🧠', '💾', '🌟',
  '🔑', '📈', '🎮', '🖥️', '⚙️', '🌈', '📦', '🎪'
];

const PRESET_COLORS = [
  '#3B82F6', // Blue
  '#EF4444', // Red
  '#10B981', // Green
  '#F59E0B', // Amber
  '#8B5CF6', // Purple
  '#EC4899', // Pink
  '#06B6D4', // Cyan
  '#F97316', // Orange
  '#14B8A6', // Teal
  '#6366F1', // Indigo
];

function CategoryFormModal({ isOpen, onClose, onSuccess }) {
  const [formData, setFormData] = useState({
    name: '',
    slug: '',
    description: '',
    icon: '',
    color: '#3B82F6',
  });
  const [loading, setLoading] = useState(false);
  const [suggestingEmoji, setSuggestingEmoji] = useState(false);
  const [error, setError] = useState('');
  const [showEmojiPicker, setShowEmojiPicker] = useState(false);

  // Auto-generate slug from name
  useEffect(() => {
    if (formData.name) {
      const slug = formData.name
        .toLowerCase()
        .replace(/[^a-z0-9]+/g, '-')
        .replace(/^-|-$/g, '');
      setFormData(prev => ({ ...prev, slug }));
    }
  }, [formData.name]);

  const handleSuggestEmoji = async () => {
    if (!formData.name) {
      setError('Please enter a category name first');
      return;
    }

    setSuggestingEmoji(true);
    setError('');

    try {
      const response = await aiAPI.suggestEmoji({ categoryName: formData.name });
      setFormData(prev => ({ ...prev, icon: response.data.emoji }));
    } catch (err) {
      console.error('Error suggesting emoji:', err);
      setError(err.response?.data?.message || 'Failed to suggest emoji');
    } finally {
      setSuggestingEmoji(false);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');

    // Validation
    if (!formData.name.trim()) {
      setError('Category name is required');
      return;
    }

    if (!formData.icon) {
      setError('Please select an emoji');
      return;
    }

    setLoading(true);

    try {
      await categoriesAPI.create(formData);
      onSuccess();
      handleClose();
    } catch (err) {
      console.error('Error creating category:', err);
      setError(err.response?.data?.error || 'Failed to create category');
    } finally {
      setLoading(false);
    }
  };

  const handleClose = () => {
    setFormData({
      name: '',
      slug: '',
      description: '',
      icon: '',
      color: '#3B82F6',
    });
    setError('');
    setShowEmojiPicker(false);
    onClose();
  };

  const handleEmojiSelect = (emoji) => {
    setFormData(prev => ({ ...prev, icon: emoji }));
    setShowEmojiPicker(false);
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-lg max-w-2xl w-full max-h-[90vh] overflow-y-auto">
        <div className="sticky top-0 bg-white border-b border-gray-200 p-6">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-2xl font-bold text-gray-900">Create New Category</h2>
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

        <form onSubmit={handleSubmit} className="p-6 space-y-6">
          {/* Category Name */}
          <div>
            <label className="label">Category Name *</label>
            <input
              type="text"
              className="input"
              placeholder="e.g., React, Python, DevOps"
              value={formData.name}
              onChange={(e) => setFormData({ ...formData, name: e.target.value })}
              disabled={loading}
              required
            />
          </div>

          {/* Slug (auto-generated) */}
          <div>
            <label className="label">
              Slug (auto-generated)
              <span className="text-sm text-gray-500 ml-2">Used in URLs</span>
            </label>
            <input
              type="text"
              className="input bg-gray-50"
              value={formData.slug}
              onChange={(e) => setFormData({ ...formData, slug: e.target.value })}
              disabled={loading}
              required
            />
          </div>

          {/* Emoji Selection */}
          <div>
            <label className="label">
              Category Icon (Emoji) *
            </label>
            <div className="flex gap-3">
              <div className="flex-1">
                <div className="flex gap-2">
                  <button
                    type="button"
                    onClick={() => setShowEmojiPicker(!showEmojiPicker)}
                    className="flex-1 input flex items-center justify-between"
                  >
                    <span className={formData.icon ? 'text-2xl' : 'text-gray-400'}>
                      {formData.icon || 'Select emoji'}
                    </span>
                    <svg className="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                    </svg>
                  </button>
                  <button
                    type="button"
                    onClick={handleSuggestEmoji}
                    disabled={suggestingEmoji || !formData.name}
                    className="btn btn-secondary whitespace-nowrap"
                  >
                    {suggestingEmoji ? (
                      <>
                        <svg className="animate-spin h-4 w-4 mr-2" fill="none" viewBox="0 0 24 24">
                          <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                          <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                        </svg>
                        Suggesting...
                      </>
                    ) : (
                      <>
                        <svg className="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 10V3L4 14h7v7l9-11h-7z" />
                        </svg>
                        AI Suggest
                      </>
                    )}
                  </button>
                </div>

                {showEmojiPicker && (
                  <div className="mt-2 p-4 border border-gray-200 rounded-lg bg-white shadow-lg max-h-48 overflow-y-auto">
                    <div className="grid grid-cols-8 gap-2">
                      {COMMON_EMOJIS.map((emoji, index) => (
                        <button
                          key={index}
                          type="button"
                          onClick={() => handleEmojiSelect(emoji)}
                          className="text-2xl hover:bg-gray-100 rounded p-2 transition-colors"
                        >
                          {emoji}
                        </button>
                      ))}
                    </div>
                  </div>
                )}
              </div>
            </div>
          </div>

          {/* Color Selection */}
          <div>
            <label className="label">
              Category Color
            </label>
            <div className="flex gap-2 flex-wrap">
              {PRESET_COLORS.map((color) => (
                <button
                  key={color}
                  type="button"
                  onClick={() => setFormData({ ...formData, color })}
                  className={`w-10 h-10 rounded-lg border-2 transition-all ${
                    formData.color === color
                      ? 'border-gray-900 scale-110'
                      : 'border-gray-200 hover:border-gray-400'
                  }`}
                  style={{ backgroundColor: color }}
                  title={color}
                />
              ))}
              <input
                type="color"
                value={formData.color}
                onChange={(e) => setFormData({ ...formData, color: e.target.value })}
                className="w-10 h-10 rounded-lg border-2 border-gray-200 cursor-pointer"
                title="Custom color"
              />
            </div>
            <div className="mt-2 text-sm text-gray-500">
              Selected: <span className="font-mono">{formData.color}</span>
            </div>
          </div>

          {/* Description */}
          <div>
            <label className="label">
              Description
              <span className="text-sm text-gray-500 ml-2">(optional)</span>
            </label>
            <textarea
              className="input min-h-[100px]"
              placeholder="Brief description of this category..."
              value={formData.description}
              onChange={(e) => setFormData({ ...formData, description: e.target.value })}
              disabled={loading}
            />
          </div>

          {/* Preview */}
          {formData.name && formData.icon && (
            <div>
              <label className="label">Preview</label>
              <div
                className="p-4 rounded-lg border-2"
                style={{
                  backgroundColor: `${formData.color}20`,
                  borderColor: formData.color,
                }}
              >
                <div className="flex items-center gap-3">
                  <span className="text-3xl">{formData.icon}</span>
                  <div>
                    <h3 className="font-semibold text-gray-900">{formData.name}</h3>
                    {formData.description && (
                      <p className="text-sm text-gray-600">{formData.description}</p>
                    )}
                  </div>
                </div>
              </div>
            </div>
          )}

          <div className="flex justify-end gap-3 pt-4 border-t">
            <button
              type="button"
              onClick={handleClose}
              className="btn btn-secondary"
              disabled={loading}
            >
              Cancel
            </button>
            <button
              type="submit"
              className="btn btn-primary"
              disabled={loading || !formData.name || !formData.icon}
            >
              {loading ? 'Creating...' : 'Create Category'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default CategoryFormModal;
