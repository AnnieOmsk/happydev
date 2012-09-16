# encoding: utf-8

class AddHundredPercentPromocode < ActiveRecord::Migration
  def up
    Promocode.create(:name => 'Partners', :discount_value => -100, :number => "UJ5j54f1knV7t9m26Maw714P308CTI")
    Promocode.create(:name => 'VIP', :discount_value => -100, :number => "O85oID4rLA6S2Q131FV0d37uB995hs")
  end
end
