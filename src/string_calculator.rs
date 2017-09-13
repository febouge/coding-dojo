
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
            result = 1000;
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
        assert_eq!(3, get_string_calculator().add("1, 2"));
    }
}
