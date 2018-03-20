module Lib
    ( roverCommandLine
    ) where

import Data.Rover

roverCommandLine :: IO ()
roverCommandLine = do
  putStrLn "Lunar rover command line tool.\n \
           \Please input commands as a single char (B) or mutiple (BLRF) \n\ 
           \The rover will start at (0,0) & North orientation. \n\
           \Available commands: \n\
           \F -> Move Rover Forward \n\
           \B -> Move Rover Backward \n\
           \R -> Turn Rover Right \n\
           \L -> Turn Rover Left \n\
           \Input: "           
  commands <- getLine  
  print $ executeCommands commands 
