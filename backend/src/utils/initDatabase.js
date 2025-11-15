import fs from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import { getDatabase, closeDatabase } from './database.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const schemaPath = join(__dirname, '../../database/schema.sql');

function initDatabase() {
  console.log('Initializing database...');

  const db = getDatabase();
  const schema = fs.readFileSync(schemaPath, 'utf8');

  try {
    // Execute entire schema at once (db.exec handles transactions internally)
    db.exec(schema);

    console.log('✅ Database initialized successfully!');
    console.log(`📁 Database location: ${db.name}`);
  } catch (error) {
    console.error('❌ Error initializing database:', error);
    throw error;
  } finally {
    closeDatabase();
  }
}

// Run if called directly
if (import.meta.url === `file://${process.argv[1]}`) {
  initDatabase();
}

export default initDatabase;
