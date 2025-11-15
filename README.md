# Flashcards - Tech Knowledge Learning Cards App

A full-stack flashcard application for coding and tech knowledge with spaced repetition algorithm (SM-2).

## Features

- **Spaced Repetition Learning**: SM-2 algorithm for optimal review scheduling
- **AI-Powered Explanations**: Get additional context and deeper explanations using Claude Sonnet 4.5
- **250+ Flashcards**: 25+ cards per category covering beginner to advanced topics
- **10+ Categories**: Linux, Git, Kubernetes, ArgoCD, Docker, Computer Science, SRE, Networking, SQL, System Design
- **Progress Tracking**: Track your learning progress, streaks, and mastery levels
- **Progress Reset**: Clear your learning progress while keeping all flashcards
- **Export to SQL**: Download all flashcards and categories as a SQL file for backup or sharing
- **Card Management**: Create, edit, and organize flashcards
- **Search & Filter**: Find cards by category, difficulty, or keywords
- **Keyboard Shortcuts**: Spacebar to flip cards, 0-5 keys to rate answers

## Tech Stack

- **Frontend**: React 18, React Router, Tailwind CSS, Vite
- **Backend**: Node.js, Express.js
- **Database**: SQLite3
- **AI**: Anthropic Claude API
- **Visualization**: Recharts
- **Code Highlighting**: React Syntax Highlighter

## Project Structure

```
flashcards/
├── start.sh                    # Quick startup script
├── backend/
│   ├── database/
│   │   ├── schema.sql          # Database schema
│   │   ├── seed.sql            # All 250 flashcards
│   │   └── flashcards.db       # SQLite database (generated)
│   ├── src/
│   │   ├── routes/             # API routes
│   │   ├── controllers/        # Request handlers
│   │   ├── models/             # Database models (SM-2 algorithm)
│   │   ├── middleware/         # Express middleware
│   │   ├── utils/              # Database utilities
│   │   └── server.js           # Express server
│   └── package.json
├── frontend/
│   ├── public/
│   ├── src/
│   │   ├── components/         # React components
│   │   ├── pages/              # Page components
│   │   ├── hooks/              # Custom React hooks
│   │   ├── services/           # API client
│   │   ├── utils/              # Utility functions
│   │   └── styles/             # Tailwind CSS
│   └── package.json
└── package.json                # Root package.json
```

## Getting Started

### Quick Start

The fastest way to get started:

```bash
# 1. Install dependencies
npm run install-all

# 2. Initialize and seed database (250 flashcards)
cd backend
npm run init-db
npm run seed-db
cd ..

# 3. Start both servers with one command
./start.sh
```

The app will be available at http://localhost:5173

### AI Configuration (Optional)

The "Ask AI" feature uses Claude Sonnet 4.5 to provide additional explanations. To enable it:

