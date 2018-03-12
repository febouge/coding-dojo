module Data.Command where

data Command = Forward | Backward | TRight | TLeft
  deriving (Show, Eq)

commandFrom :: Char -> Command
commandFrom charCommand
  | charCommand == 'F' = Forward
  | charCommand == 'B' = Backward
  | charCommand == 'L' = TLeft
  | charCommand == 'R' = TRight
  | otherwise = error "Bad command"

