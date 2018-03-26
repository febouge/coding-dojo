module Data.Rover where

import Data.Orientation
import Data.Command

data Rover = Rover Orientation LunarCoords CommandHistory
  deriving (Show, Eq)

data LunarCoords = LunarCoords Int Int
  deriving (Show, Eq)

data CommandHistory = CommandHistory [Char]
  deriving (Show, Eq)

initRover :: Rover
initRover = Rover North (LunarCoords 0 0) (CommandHistory [])

executeCommands :: [Char] -> Rover
executeCommands commandChars = foldl reversedExecute initRover commandChars
  where reversedExecute = flip executeCommand 

executeCommand :: Char -> Rover -> Rover
executeCommand 'U' rover = undo rover
executeCommand commandChar (Rover orientation position (CommandHistory history)) = execute command (Rover orientation position history')
  where command = commandFrom commandChar
        history' = CommandHistory (history ++ [commandChar])

execute :: Command -> Rover -> Rover
execute TLeft rover = turnRoverLeft rover
execute TRight rover = turnRoverRight rover
execute Forward rover = moveRoverForward rover
execute Backward rover = moveRoverBackward rover

undo :: Rover -> Rover
undo (Rover orientation position (CommandHistory history)) = execute inverseCommand (Rover orientation position (CommandHistory history'))
  where inverseCommand = getUndoFor lastCommand
        lastCommand = last history
        history' = init history
        
turnRoverLeft :: Rover -> Rover
turnRoverLeft (Rover orientation position history) = Rover (turnLeft orientation) position history

turnRoverRight :: Rover -> Rover
turnRoverRight (Rover orientation position history) = Rover (turnRight orientation) position history

moveRoverForward :: Rover -> Rover
moveRoverForward rover = move 1 rover

moveRoverBackward :: Rover -> Rover
moveRoverBackward rover = move (-1) rover

move :: Int -> Rover -> Rover
move movementUnit (Rover orientation position commandHistory)
  | orientation == North = Rover orientation (moveOY position movementUnit) commandHistory
  | orientation == East  = Rover orientation (moveOX position movementUnit) commandHistory
  | orientation == South = Rover orientation (moveOY position (-movementUnit)) commandHistory
  | orientation == West  = Rover orientation (moveOX position (-movementUnit)) commandHistory


moveOY :: LunarCoords -> Int -> LunarCoords
moveOY (LunarCoords x y) movementUnit = LunarCoords x (nextCoordinate y movementUnit)

moveOX :: LunarCoords -> Int -> LunarCoords
moveOX (LunarCoords x y) movementUnit = LunarCoords (nextCoordinate x movementUnit) y

nextCoordinate :: Int -> Int -> Int
nextCoordinate currentCoordinate movementUnit
  | isUpperBound = nextCoord - maxLunarCoord
  | isLowerBound = nextCoord + maxLunarCoord
  | otherwise = nextCoord
  where nextCoord = currentCoordinate + movementUnit
        isUpperBound = nextCoord >= maxLunarCoord
        isLowerBound = nextCoord <= minLunarCoord
        maxLunarCoord = 100
        minLunarCoord = -1
