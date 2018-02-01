# -*- coding: utf-8 -*-
import unittest

from gilded_rose import Item, GildedRose


class GildedRoseTest(unittest.TestCase):
    def test_regular_item_quality_degradation(self):
        regular_item = Item("foo", 11, 31)
        self.assert_item_is_correct(regular_item, 10, 30)

    def test_quality_is_never_negative(self):
        regular_item = Item("foo", 10, 0)
        self.assert_item_is_correct(regular_item, 9, 0)

    def test_quality_degrades_two_after_sell_in(self):
        regular_item = Item("foo", 0, 10)
        self.assert_item_is_correct(regular_item, -1, 8)

    def test_aged_brie_increases_quality(self):
        aged_brie = Item("Aged Brie", 10, 2)
        self.assert_item_is_correct(aged_brie, 9, 3)

    def test_aged_brie_increases_quality_twice_after_sell_in(self):
        aged_brie = Item("Aged Brie", 0, 2)
        self.assert_item_is_correct(aged_brie, -1, 4)

    def test_quality_never_is_greater_than_50(self):
        aged_brie = Item("Aged Brie", 10, 50)
        self.assert_item_is_correct(aged_brie, 9, 50)

    def test_sulfuras_remains_equal(self):
        sulfuras = Item("Sulfuras, Hand of Ragnaros", 10, 2)
        self.assert_item_is_correct(sulfuras, 10, 2)

    def test_backstage_quality_with_sell_in_greater_than_10(self):
        backstage = Item("Backstage passes to a TAFKAL80ETC concert", 30, 2)
        self.assert_item_is_correct(backstage, 29, 3)

    def test_backstage_quality_with_sell_in_between_10_and_5(self):
        backstage = Item("Backstage passes to a TAFKAL80ETC concert", 10, 2)
        self.assert_item_is_correct(backstage, 9, 4)

    def test_backstage_not_more_50_quality_with_sell_between_10_and_5(self):
        backstage = Item("Backstage passes to a TAFKAL80ETC concert", 10, 49)
        self.assert_item_is_correct(backstage, 9, 50)

    def test_backstage_quality_with_sell_under_6(self):
        backstage = Item("Backstage passes to a TAFKAL80ETC concert", 4, 2)
        self.assert_item_is_correct(backstage, 3, 5)

    def test_backstage_not_more_than_50_quality_with_sell_under_6(self):
        backstage = Item("Backstage passes to a TAFKAL80ETC concert", 5, 49)
        self.assert_item_is_correct(backstage, 4, 50)

    def test_backstage_quality_after_sell_in(self):
        backstage = Item("Backstage passes to a TAFKAL80ETC concert", 0, 30)
        self.assert_item_is_correct(backstage, -1, 0)

    def assert_item_is_correct(self, item, expected_sell_in, expected_quality):
        inventory = [item]
        gilded_rose = GildedRose(inventory)
        gilded_rose.update_quality()
        self.assertEqual(expected_quality, inventory[0].quality)
        self.assertEqual(expected_sell_in, inventory[0].sell_in)

    def test_conjured_item_quality_degradation(self):
        regular_item = Item("Conjured vegetable", 11, 31)
        self.assert_item_is_correct(regular_item, 10, 29)

    def test_conjured_item_quality_degradation_after_sell_in(self):
        regular_item = Item("Conjured vegetable", -1, 24)
        self.assert_item_is_correct(regular_item, -2, 20)


if __name__ == '__main__':
    unittest.main()
