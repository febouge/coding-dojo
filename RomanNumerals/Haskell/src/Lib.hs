module Lib
    ( decimalToRoman
    ) where

data RomanSymbols = RomanSymbols { minimumSymbol :: String
                                 , centalSymbol :: String
                                 , maximumSymbol :: String
                                 }

decimalToRoman :: Int -> String
decimalToRoman decimalNumber
  | decimalNumber < 3000 = parseDecimalToRoman decimalNumber
  | otherwise = "It does not accept numbers greater than 3000"

parseDecimalToRoman :: Int -> String
parseDecimalToRoman decimalNumber = foldl (++) "" (map (parseNumberPartToRoman decimalNumber) [1000, 100, 10, 1])


parseNumberPartToRoman :: Int -> Int -> String
parseNumberPartToRoman numberToConvert numberPartToCreate = buildRomanPart numberPartToConvert symbols
  where numberPartToConvert = (numberToConvert `quot` numberPartToCreate) `mod` 10
        symbols = getRomanSymbols numberPartToCreate

buildRomanPart :: Int -> RomanSymbols -> String
buildRomanPart numberToBuild symbols
  | numberToBuild == 0 = ""
  | numberToBuild <= 3 = concat $ replicate numberToBuild (minimumSymbol symbols)
  | numberToBuild == 4 = (minimumSymbol symbols) ++ (centalSymbol symbols)
  | numberToBuild == 5 = centalSymbol symbols
  | numberToBuild <= 8 = (centalSymbol symbols) ++ (concat $ replicate (numberToBuild-5) (minimumSymbol symbols))
  | numberToBuild == 9 = (minimumSymbol symbols) ++ (maximumSymbol symbols)
  | otherwise = error "Error"
  
getRomanSymbols :: Int -> RomanSymbols
getRomanSymbols numberPartToCreate
  | numberPartToCreate == 1000 = RomanSymbols {minimumSymbol = "M", centalSymbol = "", maximumSymbol = ""}
  | numberPartToCreate == 100 = RomanSymbols {minimumSymbol = "C", centalSymbol = "D", maximumSymbol = "M"}
  | numberPartToCreate == 10 = RomanSymbols {minimumSymbol = "X", centalSymbol = "L", maximumSymbol = "C"}
  | numberPartToCreate == 1 = RomanSymbols {minimumSymbol = "I", centalSymbol = "V", maximumSymbol = "X"}
  | otherwise = RomanSymbols {minimumSymbol = "", centalSymbol = "", maximumSymbol = ""}
