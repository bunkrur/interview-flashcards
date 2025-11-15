#!/bin/bash

# Flashcards Application Startup Script
# This script kills any existing instances and starts fresh backend and frontend servers

echo "🛑 Stopping any existing instances..."
pkill -9 node 2>/dev/null

echo "⏳ Waiting for processes to terminate..."
sleep 2

# Kill any processes on ports 3001 and 5173 just to be sure
lsof -ti:3001 | xargs kill -9 2>/dev/null
lsof -ti:5173 | xargs kill -9 2>/dev/null

echo ""
echo "🚀 Starting Flashcards Application..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Start backend
echo "📦 Starting backend server..."
cd "$SCRIPT_DIR/backend"
npm start > /tmp/flashcards-backend.log 2>&1 &
BACKEND_PID=$!
echo "   Backend PID: $BACKEND_PID"
echo "   Log file: /tmp/flashcards-backend.log"

# Wait a moment for backend to initialize
sleep 3

# Start frontend
echo ""
echo "🎨 Starting frontend server..."
cd "$SCRIPT_DIR/frontend"
npm run dev > /tmp/flashcards-frontend.log 2>&1 &
FRONTEND_PID=$!
echo "   Frontend PID: $FRONTEND_PID"
echo "   Log file: /tmp/flashcards-frontend.log"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Application started successfully!"
echo ""
echo "🌐 Access the application:"
echo "   Frontend: http://localhost:5173"
echo "   Backend:  http://localhost:3001"
echo ""
echo "📝 View logs:"
echo "   Backend:  tail -f /tmp/flashcards-backend.log"
echo "   Frontend: tail -f /tmp/flashcards-frontend.log"
echo ""
echo "🛑 To stop the application:"
echo "   pkill -9 node"
echo ""
echo "Process IDs saved for reference:"
echo "   Backend:  $BACKEND_PID"
echo "   Frontend: $FRONTEND_PID"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
