
module Translator

  @@language_codes = {
    "english" => "en",
    "afrikaans" => "af",
    "albanian" => "sq",
    "arabic" => "ar",
    "belarusian" => "be",
    "bulgarian" => "bg",
    "catalan" => "ca",
    "chinese" => "zh-CN",
    "croatian" => "hr",
    "czech" => "cs",
    "danish" => "da",
    "dutch" => "nl",
    "estonian" => "et",
    "filipino" => "tl",
    "finnish" => "fi",
    "french" => "fr",
    "galician" => "gl",
    "german" => "de",
    "greek" => "el",
    "creole" => "ht",
    "hebrew" => "iw",
    "hindi" => "hi",
    "hungarian" => "hu",
    "icelandic" => "is",
    "indonesian" => "id",
    "irish" => "ga",
    "italian" => "it",
    "japanese" => "ja",
    "korean" => "ko",
    "latvian" => "lv",
    "lithuanian" => "lt",
    "macedonian" => "mk",
    "malay" => "ms",
    "maltese" => "mt",
    "norwegian" => "no",
    "persian" => "fa",
    "polish" => "pl",
    "portuguese" => "pt",
    "romanian" => "ro",
    "russian" => "ru",
    "serbian" => "sr",
    "slovak" => "sk",
    "slovenian" => "sl",
    "spanish" => "es",
    "swahili" => "sw",
    "swedish" => "sv",
    "thai" => "th",
    "turkish" => "tr",
    "ukrainian" => "uk",
    "vietnamese" => "vi",
    "welsh" => "cy",
    "yiddish" => "yi",
  }

  # languages that cannot be translated
  @@language_clashes = [["da", "eu"],["eu", "az"], ["fi", "pt"]]

  @@base = URI.parse("http://ajax.googleapis.com/ajax/services/language/translate")

  def self.get_language_code_for (language)
    @@language_codes[language]
  end

  def self.language_codes
    @@language_codes
  end

  def self.language_clashes
    @@language_clashes
  end

  # params:
  # :from => lang
    # :to => lang
  def self.translate(text, params)
    from = params[:from]
    to = params[:to]

    unless from and to
      raise Exception, "missing required parameter: #{ from.nil? ? "from" : "to" }"
      end

    json = get text, from, to
    parse json
  end

  private

  def self.get (text, from_lang, to_lang)
    returned = Net::HTTP.post_form(@@base, { "v" => "1.0", "q" => text, "langpair" => "#{from_lang}|#{to_lang}" })
    returned.body
    end

  def self.parse(json)
    hash = JSON.parse(json)
    unless hash["responseData"]
      raise TranslationException.new, "error on translation: #{ hash["responseDetails"] } (status #{ hash["responseStatus"] })"
      end

    hash["responseData"]["translatedText"]
  end

end
