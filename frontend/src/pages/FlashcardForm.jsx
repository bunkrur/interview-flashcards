import { useEffect, useState } from 'react';
import { useParams, useNavigate, useSearchParams } from 'react-router-dom';
import { flashcardsAPI, categoriesAPI, aiAPI } from '../services/api';
import LoadingSpinner from '../components/LoadingSpinner';
import ReactMarkdown from 'react-markdown';
import remarkBreaks from 'remark-breaks';
import remarkGfm from 'remark-gfm';
import { Prism as SyntaxHighlighter } from 'react-syntax-highlighter';
import { vscDarkPlus } from 'react-syntax-highlighter/dist/esm/styles/prism';

function FlashcardForm() {
  const { id } = useParams();
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const isEditing = Boolean(id);

  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [enhancing, setEnhancing] = useState(false);
  const [showEnhancementPreview, setShowEnhancementPreview] = useState(false);
  const [enhancement, setEnhancement] = useState(null);
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

  const detectLanguage = (code) => {
    if (!code) return 'javascript';

    const codeStr = code.toLowerCase();

    // Python
    if (codeStr.includes('def ') || codeStr.includes('import ') || codeStr.includes('print(') ||
        codeStr.includes('self.') || /^\s*#/.test(code)) {
      return 'python';
    }

    // SQL
    if (codeStr.includes('select ') || codeStr.includes('insert into') ||
        codeStr.includes('create table') || codeStr.includes('update ') ||
        codeStr.includes('delete from')) {
      return 'sql';
    }

    // Bash/Shell
    if (codeStr.includes('#!/bin/') || codeStr.includes('echo ') ||
        /^\s*\$\s/.test(code) || codeStr.includes('export ')) {
      return 'bash';
    }

    // Go
    if (codeStr.includes('func ') || codeStr.includes('package ') ||
        codeStr.includes('import (') || codeStr.includes(':=')) {
      return 'go';
    }

    // TypeScript
    if (codeStr.includes('interface ') || codeStr.includes(': string') ||
        codeStr.includes(': number') || codeStr.includes('type ')) {
      return 'typescript';
    }

    // Java
    if (codeStr.includes('public class') || codeStr.includes('public static void') ||
        codeStr.includes('private ') || codeStr.includes('System.out.')) {
      return 'java';
    }

    // CSS
    if (/{[\s\S]*?}/.test(code) && (codeStr.includes('color:') ||
        codeStr.includes('margin:') || codeStr.includes('padding:'))) {
      return 'css';
    }

    // HTML
    if (codeStr.includes('<!doctype') || codeStr.includes('<html') ||
        /<[a-z]+[\s>]/.test(codeStr)) {
      return 'html';
    }

    // Default to JavaScript
    return 'javascript';
  };

  const handleEnhance = async () => {
    if (!formData.question || !formData.answer) {
      alert('Please fill in the question and answer before enhancing');
      return;
    }

    setEnhancing(true);

    try {
      const response = await aiAPI.enhanceFlashcard({
        question: formData.question,
        answer: formData.answer,
        explanation: formData.explanation,
        code_snippet: formData.code_snippet,
        difficulty: formData.difficulty,
      });

      setEnhancement(response.data.enhancement);
      setShowEnhancementPreview(true);
    } catch (error) {
      console.error('Error enhancing flashcard:', error);
      alert(error.response?.data?.message || 'Failed to enhance flashcard. Please try again.');
    } finally {
      setEnhancing(false);
    }
  };

  const handleApplyEnhancement = () => {
    if (enhancement) {
      setFormData({
        ...formData,
        answer: enhancement.answer,
        explanation: enhancement.explanation || formData.explanation,
        code_snippet: enhancement.code_snippet || formData.code_snippet,
        difficulty: enhancement.difficulty || formData.difficulty,
      });
      setShowEnhancementPreview(false);
      setEnhancement(null);
    }
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
      <div className="mb-6 flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900 mb-2">
            {isEditing ? 'Edit Flashcard' : 'Create New Flashcard'}
          </h1>
          <p className="text-gray-600">
            {isEditing
              ? 'Update the flashcard details below'
              : 'Fill in the details to create a new flashcard'}
          </p>
        </div>
        <button
          type="button"
          onClick={handleEnhance}
          disabled={enhancing || !formData.question || !formData.answer}
          className="btn btn-secondary flex items-center gap-2"
        >
          {enhancing ? (
            <>
              <svg className="animate-spin h-5 w-5" fill="none" viewBox="0 0 24 24">
                <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
              Enhancing...
            </>
          ) : (
            <>
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 10V3L4 14h7v7l9-11h-7z" />
              </svg>
              Enhance with AI
            </>
          )}
        </button>
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

      {/* Enhancement Preview Modal */}
      {showEnhancementPreview && enhancement && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-lg max-w-4xl w-full max-h-[90vh] overflow-y-auto">
            <div className="sticky top-0 bg-white border-b border-gray-200 p-6">
              <div className="flex items-center justify-between mb-4">
                <h2 className="text-2xl font-bold text-gray-900">AI Enhanced Flashcard</h2>
                <button
                  onClick={() => setShowEnhancementPreview(false)}
                  className="text-gray-400 hover:text-gray-600"
                >
                  <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </button>
              </div>
              {enhancement.enhancements && (
                <div className="p-3 bg-blue-50 border border-blue-200 rounded-lg">
                  <p className="text-sm text-blue-800">
                    <strong>✨ Improvements:</strong> {enhancement.enhancements}
                  </p>
                </div>
              )}
            </div>

            <div className="p-6 space-y-6">
              {/* Original vs Enhanced Comparison */}
              <div>
                <h3 className="text-lg font-semibold mb-3 text-gray-900">Answer</h3>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <div className="text-sm font-medium text-gray-500 mb-2">Current</div>
                    <div className="p-4 bg-gray-50 border border-gray-200 rounded-lg min-h-[100px]">
                      <div className="text-gray-700 prose prose-sm max-w-none prose-strong:text-gray-700 prose-strong:font-semibold">
                        <ReactMarkdown remarkPlugins={[remarkBreaks, remarkGfm]}>{formData.answer}</ReactMarkdown>
                      </div>
                    </div>
                  </div>
                  <div>
                    <div className="text-sm font-medium text-green-600 mb-2">✨ Enhanced</div>
                    <div className="p-4 bg-green-50 border border-green-200 rounded-lg min-h-[100px]">
                      <div className="text-gray-700 prose prose-sm max-w-none prose-strong:text-gray-700 prose-strong:font-semibold">
                        <ReactMarkdown remarkPlugins={[remarkBreaks, remarkGfm]}>{enhancement.answer}</ReactMarkdown>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              {/* Explanation */}
              {(formData.explanation || enhancement.explanation) && (
                <div>
                  <h3 className="text-lg font-semibold mb-3 text-gray-900">Explanation</h3>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                      <div className="text-sm font-medium text-gray-500 mb-2">Current</div>
                      <div className="p-4 bg-gray-50 border border-gray-200 rounded-lg min-h-[100px]">
                        <div className="text-gray-700 prose prose-sm max-w-none prose-strong:text-gray-700 prose-strong:font-semibold">
                          <ReactMarkdown remarkPlugins={[remarkBreaks, remarkGfm]}>{formData.explanation || 'None'}</ReactMarkdown>
                        </div>
                      </div>
                    </div>
                    <div>
                      <div className="text-sm font-medium text-green-600 mb-2">✨ Enhanced</div>
                      <div className="p-4 bg-green-50 border border-green-200 rounded-lg min-h-[100px]">
                        <div className="text-gray-700 prose prose-sm max-w-none prose-strong:text-gray-700 prose-strong:font-semibold">
                          <ReactMarkdown remarkPlugins={[remarkBreaks, remarkGfm]}>{enhancement.explanation || 'None'}</ReactMarkdown>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              )}

              {/* Code Snippet */}
              {(formData.code_snippet || enhancement.code_snippet) && (
                <div>
                  <h3 className="text-lg font-semibold mb-3 text-gray-900">Code Snippet</h3>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                      <div className="text-sm font-medium text-gray-500 mb-2">Current</div>
                      {formData.code_snippet ? (
                        <SyntaxHighlighter
                          language={detectLanguage(formData.code_snippet)}
                          style={vscDarkPlus}
                          className="rounded-lg text-sm"
                        >
                          {formData.code_snippet}
                        </SyntaxHighlighter>
                      ) : (
                        <div className="p-4 bg-gray-50 border border-gray-200 rounded-lg min-h-[100px] text-gray-500">
                          None
                        </div>
                      )}
                    </div>
                    <div>
                      <div className="text-sm font-medium text-green-600 mb-2">✨ Enhanced</div>
                      {enhancement.code_snippet ? (
                        <SyntaxHighlighter
                          language={detectLanguage(enhancement.code_snippet)}
                          style={vscDarkPlus}
                          className="rounded-lg text-sm"
                        >
                          {enhancement.code_snippet}
                        </SyntaxHighlighter>
                      ) : (
                        <div className="p-4 bg-gray-50 border border-gray-200 rounded-lg min-h-[100px] text-gray-500">
                          None
                        </div>
                      )}
                    </div>
                  </div>
                </div>
              )}

              {/* Difficulty */}
              <div>
                <h3 className="text-lg font-semibold mb-3 text-gray-900">Difficulty</h3>
                <div className="flex gap-4 items-center">
                  <div>
                    <div className="text-sm font-medium text-gray-500 mb-2">Current</div>
                    <span className={`px-3 py-1 rounded text-sm font-medium ${
                      formData.difficulty === 'easy'
                        ? 'bg-green-100 text-green-800'
                        : formData.difficulty === 'medium'
                        ? 'bg-yellow-100 text-yellow-800'
                        : 'bg-red-100 text-red-800'
                    }`}>
                      {formData.difficulty}
                    </span>
                  </div>
                  <svg className="w-6 h-6 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 7l5 5m0 0l-5 5m5-5H6" />
                  </svg>
                  <div>
                    <div className="text-sm font-medium text-green-600 mb-2">✨ Enhanced</div>
                    <span className={`px-3 py-1 rounded text-sm font-medium ${
                      enhancement.difficulty === 'easy'
                        ? 'bg-green-100 text-green-800'
                        : enhancement.difficulty === 'medium'
                        ? 'bg-yellow-100 text-yellow-800'
                        : 'bg-red-100 text-red-800'
                    }`}>
                      {enhancement.difficulty}
                    </span>
                  </div>
                </div>
              </div>

              {/* Action Buttons */}
              <div className="flex justify-end gap-3 pt-4 border-t">
                <button
                  onClick={() => setShowEnhancementPreview(false)}
                  className="btn btn-secondary"
                >
                  Cancel
                </button>
                <button
                  onClick={handleApplyEnhancement}
                  className="btn btn-primary"
                >
                  Apply Enhancements
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

export default FlashcardForm;
