class Word < ActiveRecord::Base
  attr_accessible :name

  validates :name, uniqueness: true, presence: true

  def find_related_words
    return [] if self.definitions.empty?
    current_word_definitions = self.definitions
    all_tags = []
    related_words = []
    all_words = Word.all

    current_word_definitions.each do |definition|
      all_tags += definition.tags
    end

    all_words.each do |word|
      next if word == self
      word.definitions.each do |word_definition|
        if (word_definition.tags & all_tags).count > 0
          related_words << word
          next
        end
      end
    end

    return related_words
  end

  has_many(
    :definitions,
    class_name: "Definition",
    foreign_key: :word_id,
    primary_key: :id,
    dependent: :destroy
  )
end
