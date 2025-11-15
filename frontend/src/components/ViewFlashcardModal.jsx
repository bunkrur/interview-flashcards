import { Prism as SyntaxHighlighter } from 'react-syntax-highlighter';
import { vscDarkPlus } from 'react-syntax-highlighter/dist/esm/styles/prism';
import ReactMarkdown from 'react-markdown';
import remarkBreaks from 'remark-breaks';
import remarkGfm from 'remark-gfm';

function ViewFlashcardModal({ isOpen, onClose, flashcard }) {
  if (!isOpen || !flashcard) return null;

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

  const getDifficultyColor = (difficulty) => {
    switch (difficulty) {
      case 'easy':
        return 'bg-green-100 text-green-800';
      case 'medium':
        return 'bg-yellow-100 text-yellow-800';
      case 'hard':
        return 'bg-red-100 text-red-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-lg max-w-4xl w-full max-h-[90vh] overflow-y-auto">
        <div className="sticky top-0 bg-white border-b border-gray-200 p-6">
          <div className="flex items-center justify-between">
            <h2 className="text-2xl font-bold text-gray-900">Flashcard Details</h2>
            <button
              onClick={onClose}
              className="text-gray-400 hover:text-gray-600"
            >
              <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>
        </div>

        <div className="p-6 space-y-6">
          {/* Category and Difficulty */}
          <div className="flex items-center gap-3">
            <span
              className="px-3 py-1 rounded-full text-sm font-medium"
              style={{
                backgroundColor: `${flashcard.category_color}20`,
                color: flashcard.category_color,
              }}
            >
              {flashcard.category_name}
            </span>
            <span
              className={`px-3 py-1 rounded-full text-sm font-medium ${getDifficultyColor(
                flashcard.difficulty
              )}`}
            >
              {flashcard.difficulty}
            </span>
          </div>

          {/* Question */}
          <div>
            <h3 className="text-sm font-medium text-gray-500 mb-2">Question</h3>
            <div className="p-4 bg-gray-50 border border-gray-200 rounded-lg">
              <p className="text-lg text-gray-900 whitespace-pre-wrap">{flashcard.question}</p>
            </div>
          </div>

          {/* Answer */}
          <div>
            <h3 className="text-sm font-medium text-gray-500 mb-2">Answer</h3>
            <div className="p-4 bg-primary-50 border border-primary-200 rounded-lg">
              <div className="text-gray-900 prose prose-sm max-w-none prose-strong:text-gray-900 prose-strong:font-semibold">
                <ReactMarkdown remarkPlugins={[remarkBreaks, remarkGfm]}>{flashcard.answer}</ReactMarkdown>
              </div>
            </div>
          </div>

          {/* Code Snippet */}
          {flashcard.code_snippet && (
            <div>
              <h3 className="text-sm font-medium text-gray-500 mb-2">Code Snippet</h3>
              <SyntaxHighlighter
                language={detectLanguage(flashcard.code_snippet)}
                style={vscDarkPlus}
                className="rounded-lg text-sm"
              >
                {flashcard.code_snippet}
              </SyntaxHighlighter>
            </div>
          )}

          {/* Explanation */}
          {flashcard.explanation && (
            <div>
              <h3 className="text-sm font-medium text-gray-500 mb-2">Explanation</h3>
              <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg">
                <div className="text-gray-900 prose prose-sm max-w-none prose-strong:text-gray-900 prose-strong:font-semibold">
                  <ReactMarkdown remarkPlugins={[remarkBreaks, remarkGfm]}>{flashcard.explanation}</ReactMarkdown>
                </div>
              </div>
            </div>
          )}

          {/* Study Statistics */}
          {flashcard.times_seen > 0 && (
            <div>
              <h3 className="text-sm font-medium text-gray-500 mb-2">Study Statistics</h3>
              <div className="p-4 bg-gray-50 border border-gray-200 rounded-lg">
                <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-center">
                  <div>
                    <p className="text-2xl font-bold text-primary-600">{flashcard.times_seen}</p>
                    <p className="text-sm text-gray-600">Times Seen</p>
                  </div>
                  <div>
                    <p className="text-2xl font-bold text-green-600">{flashcard.times_correct}</p>
                    <p className="text-sm text-gray-600">Correct</p>
                  </div>
                  <div>
                    <p className="text-2xl font-bold text-red-600">
                      {flashcard.times_seen - flashcard.times_correct}
                    </p>
                    <p className="text-sm text-gray-600">Incorrect</p>
                  </div>
                  <div>
                    <p className="text-2xl font-bold text-blue-600">
                      {flashcard.times_seen > 0
                        ? Math.round((flashcard.times_correct / flashcard.times_seen) * 100)
                        : 0}
                      %
                    </p>
                    <p className="text-sm text-gray-600">Success Rate</p>
                  </div>
                </div>
              </div>
            </div>
          )}

          {/* Close Button */}
          <div className="flex justify-end pt-4 border-t">
            <button onClick={onClose} className="btn btn-secondary">
              Close
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default ViewFlashcardModal;
