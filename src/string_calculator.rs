
struct StringCalculator;

impl StringCalculator {
    pub fn new() -> StringCalculator {
        StringCalculator {}
    }

    pub fn add(&self, input: &str) -> u32 {
        if self.is_empty_string(input) {
            return 0;
        }
        let result: u32;
        if self.is_just_one_number(input) {
            result = input.parse().unwrap();
        } else {
            let numbers: Vec<&str> = input.split(|s| s == ',' || s == '\n').collect();
            result = self.sum_string_numbers(&numbers);
        }

        result
    }

    fn sum_string_numbers(&self, string_numbers: &Vec<&str>) -> u32 {
        let parsed_number: Vec<u32> = string_numbers
            .into_iter()
            .map(|string_number| string_number.parse().unwrap())
            .collect();
        parsed_number.into_iter().fold(0, |sum, x| sum + x)
    }

    fn is_empty_string(&self, input: &str) -> bool {
        input == ""
    }

    fn is_just_one_number(&self, input: &str) -> bool {
        input.len() == 1
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn get_string_calculator() -> StringCalculator {
        StringCalculator::new()
    }

    #[test]
    fn empty_string_should_return_zero() {
        assert_eq!(0, get_string_calculator().add(""));
    }

    #[test]
    fn one_number_string_should_return_the_number() {
        assert_eq!(1, get_string_calculator().add("1"));
    }

    #[test]
    fn two_numbers_comma_delimited_string_should_return_the_sum() {
        assert_eq!(3, get_string_calculator().add("1,2"));
    }

    #[test]
    fn more_number_comma_delimited_string_should_return_the_sum() {
        assert_eq!(6, get_string_calculator().add("1,2,3"));
        assert_eq!(10, get_string_calculator().add("1,2,3,4"));
    }

    #[test]
    fn numbers_comma_or_newline_delimited_string_should_return_the_sum() {
        assert_eq!(6, get_string_calculator().add("1\n2,3"));
        assert_eq!(10, get_string_calculator().add("1,2\n3\n4"));
    }
}
