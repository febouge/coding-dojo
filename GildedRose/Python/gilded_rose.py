# -*- coding: utf-8 -*-
class GildedRose(object):
    """Documentation for GildedRose

    """

    def __init__(self, items):
        super(GildedRose, self).__init__()
        self.items = items
        self.BACKSTAGE = "Backstage passes to a TAFKAL80ETC concert"
        self.SULFURAS = "Sulfuras, Hand of Ragnaros"
        self.AGED_BRIE = "Aged Brie"
        self.CONJURED = "Conjured"
        self.MAX_ITEM_QUALITY = 50
        self.MIN_ITEM_QUALITY = 0
        self.MIN_SELL_IN = 0
        self.REGULAR_QUALITY_DELTA = 1
        self.DOUBLE_QUALITY_DELTA = 2
        self.TRIPLE_QUALITY_DELTA = 3

    def update_quality(self):
        for item in self.items:
            self.perform_daily_quality_upgrade(item)
            self.decrease_sell_in(item)
            self.compute_extra_quality_based_on_sell_in(item)

    def decrease_quality(self, item, delta):
        if self.is_sulfuras(item):
            return
        new_quality = item.quality - delta
        if new_quality > self.MIN_ITEM_QUALITY:
            item.quality = new_quality
        else:
            item.quality = self.MIN_ITEM_QUALITY

    def decrease_sell_in(self, item):
        if self.is_sulfuras(item):
            return
        item.sell_in -= 1

    def increase_quality(self, item, delta):
        if self.is_sulfuras(item):
            return
        new_quality = item.quality + delta
        if new_quality < self.MAX_ITEM_QUALITY:
            item.quality = new_quality
        else:
            item.quality = self.MAX_ITEM_QUALITY

    def increase_special_items_quality(self, item):
        delta_to_apply = self.REGULAR_QUALITY_DELTA
        if item.name == self.BACKSTAGE:
            delta_to_apply = self.get_quality_delta_for_backstage(item)
        self.increase_quality(item, delta_to_apply)

    def get_quality_delta_for_backstage(self, item):
        if item.sell_in < 6:
            return self.TRIPLE_QUALITY_DELTA
        if item.sell_in < 11:
            return self.DOUBLE_QUALITY_DELTA
        return self.REGULAR_QUALITY_DELTA

    def perform_daily_quality_upgrade(self, item):
        if self.is_special_item(item):
            self.increase_special_items_quality(item)
            return

        self.decrease_item_quality_based_on_name(item)

    def decrease_item_quality_based_on_name(self, item):
        quality_delta = self.REGULAR_QUALITY_DELTA
        if self.is_conjured(item):
            quality_delta = quality_delta * 2
        self.decrease_quality(item, quality_delta)

    def compute_extra_quality_based_on_sell_in(self, item):
        if item.sell_in > self.MIN_SELL_IN:
            return

        if self.is_aged_brie(item):
            self.increase_quality(item, self.REGULAR_QUALITY_DELTA)
            return

        if self.is_backstage(item):
            item.quality = item.quality - item.quality
            return

        self.decrease_item_quality_based_on_name(item)

    def is_special_item(self, item):
        return self.is_aged_brie(item) or self.is_backstage(item)

    def is_aged_brie(self, item):
        return item.name == self.AGED_BRIE

    def is_backstage(self, item):
        return item.name == self.BACKSTAGE

    def is_sulfuras(self, item):
        return item.name == self.SULFURAS

    def is_conjured(self, item):
        return self.CONJURED in item.name


class Item:
    def __init__(self, name, sell_in, quality):
        self.name = name
        self.sell_in = sell_in
        self.quality = quality

    def __repr__(self):
        return "%s, %s, %s" % (self.name, self.sell_in, self.quality)
