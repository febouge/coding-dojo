package com.capgemini.coedevon.codingdojo.stringcalculator


import org.junit.Before
import org.junit.Test
import org.junit.Assert

class StringCalculatorTest {

    private lateinit var stringCalculator: StringCalculator

    @Before
    fun setup() {
        stringCalculator = StringCalculator()
    }

    @Test
    fun emptyStringReturnsZero() {
        Assert.assertEquals("The sum must be zero", 0, stringCalculator.add(""))
        Assert.assertEquals("The sum must be zero", 0, stringCalculator.add("       "))
    }

    @Test
    fun singleNumberReturnsItself() {
        Assert.assertEquals("The sum must be one", 1, stringCalculator.add("1"))
    }

    @Test
    fun twoNumbersCommaDelimitedReturnSum() {
        Assert.assertEquals("The sum must be three", 3, stringCalculator.add("1,2"))
    }

    @Test
    fun moreNumbersCommaDelimitedReturnSum() {
        Assert.assertEquals("The sum must be twenty", 20, stringCalculator.add("1,2,10,7"))
    }

    @Test
    fun numbersCommaAndNewLineDelimitedReturnSum() {
        Assert.assertEquals("The sum must be six", 6, stringCalculator.add("1\n2,3"))
    }

    @Test
    fun numbersCustomDelimitedReturnSum() {
        Assert.assertEquals("The sum must be six", 6, stringCalculator.add("//;\n1;2;3"))
    }

    @Test
    fun negativeNumbersThrowException() {
        try {
            stringCalculator.add("1,2,-3")
        } catch (ex: Exception) {
            Assert.assertEquals("Negative numbers not supported [-3]", ex.message)
        }
    }

    @Test
    fun multipleNegativeNumbersThrowException() {
        try {
            stringCalculator.add("1,-2,-3")
        } catch (ex: Exception) {
            Assert.assertEquals("Negative numbers not supported [-2, -3]", ex.message)
        }
    }

    @Test
    fun numbersGreaterThan1000MustBeIgnored() {
        Assert.assertEquals("The sum must be six", 6, stringCalculator.add("//;\n1;1001;5"))
    }

    @Test
    fun numbersCustomDelimitedAnyLengthReturnSum() {
        Assert.assertEquals("The sum must be six", 6, stringCalculator.add("//[;;;]\n1;;;2;;;3"))
    }

    @Test
    fun numbersMultipleCustomDelimitedAnyLengthReturnSum() {
        Assert.assertEquals("The sum must be ten", 10, stringCalculator.add("//[;;;][@]\n1;;;2@3;;;4"))
    }
}