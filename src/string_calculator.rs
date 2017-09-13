
struct StringCalculator;

impl StringCalculator {
    pub fn new() -> StringCalculator {
        StringCalculator{}
    }

    pub fn add(&self, input: &str) -> u32 {
        if input == "" {
            return 0;
        }
        let result: u32;
        if input.len() == 1 {
            result = input.parse().unwrap();
        } else {
            let numbers: Vec<&str> = input.split(",").collect();
            let number1: u32 = numbers[0].parse().unwrap();
            let number2: u32 = numbers[1].parse().unwrap();
            result = number1 + number2;
        }

        result
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
    fn two_number_comma_delimited_string_should_return_the_number() {
        assert_eq!(3, get_string_calculator().add("1,2"));
    }
}
