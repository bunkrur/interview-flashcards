-- Flashcard Application Database Schema

-- Categories table
CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    description TEXT,
    color TEXT DEFAULT '#3B82F6',
    icon TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Flashcards table
CREATE TABLE IF NOT EXISTS flashcards (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id INTEGER NOT NULL,
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    code_snippet TEXT,
    difficulty TEXT CHECK(difficulty IN ('easy', 'medium', 'hard')) DEFAULT 'medium',
    explanation TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

-- Card reviews table (tracks spaced repetition data)
CREATE TABLE IF NOT EXISTS card_reviews (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    card_id INTEGER NOT NULL UNIQUE,
    ease_factor REAL DEFAULT 2.5,
    interval INTEGER DEFAULT 1,
    repetitions INTEGER DEFAULT 0,
    next_review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_reviewed_at DATETIME,
    quality_responses TEXT DEFAULT '[]',
    times_seen INTEGER DEFAULT 0,
    times_correct INTEGER DEFAULT 0,
    FOREIGN KEY (card_id) REFERENCES flashcards(id) ON DELETE CASCADE
);

-- Study sessions table (tracks individual study events)
CREATE TABLE IF NOT EXISTS study_sessions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    card_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    quality_rating INTEGER CHECK(quality_rating >= 0 AND quality_rating <= 5) NOT NULL,
    response_time_seconds INTEGER,
    reviewed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (card_id) REFERENCES flashcards(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_flashcards_category ON flashcards(category_id);
CREATE INDEX IF NOT EXISTS idx_flashcards_difficulty ON flashcards(difficulty);
CREATE INDEX IF NOT EXISTS idx_card_reviews_next_review ON card_reviews(next_review_date);
CREATE INDEX IF NOT EXISTS idx_study_sessions_card ON study_sessions(card_id);
CREATE INDEX IF NOT EXISTS idx_study_sessions_category ON study_sessions(category_id);
CREATE INDEX IF NOT EXISTS idx_study_sessions_reviewed_at ON study_sessions(reviewed_at);
