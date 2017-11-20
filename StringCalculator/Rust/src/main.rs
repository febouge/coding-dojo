
mod string_calculator;

use string_calculator::StringCalculator;

fn main() {
    let string_calculator = StringCalculator::new();
    println!("{:?}", string_calculator.add("1,2,3"));
}
