module Data.Orientation where

data Orientation = North
                 | East
                 | South
                 | West
  deriving (Show, Eq)

turnRight :: Orientation -> Orientation
turnRight North = East
turnRight West  = North
turnRight South = West
turnRight East  = South


turnLeft :: Orientation -> Orientation
turnLeft North = West
turnLeft West  = South
turnLeft South = East
turnLeft East  = North


