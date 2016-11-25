class RuTranslator < Translator
  THOUSAND_WORDS = {"1" => 'тысяча', "234" => 'тысячи', '1020' => "тысяч"}
  MILLIONS_WORDS = {"1" => 'миллион', "234" => 'миллиона', '1020' => "миллионов"}

  def self.lang_key
    :ru
  end

  private

  def hundred_word_for_number(n)
    locale_hash[n*100]
  end

  def thousand_exceptions(res)
    res.gsub('один тысяч', 'одна тысяч').gsub('два тысяч', 'две тысяч')
  end

  def thousand_word(n)
    unit_words(n, THOUSAND_WORDS)
  end

  def million_word(n)
    unit_words(n, MILLIONS_WORDS)
  end

  def unit_words(n, words_hash)
    return words_hash['1020'] if 10 < n && n < 20
    return words_hash['1'] if n % 10 == 1
    return words_hash['234'] if [2, 3, 4].include?(n % 10)
    words_hash['1020']
  end
end
