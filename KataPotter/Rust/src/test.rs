use super::*;
    
#[test]
fn zero_books_return_zero() {
    assert_correct_price(0.0, vec![]);
}

#[test]
fn one_book_returns_eigth() {
    assert_correct_price(8.0, vec![Book::ONE]);
}

#[test]
fn two_books_return_price_with_two_books_discount() {
    assert_correct_price(8.0 * 2.0 * 0.95, vec![Book::ONE, Book::TWO])
}

#[test]
fn three_books_return_price_with_three_books_discount() {
    assert_correct_price(8.0 * 3.0 * 0.90, vec![Book::ONE, Book::TWO, Book::THREE])
}

#[test]
fn four_books_return_price_with_four_books_discount() {
    assert_correct_price(8.0 * 4.0 * 0.85, vec![Book::ONE, Book::TWO, Book::THREE, Book::FOUR])
}

#[test]
fn five_books_return_price_with_five_books_discount() {
    assert_correct_price(8.0 * 5.0 * 0.80, vec![Book::ONE, Book::TWO, Book::THREE, Book::FOUR, Book::FIVE])
}

#[test]
fn six_books_return_price_with_six_books_discount() {
    assert_correct_price(8.0 * 6.0 * 0.70, vec![Book::ONE, Book::TWO, Book::THREE, Book::FOUR, Book::FIVE, Book::SIX])
}

#[test]
fn seven_books_return_price_with_seven_books_discount() {
    assert_correct_price(8.0 * 7.0 * 0.55, vec![Book::ONE, Book::TWO, Book::THREE, Book::FOUR, Book::FIVE, Book::SIX, Book::SEVEN])
}

#[test]
fn two_equals_books_return_price_without_discount() {
    assert_correct_price(8.0 * 2.0, vec![Book::ONE, Book::ONE])
}

#[test]
fn two_equals_books_and_one_different_returns_correct_price() {
    assert_correct_price(8.0 + 8.0 * 2.0 * 0.95, vec![Book::ONE, Book::ONE, Book::TWO])
}

#[test]
fn multiple_books_returns_correct_price() {
    assert_correct_price(8.0 * 2.0 * 0.95 + 8.0 * 3.0 * 0.90, vec![Book::ONE, Book::ONE, Book::TWO, Book::THREE, Book::TWO])
}

fn assert_correct_price(expected_price: f32, books: Vec<Book>) {
    assert_eq!(expected_price, checkout(books))
}
