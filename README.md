
# Career Recommendation Portal

## Backend Setup Instructions

### Prerequisites
- Node.js installed on your computer
- MySQL installed and running on your computer
- Database credentials (username, password) as specified in the .env file

### Setup Steps

1. **Install Backend Dependencies**
   ```bash
   npm install --prefix backend
   ```

2. **Setup Database**
   ```bash
   npm run setup-db --prefix backend
   ```

3. **Start the Backend Server**
   ```bash
   npm start --prefix backend
   ```
   
   or for development with auto-reload:
   ```bash
   npm run dev --prefix backend
   ```

4. **Verify the Server is Running**
   Open your browser and go to: http://localhost:5000/api/health
   
   You should see a response like:
   ```json
   {
     "status": "ok",
     "message": "Server is running"
   }
   ```

## Frontend Development
The frontend React application will automatically connect to the backend when running locally.

## Important Notes
- The backend runs on port 5000 by default
- Make sure your MySQL service is running before starting the server
- Check the .env file for configuration settings if needed
