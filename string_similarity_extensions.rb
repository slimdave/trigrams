# frozen_string_literal: true

module StringSimilarityExtensions
  refine String do
    def trigrams
      case size
      when 0
      then []
      when 1
      then ["  #{self}", " #{self} "]
      when 2
      then ["  #{self.first}", " #{self.first(2)}", "#{self.last(2)} "]
      else
        ["  #{self.first}", " #{self.first(2)}", "#{self.last(2)} "] + chars.each_cons(3).map(&:join)
      end
    end

    def similarity(other, case_insensitive = false)
      if case_insensitive
        self_trigrams  = downcase.trigrams
        other_trigrams = other.downcase.trigrams
      else
        self_trigrams  = trigrams
        other_trigrams = other.trigrams
      end
      (self_trigrams & other_trigrams).size / (self_trigrams | other_trigrams).size.to_f
    end
  end
end
