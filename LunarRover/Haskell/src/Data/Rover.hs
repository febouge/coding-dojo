module Data.Rover where

import Data.Orientation
import Data.Command

data Rover = Rover Orientation LunarCoords
  deriving (Show, Eq)

data LunarCoords = LunarCoords Int Int
  deriving (Show, Eq)

initRover :: Rover
initRover = Rover North (LunarCoords 0 0)

executeCommands :: [Char] -> Rover
executeCommands commandChars = foldl reversedExecute initRover commandChars
  where reversedExecute = flip executeCommand 

executeCommand :: Char -> Rover -> Rover
executeCommand commandChar rover = execute (commandFrom commandChar) rover

execute :: Command -> Rover -> Rover
execute TLeft rover = turnRoverLeft rover
execute TRight rover = turnRoverRight rover
execute Forward rover = moveRoverForward rover
execute Backward rover = moveRoverBackward rover

turnRoverLeft :: Rover -> Rover
turnRoverLeft (Rover orientation position) = Rover (turnLeft orientation) position

turnRoverRight :: Rover -> Rover
turnRoverRight (Rover orientation position) = Rover (turnRight orientation) position

moveRoverForward :: Rover -> Rover
moveRoverForward rover = move 1 rover

moveRoverBackward :: Rover -> Rover
moveRoverBackward rover = move (-1) rover

move :: Int -> Rover -> Rover
move movementUnit (Rover orientation position)
  | orientation == North = Rover orientation (moveOY position movementUnit)
  | orientation == East  = Rover orientation (moveOX position movementUnit)
  | orientation == South = Rover orientation (moveOY position (-movementUnit))
  | orientation == West  = Rover orientation (moveOX position (-movementUnit))


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
