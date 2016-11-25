require 'yaml'
require_relative 'locale_yaml_handler'
require_relative 'translator'
require_relative 'en_translator'
require_relative 'ru_translator'

class Wordify
  attr_reader :num, :lang

  def self.run(num, lang)
    num = num.to_i
    lang = lang.to_sym
    unless langs.include?(lang)
      fail "Language #{lang} is not implemented. Possible languages: #{langs}"
    end

    obj = self.new(num, lang)
    obj.run
  end

  def initialize(num, lang)
    @num = num
    @lang = lang
  end

  def run
    applicable_translator.run
  end

  private

  def self.langs
    translators_list.map(&:lang_key)
  end

  def self.translators_list
    [EnTranslator, RuTranslator]
  end

  def applicable_translator_class
    list = self.class.translators_list
    list.detect { |i| i.lang_key == lang }
  end

  def applicable_translator
    applicable_translator_class.new(num)
  end
end