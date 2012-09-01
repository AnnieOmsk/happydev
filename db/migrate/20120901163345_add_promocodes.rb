#encoding: utf-8

class AddPromocodes < ActiveRecord::Migration
  def up
    Promocode.create(:name => 'AgileRussia', :discount_value => -10, :number => "weth2vych1kuja0wha5who1mo3thyb")
    Promocode.create(:name => 'old48', :discount_value => -10, :number => "chy7que1jish2shyl7ruqu0zaph3to")
    Promocode.create(:name => 'GDG', :discount_value => -10, :number => "rha1ja3spe4ce1zefi4du4tich7laz")
    Promocode.create(:name => 'FOR_FRIEND', :discount_value => -10, :number => "ke9qua6fe3ge1kiqu6se5cysp7rtyg")
    Promocode.create(:name => 'FROM_FRIEND', :discount_value => +50, :number => "puqu8phe2choh8ghy1rte8quo7shyr")
  end
end
