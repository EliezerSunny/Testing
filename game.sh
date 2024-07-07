#!/bin/bash

# Tic-Tac-Toe Game

# Initialize the game board
board=(" " " " " " " " " " " " " " " " " ")

# Function to print the game board
print_board() {
  echo " ${board[0]} | ${board[1]} | ${board[2]}"
  echo "---+---+---"
  echo " ${board[3]} | ${board[4]} | ${board[5]}"
  echo "---+---+---"
  echo " ${board[6]} | ${board[7]} | ${board[8]}"
}

# Function to check for a win
check_win() {
  local win_patterns=(
    "0 1 2" "3 4 5" "6 7 8"  # Rows
    "0 3 6" "1 4 7" "2 5 8"  # Columns
    "0 4 8" "2 4 6"          # Diagonals
  )
  
  for pattern in "${win_patterns[@]}"; do
    set -- $pattern
    if [[ "${board[$1]}" != " " && "${board[$1]}" == "${board[$2]}" && "${board[$2]}" == "${board[$3]}" ]]; then
      echo "Player ${board[$1]} wins!"
      exit 0
    fi
  done

  if ! [[ " ${board[@]} " =~ " " ]]; then
    echo "It's a tie!"
    exit 0
  fi
}

# Function to make a move
make_move() {
  local player=$1
  local position=$2

  if [[ "${board[$position]}" == " " ]]; then
    board[$position]=$player
  else
    echo "Invalid move. Try again."
    return 1
  fi

  print_board
  check_win
  return 0
}

# Main game loop
print_board
current_player="X"

while true; do
  read -p "Player $current_player, enter your move (0-8): " move
  if ! [[ "$move" =~ ^[0-8]$ ]]; then
    echo "Invalid input. Please enter a number between 0 and 8."
    continue
  fi

  if make_move $current_player $move; then
    current_player=$([[ "$current_player" == "X" ]] && echo "O" || echo "X")
  fi
done
