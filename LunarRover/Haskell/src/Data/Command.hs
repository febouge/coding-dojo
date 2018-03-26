module Data.Command where

data Command = Forward
             | Backward
             | TRight
             | TLeft
             | Undo
  deriving (Show, Eq)

commandFrom :: Char -> Command
commandFrom charCommand
  | charCommand == 'F' = Forward
  | charCommand == 'B' = Backward
  | charCommand == 'L' = TLeft
  | charCommand == 'R' = TRight
  | charCommand == 'U' = Undo
  | otherwise = error "Bad command"


getUndoFor :: Char -> Command
getUndoFor charCommand
  | charCommand == 'F' = Backward
  | charCommand == 'B' = Forward
  | charCommand == 'L' = TRight
  | charCommand == 'R' = TLeft
  | otherwise = error "Bad command"


