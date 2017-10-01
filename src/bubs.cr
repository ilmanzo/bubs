require "option_parser"
require "./bubs/*"

module Bubs
  # Convert words to ⓌⓄⓇⒹⓈ.
  #
  # Returns a String, but a much cooler string than what you had initially.

  UPCASE          = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  LOWCASE         = "abcdefghijklmnopqrstuvwxyz"
  NUMBERS         = "0123456789"
  CIRCLED_LOWER   = "ⓐⓑⓒⓓⓔⓕⓖⓗⓘⓙⓚⓛⓜⓝⓞⓟⓠⓡⓢⓣⓤⓥⓦⓧⓨⓩ"
  CIRCLED_UPPER   = "ⒶⒷⒸⒹⒺⒻⒼⒽⒾⒿⓀⓁⓂⓃⓄⓅⓆⓇⓈⓉⓊⓋⓌⓍⓎⓏ"
  CIRCLED_NUMBERS = "⓪①②③④⑤⑥⑦⑧⑨"
  SQUARED_LIGHT   = "🄰🄱🄲🄳🄴🄵🄶🄷🄸🄹🄺🄻🄼🄽🄾🄿🅀🅁🅂🅃🅄🅅🅆🅇🅈🅉"
  SQUARED_DARK    = "🅰🅱🅲🅳🅴🅵🅶🅷🅸🅹🅺🅻🅼🅽🅾🅿🆀🆁🆂🆃🆄🆅🆆🆇🆈🆉"

  enum Conversion
    Circled
    SquaredLight
    SquaredDark
  end

  def self.convert(text : String, conversion : Conversion)
    case conversion
    when Conversion::Circled
      text.tr(UPCASE + LOWCASE + NUMBERS, CIRCLED_UPPER + CIRCLED_LOWER + CIRCLED_NUMBERS)
    when Conversion::SquaredLight
      text.upcase.tr(UPCASE, SQUARED_LIGHT)
    when Conversion::SquaredDark
      text.upcase.tr(UPCASE, SQUARED_DARK)
    else
      puts "Error: unknown conversion"
    end
  end
end

conversion = Bubs::Conversion::Circled

OptionParser.parse! do |parser|
  parser.banner = "Usage: bubs message [-v] [-c 1|2|3]"
  parser.on("-h", "--help", "Show this help") do
    puts parser
    exit 0
  end

  parser.on("-v", "--version", "Show program version") do
    puts Bubs::VERSION
    exit 0
  end

  parser.on("-t TYPE", "--type TYPE", "Change bubbles type (circled,squared1,squared2)") do |t|
    case t
    when "circled"
      conversion = Bubs::Conversion::Circled
    when "squared1"
      conversion = Bubs::Conversion::SquaredLight
    when "squared2"
      conversion = Bubs::Conversion::SquaredDark
    else
      conversion = Bubs::Conversion::Circled
    end
  end
end

args = ARGV.join(' ')
text = Bubs.convert(args, conversion)
puts text
