
const fs = require('fs');
const path = require('path');
const mysql = require('mysql2/promise');
const dotenv = require('dotenv');

dotenv.config();

const executeSQL = async () => {
  try {
    // Create connection
    const connection = await mysql.createConnection({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD
    });

    console.log('Connected to MySQL server');
    
    // Read SQL file
    const sqlFilePath = path.join(__dirname, '..', '..', 'public', 'database_update.sql');
    const sqlContent = fs.readFileSync(sqlFilePath, 'utf8');

    console.log('SQL file loaded');

    // Split SQL statements
    const statements = sqlContent
      .split(';')
      .filter(statement => statement.trim() !== '')
      .map(statement => statement.trim() + ';');

    // Execute each statement
    for (const statement of statements) {
      try {
        await connection.query(statement);
      } catch (err) {
        console.error(`Error executing SQL statement: ${statement.substring(0, 100)}...`);
        console.error(err.message);
      }
    }

    console.log('Database setup completed successfully');
    await connection.end();
  } catch (error) {
    console.error('Database setup failed:', error.message);
    process.exit(1);
  }
};

executeSQL();
