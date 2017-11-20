mod rock_paper_scissors_lizard_spock;
mod movement;
mod game_result;

use rock_paper_scissors_lizard_spock::RockPaperScissorsLizardSpock;
use movement::Movement;

fn main() {
    let game = RockPaperScissorsLizardSpock::new();
    println!("{:?}", game.play(Movement::ROCK, Movement::PAPER));
}
