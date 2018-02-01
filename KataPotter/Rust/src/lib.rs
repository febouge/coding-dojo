use std::collections::HashMap;

#[derive(Debug, PartialEq, Hash, Clone, Copy)]
pub enum Book {
    ONE,
    TWO,
    THREE,
    FOUR,
    FIVE,
    SIX,
    SEVEN
}

pub fn checkout(books: Vec<Book>) -> f32 {
    if books.is_empty() {
        return 0.0;
    }
    let book_sets = get_different_book_sets(books);
    get_all_booksets_price(book_sets)
}

fn get_different_book_sets(books: Vec<Book>) -> Vec<Vec<Book>> {
    let mut different_sets: Vec<Vec<Book>> = vec![vec![]];
    for book in &books {
        let mut book_needs_to_be_added_in_new_set = true;            
        for set in &mut different_sets {
            if !set.contains(book){
                    set.push(*book);
                book_needs_to_be_added_in_new_set = false;
                break;
            }
        }
        if book_needs_to_be_added_in_new_set {
            different_sets.push(vec![*book]);
        }
    }
    return different_sets;
}

fn get_all_booksets_price(book_sets: Vec<Vec<Book>>) -> f32 {
    book_sets.into_iter().fold(0.0, |acc, different_set| acc + get_price(different_set))
}

fn get_price(book_set: Vec<Book>) -> f32{
    let number_of_books = book_set.len();
    number_of_books as f32 * 8.0 * get_discounts().get(&(number_of_books as u32)).unwrap()
}

fn get_discounts() -> HashMap<u32, f32> {
    let mut discounts: HashMap<u32, f32> = HashMap::new();
    discounts.insert(0, 0.0);
    discounts.insert(1, 1.0);
    discounts.insert(2, 0.95);
    discounts.insert(3, 0.90);
    discounts.insert(4, 0.85);
    discounts.insert(5, 0.80);
    discounts.insert(6, 0.70);
    discounts.insert(7, 0.55);
    return discounts;
}

#[cfg(test)]
mod test;
