module Translator

  def self.around_the_world (text, params)

    start_lang = Translator::language_codes[params[:start].to_s] || params[:start]
    lang_codes = Translator::language_codes.values.shuffle

    verbose = params[:verbose]
    steps = params[:steps] || lang_codes.size

    ctr = -1
    from_lang = start_lang
    to_lang = lang_codes[0]

    while ctr < lang_codes.size - 1 and ctr < steps - 1

      unless self.clashes?(from_lang, to_lang)

        print "#{from_lang} -> #{to_lang} (#{text} -> " if verbose
        text = self.translate(text, :from => from_lang, :to => to_lang)
        puts "#{text})" if verbose

      end

      ctr += 1
      from_lang = lang_codes[ctr]
      to_lang = lang_codes[ctr + 1]

    end

    self.translate(text, :from => lang_codes[ctr], :to => start_lang)
  end

  private

  def self.clashes? (lang1, lang2)

    Translator.language_clashes.each {|pair|

      if pair[0] == lang1 and pair[1] == lang2
        return true

      elsif pair[0]  == lang2 and pair[1] == lang1
        return true

      end
    }

    false
  end

end
