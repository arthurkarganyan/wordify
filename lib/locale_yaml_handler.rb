class LocaleYamlHandler
  attr_reader :lang

  def initialize(lang)
    @lang = lang
  end

  def locale_yaml_path
    ROOT + "/locales/#{lang}.yaml"
  end

  def locale_hash
    @locale_hash ||= YAML.load_file(locale_yaml_path)[lang.to_s]
  end
end