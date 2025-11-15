import { useEffect, useCallback } from 'react';
import { Prism as SyntaxHighlighter } from 'react-syntax-highlighter';
import { vscDarkPlus } from 'react-syntax-highlighter/dist/esm/styles/prism';
import ReactMarkdown from 'react-markdown';
import remarkBreaks from 'remark-breaks';
import remarkGfm from 'remark-gfm';

function FlashCard({ card, onFlip, isFlipped = false }) {
  const handleFlip = useCallback(() => {
    if (onFlip) {
      onFlip(!isFlipped);
    }
  }, [onFlip, isFlipped]);

  if (!card) {
    return <div className="card p-8 text-center text-gray-500">No card data</div>;
  }

  // Add keyboard support for spacebar
  useEffect(() => {
    const handleKeyPress = (event) => {
      if (event.code === 'Space' && event.target.tagName !== 'BUTTON' && event.target.tagName !== 'INPUT' && event.target.tagName !== 'TEXTAREA') {
        event.preventDefault();
        handleFlip();
      }
    };

    window.addEventListener('keydown', handleKeyPress);
    return () => window.removeEventListener('keydown', handleKeyPress);
  }, [handleFlip]);

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

  const renderCodeSnippet = (code) => {
    if (!code) return null;

    return (
      <div className="mt-4">
        <SyntaxHighlighter
          language={detectLanguage(code)}
          style={vscDarkPlus}
          className="rounded-lg text-sm"
        >
          {code}
        </SyntaxHighlighter>
      </div>
    );
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
    <div
      className={`flip-card w-full max-w-3xl mx-auto ${isFlipped ? 'flipped' : ''}`}
      onClick={handleFlip}
      role="button"
      tabIndex={0}
      onKeyPress={(e) => {
        if (e.key === 'Enter') {
          handleFlip();
        }
      }}
    >
      <div className="flip-card-inner relative">
        {/* Front of card - Question */}
        <div
          className={`flip-card-front ${
            isFlipped ? 'hidden' : 'block'
          } card min-h-[400px] cursor-pointer hover:shadow-xl transition-shadow`}
        >
          <div className="flex items-center justify-between mb-4">
            <span
              className={`px-3 py-1 rounded-full text-xs font-medium ${getDifficultyColor(
                card.difficulty
              )}`}
            >
              {card.difficulty}
            </span>
            {card.category_name && (
              <span
                className="px-3 py-1 rounded-full text-xs font-medium"
                style={{
                  backgroundColor: `${card.category_color}20`,
                  color: card.category_color,
                }}
              >
                {card.category_name}
              </span>
            )}
          </div>

          <div className="flex flex-col items-center justify-center min-h-[300px]">
            <h3 className="text-2xl font-semibold text-gray-900 text-center mb-4">
              {card.question}
            </h3>
            <p className="text-gray-500 text-sm mt-4">Click to reveal answer</p>
          </div>
        </div>

        {/* Back of card - Answer */}
        <div
          className={`flip-card-back ${
            isFlipped ? 'block' : 'hidden'
          } card min-h-[400px] cursor-pointer hover:shadow-xl transition-shadow bg-primary-50`}
        >
          <div className="flex items-center justify-between mb-4">
            <span className="text-sm text-primary-600 font-medium">Answer</span>
            <span
              className={`px-3 py-1 rounded-full text-xs font-medium ${getDifficultyColor(
                card.difficulty
              )}`}
            >
              {card.difficulty}
            </span>
          </div>

          <div className="space-y-4">
            <div className="bg-white rounded-lg p-4">
              <div className="text-lg text-gray-900 prose prose-sm max-w-none prose-strong:text-gray-900 prose-strong:font-semibold">
                <ReactMarkdown remarkPlugins={[remarkBreaks, remarkGfm]}>{card.answer}</ReactMarkdown>
              </div>
            </div>

            {card.code_snippet && renderCodeSnippet(card.code_snippet)}

            {card.explanation && (
              <div className="bg-blue-50 border-l-4 border-blue-400 p-4 rounded">
                <p className="font-semibold text-sm text-blue-900 mb-2">Explanation:</p>
                <div className="text-sm text-blue-900 prose prose-sm max-w-none prose-strong:text-blue-900 prose-strong:font-semibold prose-p:mt-0">
                  <ReactMarkdown remarkPlugins={[remarkBreaks, remarkGfm]}>{card.explanation}</ReactMarkdown>
                </div>
              </div>
            )}
          </div>

          <p className="text-gray-500 text-sm mt-4 text-center">
            Click to see question
          </p>
        </div>
      </div>
    </div>
  );
}

export default FlashCard;
