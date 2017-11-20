use std::vec::Vec;
use game_result::GameResult;

#[derive(PartialEq)]
pub enum Movement {
    ROCK,
    PAPER,
    SCISSORS,
    LIZARD,
    SPOCK
}

impl Movement {
    fn get_opponent_movements_to_win(&self) -> Vec<Movement> {
        match *self {
            Movement::ROCK => vec![Movement::SCISSORS, Movement::LIZARD],
            Movement::PAPER => vec![Movement::SPOCK, Movement::ROCK],
            Movement::SCISSORS => vec![Movement::LIZARD, Movement::PAPER],
            Movement::LIZARD => vec![Movement::PAPER, Movement::SPOCK],
            Movement::SPOCK => vec![Movement::ROCK, Movement::SCISSORS]
        }
    }

    pub fn compute_result(&self, opponent_movement: &Movement) -> GameResult {
        if self == opponent_movement {
            return GameResult::DRAW;
        }
        if self.get_opponent_movements_to_win().contains(opponent_movement) {
            return GameResult::PlayerOneWins;
        }
        return GameResult::PlayerTwoWins;
    }
}