1. Get your API key from [Anthropic Console](https://console.anthropic.com/)
2. Create `backend/.env` file:
   ```bash
   ANTHROPIC_API_KEY=your-api-key-here
   PORT=3001
   NODE_ENV=development
   ```
3. Restart servers: `./start.sh`

**Note**: The app works without an API key, but the "Ask AI" feature will show an error message when clicked.

### Development

```bash
# Quick start (recommended) - kills old instances and starts fresh
./start.sh

# Or run both frontend and backend concurrently
npm run dev

# Or run individually
npm run dev:backend  # Backend on http://localhost:3001
npm run dev:frontend # Frontend on http://localhost:5173

# View logs from start.sh
tail -f /tmp/flashcards-backend.log
tail -f /tmp/flashcards-frontend.log

# Stop all servers
pkill -9 node
```

### Production

```bash
# Build frontend
npm run build

# Start backend server
npm start
```

## API Endpoints

### Categories
- `GET /api/categories` - List all categories
- `GET /api/categories/:id` - Get category details
- `POST /api/categories` - Create category
- `PUT /api/categories/:id` - Update category
- `DELETE /api/categories/:id` - Delete category

### Flashcards
- `GET /api/flashcards` - List all cards (with filters)
- `GET /api/flashcards/:id` - Get specific card
- `POST /api/flashcards` - Create card
- `PUT /api/flashcards/:id` - Update card
- `DELETE /api/flashcards/:id` - Delete card
- `GET /api/categories/:id/cards` - Get cards by category

### Study
- `GET /api/study/due` - Get cards due for review
- `GET /api/study/category/:id/due` - Get due cards in category
- `POST /api/study/review` - Submit review response
- `GET /api/study/next` - Get next card to study

### Progress
- `GET /api/progress/stats` - Overall statistics
- `GET /api/progress/category/:id` - Category-specific stats
- `GET /api/progress/history` - Study history timeline
- `POST /api/progress/reset` - Reset all progress (keeps flashcards)

### AI
- `POST /api/ai/explain` - Get AI explanation for a flashcard answer
- `POST /api/ai/ask` - Ask AI a custom question

### Import/Export
- `GET /api/flashcards/export` - Export all flashcards and categories to SQL file

## Spaced Repetition Algorithm

The app uses the SM-2 (SuperMemo 2) algorithm:

- **Quality Ratings**: 0-5 scale after each review
  - 0: Complete blackout
  - 1: Incorrect, but recognized
  - 2: Incorrect, but easy to recall
  - 3: Correct, but difficult
  - 4: Correct, with hesitation
  - 5: Perfect response

- **Intervals**: Automatically calculated based on performance
  - First review: 1 day
  - Second review: 6 days
  - Subsequent: previous_interval × ease_factor

- **Ease Factor**: Adjusted based on quality (minimum 1.3)

## Flashcard Database

The application includes **250+ carefully curated flashcards** covering essential technical knowledge



### Difficulty Levels
- **Easy**: Fundamental concepts and basic commands
- **Medium**: Practical applications and common scenarios
- **Hard**: Advanced topics, edge cases, and design trade-offs

Each flashcard includes:
- Clear, concise questions
- Accurate answers
- Detailed explanations with context
- Practical examples and use cases

### Adding More Questions

To add more flashcards to the database:

**Option 1: Add to seed.sql (recommended for sharing)**
```bash
# Edit backend/database/seed.sql
# Add your flashcards at the end, following the existing format
# Re-run the seed command
cd backend
npm run seed-db
```

**Option 2: Create a separate SQL file**
```bash
cd backend/database

# Create your SQL file
cat > my_cards.sql << 'EOF'
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (1, 'Your question here?', 'Your answer here', 'medium', 'Detailed explanation.');
EOF

# Apply it to the database
sqlite3 flashcards.db < my_cards.sql
```

Example flashcard format:
```sql
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (1, 'Your question?', 'Your answer', 'medium', 'Detailed explanation with context.'),
    (1, 'Another question?', 'Another answer', 'easy', 'More explanation.');
```

**Note**: The 250 included flashcards are all in `seed.sql` for easy version control and sharing.

## Features in Detail

### Export to SQL
The Progress page includes an "Export to SQL" button that allows you to backup or share your flashcard collection:
- Downloads all flashcards and categories as a formatted SQL file
- File is named with the current date (e.g., `flashcards_export_2025-11-14.sql`)
- Can be shared with others or used to restore your flashcards
- Perfect for creating custom flashcard sets to share with the community
- Generated SQL includes category structure and all flashcard data

### Progress Reset
The Progress page includes a "Reset Progress" button that allows you to start fresh while keeping all flashcards:
- Clears all review history and statistics
- Resets card intervals and ease factors
- Deletes study session history
- Makes all cards available for review again
- **Keeps all 250 flashcards intact**

### Keyboard Shortcuts
- **Space**: Flip flashcard to reveal answer
- **0-5 Keys**: Rate your answer (when card is flipped)
  - 0: Complete blackout
  - 1: Hard (incorrect response)
  - 2: Okay (recalled with effort)
  - 3: Good (correct, some difficulty)
  - 4: Easy (correct, slight hesitation)
  - 5: Perfect (perfect response)

## License

MIT


