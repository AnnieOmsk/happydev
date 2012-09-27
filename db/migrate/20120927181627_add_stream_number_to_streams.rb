# encoding: utf-8
class AddStreamNumberToStreams < ActiveRecord::Migration
  def change
    Stream.create(:number => '12151437',
                  :section_id => Section.find_by_name('Стартапы').id,
                  :frame_width => 480,
                  :frame_height => 296)
    Stream.create(:number => '12151409',
                  :section_id => Section.find_by_name('Продуктовая разработка').id,
                  :frame_width => 480,
                  :frame_height => 296)
    Stream.create(:number => '12151427',
                  :section_id => Section.find_by_name('Фабрика проектов').id,
                  :frame_width => 480,
                  :frame_height => 296)
  end
end
