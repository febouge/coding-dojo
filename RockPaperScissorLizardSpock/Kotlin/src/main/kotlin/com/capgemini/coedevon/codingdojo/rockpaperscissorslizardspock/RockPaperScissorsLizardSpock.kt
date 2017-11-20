package com.capgemini.coedevon.codingdojo.rockpaperscissorslizardspock

/**
 * Rock Paper Scissors Lizard Spock game.
 *
 * Main game class.
 */
class RockPaperScissorsLizardSpock {
    /**
     *
     */
    fun play(playerOneMovement: Movement, playerTwoMovement: Movement): GameResult {

        return playerOneMovement.calculateResult(playerTwoMovement)
    }
}