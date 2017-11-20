package com.capgemini.coedevon.codingdojo.stringcalculator

class StringCalculator {

    private val defaultDelimiters: Regex = Regex("[\n,]+")

    private val customDelimiterIndicator: String = "//"

    private val customDelimitersPart: Int = 0

    private val customDelimiterNumbersPart: Int = 1

    fun add(input: String): Int {
        if (input.isBlank())
            return 0

        var numbersAsStringWithDelimiters = input
        var numbers: List<Int>
        var delimiters: Regex = defaultDelimiters;
        if (inputContainsCustomDelimiters(input)) {
            val parts = input.split(Regex("\n"))
            delimiters = getCustomDelimiter(parts[customDelimitersPart])
            numbersAsStringWithDelimiters = parts[customDelimiterNumbersPart]
        }
        numbers = numbersAsStringWithDelimiters.split(delimiters).map(String::toInt)
        if (thereAreNegativeNumber(numbers))
            throw Exception("Negative numbers not supported ".plus(getNegativeNumbers(numbers)))

        return filterAndSumStringNumbers(numbers)
    }

    private fun inputContainsCustomDelimiters(input: String): Boolean = input.startsWith(customDelimiterIndicator)

    private fun getCustomDelimiter(delimiterPart: String): Regex {
        var customDelimiters = delimiterPart.removePrefix(customDelimiterIndicator)
                .replace("[", "(")
                .replace("]", ")")
        return createRegexFromDelimiters(customDelimiters)
    }

    private fun createRegexFromDelimiters(delimiters: String) = Regex("[$delimiters]+")

    private val negativeNumbers = { number: Int -> number < 0 }

    private fun thereAreNegativeNumber(numbersToCheck: List<Int>): Boolean = numbersToCheck.any(negativeNumbers)

    private fun getNegativeNumbers(numbers: List<Int>): List<Int> = numbers.filter(negativeNumbers)

    private fun filterAndSumStringNumbers(numbers: List<Int>): Int {
        return numbers.filter(numbersLessThan1001).reduce(sumListValues)
    }

    private val numbersLessThan1001 = { number: Int -> number < 1001}

    private val sumListValues = { sum: Int, nextValue: Int -> sum + nextValue }
}