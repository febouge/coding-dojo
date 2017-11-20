package com.capgemini.coedevon.codingdojo.rockpaperscissorslizardspock


enum class Movement {

    ROCK {
        override fun getOtherPlayerMovementsToWin(): Array<Movement> = arrayOf(Movement.SCISSORS, Movement.LIZARD)
    },
    PAPER {
        override fun getOtherPlayerMovementsToWin(): Array<Movement> = arrayOf(Movement.SPOCK, Movement.ROCK)
    },
    SCISSORS {
        override fun getOtherPlayerMovementsToWin(): Array<Movement> = arrayOf(Movement.LIZARD, Movement.PAPER)
    },
    LIZARD {
        override fun getOtherPlayerMovementsToWin(): Array<Movement> = arrayOf(Movement.PAPER, Movement.SPOCK)
    },
    SPOCK {
        override fun getOtherPlayerMovementsToWin(): Array<Movement> = arrayOf(Movement.ROCK, Movement.SCISSORS)
    };

    abstract fun getOtherPlayerMovementsToWin(): Array<Movement>

    fun calculateResult(otherMovement: Movement): GameResult {
        if (this == otherMovement)
            return GameResult.DRAW

        if (getOtherPlayerMovementsToWin().contains(otherMovement))
            return GameResult.PLAYER_1_WINS

        return GameResult.PLAYER_2_WINS
    }
}
