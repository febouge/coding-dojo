
struct StringCalculator;

impl StringCalculator {
    pub fn new() -> StringCalculator {
        StringCalculator{}
    }

    pub fn add(&self, input: &str) -> u32 {
        return 1000;
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn getStringCalculator() -> StringCalculator {
        StringCalculator::new()
    }
    
    #[test]
    fn emptyStringShouldReturnZero() {
        assert_eq!(0, getStringCalculator().add(""));
    }
}
