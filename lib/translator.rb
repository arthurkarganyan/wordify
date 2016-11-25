class Translator
  NUMBER_LIMIT = 1_000_000_000

  attr_reader :num

  def initialize(num)
    @num = num
  end

  def try_run
    fail("Integer numbers only accepted") unless num.is_a?(Fixnum)
    fail(out_range_num_msg) if out_range_num_msg?

    run
  end

  def run
    "#{sign} #{millions} #{thousands} #{under_thousands}".strip.gsub(/\s+/, " ")
  end

  def self.lang_key
    fail NotImplementedError
  end

  protected

  def lang_key
    self.class.lang_key
  end

  def num_abs
    num.abs
  end

  def minus_word
    locale_hash["minus"]
  end

  def sign
    num < 0 ? "#{minus_word} " : ""
  end

  def locale_hash
    @locale_hash ||= locale_yaml_handler.locale_hash
  end

  def locale_yaml_handler
    @locale_yaml_handler ||= LocaleYamlHandler.new(lang_key)
  end

  def millions
    n = (num_abs / 1000000) % 1000
    return "" if n == 0
    "#{under_thousands(n)} #{million_word(n)}"
  end

  def thousands
    n = (num_abs / 1000) % 1000
    return "" if n == 0
    res = "#{under_thousands(n)} #{thousand_word(n)}"
    thousand_exceptions(res)
  end

  def thousand_exceptions(res)
    # without exceptions
    res
  end

  def under_thousands(num_arg = num_abs)
    "#{hundreds(num_arg)} #{under_hundreds(num_arg)}"
  end

  def under_hundreds(num_arg = num_abs)
    n = num_arg % 100
    return "" if n == 0 && num != 0
    return locale_hash[n] if locale_hash[n]
    on_bit = n % 10
    decimal = n / 10

    return locale_hash[on_bit] if decimal == 0
    "#{locale_hash[decimal*10]}#{under_hundreds_delimiter}#{locale_hash[on_bit]}"
  end

  def under_hundreds_delimiter
    ' '
  end

  def hundreds(num_arg = num_abs)
    n = (num_arg % 1000) / 100
    return "" if n == 0
    hundred_word_for_number(n)
  end

  def thousand_word(n)
    fail NotImplementedError
  end

  def million_word(n)
    fail NotImplementedError
  end

  def out_range_num_msg?
    num.abs >= NUMBER_LIMIT
  end

  def out_range_num_msg
    "Number #{num} is out of permitted range -#{NUMBER_LIMIT}...#{NUMBER_LIMIT}"
  end
end