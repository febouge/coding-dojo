
struct StringCalculator;

impl StringCalculator {
    pub fn new() -> StringCalculator {
        StringCalculator{}
    }

    pub fn add(&self, input: &str) -> u32 {
        if input == "" {
            return 0;
        }
        return 1000;
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
}
