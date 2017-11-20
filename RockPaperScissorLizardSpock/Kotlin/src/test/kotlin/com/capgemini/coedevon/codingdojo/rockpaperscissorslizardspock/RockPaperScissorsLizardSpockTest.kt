package com.capgemini.coedevon.codingdojo.rockpaperscissorslizardspock

import org.junit.Assert
import org.junit.Before
import org.junit.Test

class RockPaperScissorsLizardSpockTest {

    private lateinit var rockPaperScissorsLizardSpock: RockPaperScissorsLizardSpock

    @Before
    fun setup() {
        rockPaperScissorsLizardSpock = RockPaperScissorsLizardSpock()
    }

    @Test
    fun drawGameTest() {
        Assert.assertEquals("The rockPaperScissorsLizardSpock should be draw (0)", GameResult.DRAW, rockPaperScissorsLizardSpock.play(Movement.ROCK, Movement.ROCK))
        Assert.assertEquals("The rockPaperScissorsLizardSpock should be draw (0)", GameResult.DRAW, rockPaperScissorsLizardSpock.play(Movement.PAPER, Movement.PAPER))
        Assert.assertEquals("The rockPaperScissorsLizardSpock should be draw (0)", GameResult.DRAW, rockPaperScissorsLizardSpock.play(Movement.SCISSORS, Movement.SCISSORS))
        Assert.assertEquals("The rockPaperScissorsLizardSpock should be draw (0)", GameResult.DRAW, rockPaperScissorsLizardSpock.play(Movement.LIZARD, Movement.LIZARD))
        Assert.assertEquals("The rockPaperScissorsLizardSpock should be draw (0)", GameResult.DRAW, rockPaperScissorsLizardSpock.play(Movement.SPOCK, Movement.SPOCK))
    }

    @Test
    fun rockTest() {
        Assert.assertEquals("Player 1 should win (1)", GameResult.PLAYER_1_WINS, rockPaperScissorsLizardSpock.play(Movement.ROCK, Movement.SCISSORS))
        Assert.assertEquals("Player 1 should win (1)", GameResult.PLAYER_1_WINS, rockPaperScissorsLizardSpock.play(Movement.ROCK, Movement.LIZARD))
        Assert.assertEquals("Player 1 should lose (2)", GameResult.PLAYER_2_WINS, rockPaperScissorsLizardSpock.play(Movement.ROCK, Movement.PAPER))
        Assert.assertEquals("Player 1 should lose (2)", GameResult.PLAYER_2_WINS, rockPaperScissorsLizardSpock.play(Movement.ROCK, Movement.SPOCK))
    }

    @Test
    fun paperTest() {
        Assert.assertEquals("Player 1 should win (1)", GameResult.PLAYER_1_WINS, rockPaperScissorsLizardSpock.play(Movement.PAPER, Movement.ROCK))
        Assert.assertEquals("Player 1 should win (1)", GameResult.PLAYER_1_WINS, rockPaperScissorsLizardSpock.play(Movement.PAPER, Movement.SPOCK))
        Assert.assertEquals("Player 1 should lose (2)", GameResult.PLAYER_2_WINS, rockPaperScissorsLizardSpock.play(Movement.PAPER, Movement.SCISSORS))
        Assert.assertEquals("Player 1 should lose (2)", GameResult.PLAYER_2_WINS, rockPaperScissorsLizardSpock.play(Movement.PAPER, Movement.LIZARD))
    }

    @Test
    fun scissorsTest() {
        Assert.assertEquals("Player 1 should win (1)", GameResult.PLAYER_1_WINS, rockPaperScissorsLizardSpock.play(Movement.SCISSORS, Movement.PAPER))
        Assert.assertEquals("Player 1 should win (1)", GameResult.PLAYER_1_WINS, rockPaperScissorsLizardSpock.play(Movement.SCISSORS, Movement.LIZARD))
        Assert.assertEquals("Player 1 should lose (2)", GameResult.PLAYER_2_WINS, rockPaperScissorsLizardSpock.play(Movement.SCISSORS, Movement.ROCK))
        Assert.assertEquals("Player 1 should lose (2)", GameResult.PLAYER_2_WINS, rockPaperScissorsLizardSpock.play(Movement.SCISSORS, Movement.SPOCK))
    }

    @Test
    fun lizardTest() {
        Assert.assertEquals("Player 1 should win (1)", GameResult.PLAYER_1_WINS, rockPaperScissorsLizardSpock.play(Movement.LIZARD, Movement.SPOCK))
        Assert.assertEquals("Player 1 should win (1)", GameResult.PLAYER_1_WINS, rockPaperScissorsLizardSpock.play(Movement.LIZARD, Movement.PAPER))
        Assert.assertEquals("Player 1 should lose (2)", GameResult.PLAYER_2_WINS, rockPaperScissorsLizardSpock.play(Movement.LIZARD, Movement.ROCK))
        Assert.assertEquals("Player 1 should lose (2)", GameResult.PLAYER_2_WINS, rockPaperScissorsLizardSpock.play(Movement.LIZARD, Movement.SCISSORS))
    }

    @Test
    fun spockTest() {
        Assert.assertEquals("Player 1 should win (1)", GameResult.PLAYER_1_WINS, rockPaperScissorsLizardSpock.play(Movement.SPOCK, Movement.ROCK))
        Assert.assertEquals("Player 1 should win (1)", GameResult.PLAYER_1_WINS, rockPaperScissorsLizardSpock.play(Movement.SPOCK, Movement.SCISSORS))
        Assert.assertEquals("Player 1 should lose (2)", GameResult.PLAYER_2_WINS, rockPaperScissorsLizardSpock.play(Movement.SPOCK, Movement.LIZARD))
        Assert.assertEquals("Player 1 should lose (2)", GameResult.PLAYER_2_WINS, rockPaperScissorsLizardSpock.play(Movement.SPOCK, Movement.PAPER))
    }
}