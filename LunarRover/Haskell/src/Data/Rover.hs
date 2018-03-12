module Data.Rover where

import Data.Orientation
import Data.Command

data Rover = Rover Orientation (Int, Int)
  deriving (Show, Eq)

initRover :: Rover
initRover = Rover North (0,0)


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
move movementUnit (Rover orientation (x,y))
  | Rover orientation (x,y) == Rover North (x,y) = Rover North (x,y+movementUnit)
  | Rover orientation (x,y) == Rover East (x,y) = Rover East (x+movementUnit, y)
  | Rover orientation (x,y) == Rover South (x,y) = Rover South (x, y-movementUnit)
  | Rover orientation (x,y) == Rover West (x,y) = Rover West (x-movementUnit, y)
