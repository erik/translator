# Translator
This is a silly little program which takes any number of phrases on the command line, and obliterates the meaning by translating
them through a ton of languages, courtesy of Google's Translate API.

For example, "translation machine" becomes "each car", "the weather is nice" becomes "air", and so on.

Some languages don't play nice with each other, and will end up failing, or translating phonetically,
which is annoying, but shouldn't really happen too much.

The only dependency to run is the JSON gem (`gem install json`). After that, just run `bin/translator`