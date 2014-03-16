class Word < ActiveRecord::Base
  attr_accessible :name, :company_id

  validates :name, uniqueness: true, presence: true

  def find_related_words(current_co)
    return [] if self.definitions.empty?
    current_word_definitions = self.definitions
    all_tags = []
    related_words = []
    all_words = Word.where('company_id = ?', current_co.id).first(10)

    current_word_definitions.each do |definition|
      all_tags += definition.tags
    end

    all_words.each do |word|
      next if word == self
      word.definitions.each do |word_definition|
        if ((word_definition.tags & all_tags).count > 0) && !related_words.include?(word)
          related_words << word
          next
        end
      end
    end

    return related_words
  end

  def find_word_tags
    return [] if self.definitions.empty?
    current_word_definitions = self.definitions
    all_tags = Set.new

    current_word_definitions.each do |definition|
      definition.tags.each do |tag|
        all_tags.add(tag)
      end
    end

    all_tags
  end

  def self.recently_added(current_co, limit)
    Word.where('company_id = ?', current_co.id).order("words.created_at desc").first(limit)
  end

  has_many(
    :definitions,
    class_name: "Definition",
    foreign_key: :word_id,
    primary_key: :id,
    dependent: :destroy
  )

  belongs_to :company

  include PgSearch
  multisearchable against: :name
end
