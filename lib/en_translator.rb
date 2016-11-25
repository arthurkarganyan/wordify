class EnTranslator < Translator
  def self.lang_key
    :en
  end

  def run
    "#{sign} #{millions} #{thousands} #{under_thousands}".strip.gsub(/\s+/, " ")
  end

  def under_hundreds_delimiter
    '-'
  end

  def hundred_word_for_number(n)
    "#{locale_hash[n]} hundred"
  end

  def million_word(n)
    "million"
  end

  def thousand_word(n)
    "thousand"
  end
end