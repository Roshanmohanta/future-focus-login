
const { pool } = require('../config/db');
const bcrypt = require('bcryptjs');

class User {
  static async findByUsername(username) {
    try {
      const [rows] = await pool.query('SELECT * FROM users WHERE username = ?', [username]);
      return rows.length ? rows[0] : null;
    } catch (error) {
      console.error('Error finding user by username:', error.message);
      throw error;
    }
  }

  static async findByEmail(email) {
    try {
      const [rows] = await pool.query('SELECT * FROM users WHERE email = ?', [email]);
      return rows.length ? rows[0] : null;
    } catch (error) {
      console.error('Error finding user by email:', error.message);
      throw error;
    }
  }

  static async create(userData) {
    try {
      // Hash the password
      const salt = await bcrypt.genSalt(10);
      const hashedPassword = await bcrypt.hash(userData.password, salt);

      // Insert user into database
      const [result] = await pool.query(
        'INSERT INTO users (username, email, password, name, phone, address, age, date_of_birth) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        [
          userData.username, 
          userData.email, 
          hashedPassword, 
          userData.name, 
          userData.phone, 
          userData.address, 
          userData.age, 
          userData.dateOfBirth
        ]
      );

      // Return the created user (without password)
      const [newUser] = await pool.query('SELECT id, username, email, name, role FROM users WHERE id = ?', [result.insertId]);
      return newUser[0];
    } catch (error) {
      console.error('Error creating user:', error.message);
      throw error;
    }
  }

  static async verifyPassword(plainPassword, hashedPassword) {
    return await bcrypt.compare(plainPassword, hashedPassword);
  }
}

module.exports = User;
