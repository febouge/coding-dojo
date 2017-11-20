use movement::Movement;
use game_result::GameResult;

pub struct RockPaperScissorsLizardSpock {}

impl RockPaperScissorsLizardSpock {

    pub fn new() -> RockPaperScissorsLizardSpock {
        RockPaperScissorsLizardSpock{}
    }

    pub fn play(&self, player_one_movement: Movement, player_two_movement: Movement) -> GameResult{
        player_one_movement.compute_result(&player_two_movement)
    }
}


#[cfg(test)]
mod test {
    use super::*;
    fn get_game() -> RockPaperScissorsLizardSpock {
        RockPaperScissorsLizardSpock::new()
    }

    #[test]
    fn draw_game_test() {
        let game = get_game();
        assert_eq!(GameResult::DRAW, game.play(Movement::ROCK, Movement::ROCK));
        assert_eq!(GameResult::DRAW, game.play(Movement::PAPER, Movement::PAPER));
        assert_eq!(GameResult::DRAW, game.play(Movement::SCISSORS, Movement::SCISSORS));
        assert_eq!(GameResult::DRAW, game.play(Movement::LIZARD, Movement::LIZARD));
        assert_eq!(GameResult::DRAW, game.play(Movement::SPOCK, Movement::SPOCK));
    }

    #[test]
    fn rock_test() {
        let game = get_game();
        assert_eq!(GameResult::PlayerOneWins, game.play(Movement::ROCK, Movement::SCISSORS));
        assert_eq!(GameResult::PlayerOneWins, game.play(Movement::ROCK, Movement::LIZARD));
        assert_eq!(GameResult::PlayerTwoWins, game.play(Movement::ROCK, Movement::PAPER));
        assert_eq!(GameResult::PlayerTwoWins, game.play(Movement::ROCK, Movement::SPOCK));
    }

    #[test]
    fn paper_test() {
        let game = get_game();
        assert_eq!(GameResult::PlayerOneWins, game.play(Movement::PAPER, Movement::ROCK));
        assert_eq!(GameResult::PlayerOneWins, game.play(Movement::PAPER, Movement::SPOCK));
        assert_eq!(GameResult::PlayerTwoWins, game.play(Movement::PAPER, Movement::SCISSORS));
        assert_eq!(GameResult::PlayerTwoWins, game.play(Movement::PAPER, Movement::LIZARD));
    }

    #[test]
    fn scissors_test() {
        let game = get_game();
        assert_eq!(GameResult::PlayerOneWins, game.play(Movement::SCISSORS, Movement::PAPER));
        assert_eq!(GameResult::PlayerOneWins, game.play(Movement::SCISSORS, Movement::LIZARD));
        assert_eq!(GameResult::PlayerTwoWins, game.play(Movement::SCISSORS, Movement::ROCK));
        assert_eq!(GameResult::PlayerTwoWins, game.play(Movement::SCISSORS, Movement::SPOCK));
    }

    #[test]
    fn lizard_test() {
        let game = get_game();
        assert_eq!(GameResult::PlayerOneWins, game.play(Movement::LIZARD, Movement::SPOCK));
        assert_eq!(GameResult::PlayerOneWins, game.play(Movement::LIZARD, Movement::PAPER));
        assert_eq!(GameResult::PlayerTwoWins, game.play(Movement::LIZARD, Movement::ROCK));
        assert_eq!(GameResult::PlayerTwoWins, game.play(Movement::LIZARD, Movement::SCISSORS));
    }

    #[test]
    fn spock_test() {
        let game = get_game();
        assert_eq!(GameResult::PlayerOneWins, game.play(Movement::SPOCK, Movement::ROCK));
        assert_eq!(GameResult::PlayerOneWins, game.play(Movement::SPOCK, Movement::SCISSORS));
        assert_eq!(GameResult::PlayerTwoWins, game.play(Movement::SPOCK, Movement::LIZARD));
        assert_eq!(GameResult::PlayerTwoWins, game.play(Movement::SPOCK, Movement::PAPER));
    }
}