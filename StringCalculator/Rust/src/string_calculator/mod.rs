
pub struct StringCalculator;

const CUSTOM_DELIMITER_INDICATOR: &'static str = "//";

impl StringCalculator {
    pub fn new() -> StringCalculator {
        StringCalculator {}
    }

    pub fn add(&self, input: &str) -> u32 {
        if self.is_empty_string(input) {
            return 0;
        }
        let mut delimiters = self.get_default_delimiters();        
        if self.input_has_custom_delimiters(&input) {
            
        }
        
        let numbers: Vec<&str> = input.split(|s| delimiters.contains(&s)).collect();
        let result = self.parse_and_sum_string_numbers(&numbers);

        result
    }

    fn input_has_custom_delimiters(&self, input: &str) -> bool {
        input.starts_with(CUSTOM_DELIMITER_INDICATOR)
    }

    fn get_default_delimiters(&self) -> Vec<char> {
        vec![',', '\n']
    }

    fn parse_and_sum_string_numbers(&self, string_numbers: &Vec<&str>) -> u32 {
        let parsed_numbers: Vec<u32> = self.parse(string_numbers);
        self.sum_vector_elements(parsed_numbers)
    }

    fn parse(&self, string_numbers: &Vec<&str>) -> Vec<u32> {
        println!("{:?}", string_numbers);
        string_numbers
            .into_iter()
            .map(|string_number| string_number.parse().unwrap())
            .collect()
    }

    fn sum_vector_elements(&self, input: Vec<u32>) -> u32 {
        input.into_iter().fold(0, |sum, x| sum + x)
    }

    fn is_empty_string(&self, input: &str) -> bool {
        input == ""
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
        assert_eq!(15, get_string_calculator().add("1,2\n3\n4,5"));
    }

    #[test]
    fn numbers_custom_delimited_string_should_return_the_sum() {
        assert_eq!(6, get_string_calculator().add("//;\n1;2;3"));
    }
}
