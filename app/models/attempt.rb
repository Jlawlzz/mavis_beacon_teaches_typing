class Attempt < ActiveRecord::Base
  belongs_to :level
  validates :text, presence: true

  def percent_correct
    raw_compare = compare(order_by_length)
    calculate_percentage(raw_compare)
  end

  def order_by_length
    [text, level.text].sort_by { |text| text.length }
  end

  def compare(texts)
    chars = zipped_texts(texts).select do |a,b|
       a == b
    end
    chars
  end

  def zipped_texts(texts)
    texts[1].each_char.zip(texts[0].each_char)
  end

  def calculate_percentage(raw_compare)
    ((raw_compare.size.to_f / level.text.length.to_f) * 100).to_i
  end
end
