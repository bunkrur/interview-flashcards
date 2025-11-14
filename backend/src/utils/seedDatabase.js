import fs from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import { getDatabase, closeDatabase } from './database.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const seedPath = join(__dirname, '../../database/seed.sql');

function seedDatabase() {
  console.log('Seeding database with all 250 flashcards...');

  const db = getDatabase();
  const seedData = fs.readFileSync(seedPath, 'utf8');

  try {
    // Load and execute seed file
    console.log('Loading seed data...');
    db.exec(seedData);

    // Initialize card_reviews for all flashcards
    console.log('Initializing card reviews...');
    const flashcards = db.prepare('SELECT id FROM flashcards').all();
    const insertReview = db.prepare(`
      INSERT INTO card_reviews (card_id, ease_factor, interval, repetitions, next_review_date)
      VALUES (?, 2.5, 1, 0, datetime('now'))
    `);

    for (const card of flashcards) {
      insertReview.run(card.id);
    }

    // Display stats
    const categoryCount = db.prepare('SELECT COUNT(*) as count FROM categories').get();
    const flashcardCount = db.prepare('SELECT COUNT(*) as count FROM flashcards').get();

    // Get breakdown by category
    const categoryBreakdown = db.prepare(`
      SELECT c.name, COUNT(f.id) as count
      FROM categories c
      LEFT JOIN flashcards f ON c.id = f.category_id
      GROUP BY c.id
      ORDER BY c.id
    `).all();

    console.log('\n✅ Database seeded successfully!');
    console.log(`📊 Categories: ${categoryCount.count}`);
    console.log(`📇 Total Flashcards: ${flashcardCount.count}`);
    console.log('\nBreakdown by category:');
    categoryBreakdown.forEach(cat => {
      console.log(`  - ${cat.name}: ${cat.count} cards`);
    });
  } catch (error) {
    console.error('❌ Error seeding database:', error);
    throw error;
  } finally {
    closeDatabase();
  }
}

// Run if called directly
if (import.meta.url === `file://${process.argv[1]}`) {
  seedDatabase();
}

export default seedDatabase;
