class PigLatinizer

  def piglatinize(user_phrase)
    @new_word = user_phrase.split("")
    vowels = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
    if vowels.include?(@new_word[0])
      latinized_word = begins_with_vowel.join("")
    else
      latinized_word = begins_with_consonant.join("")
    end
    latinized_word
  end

  def to_pig_latin(sentence)
    words_in_sentence = sentence.split(" ")

    pig_latinized_words = words_in_sentence.collect do |word|
      self.piglatinize(word)
    end

    new_sentence = pig_latinized_words.join(" ")
  end

  def begins_with_vowel
    vowel_word = @new_word << "way"
  end

  def begins_with_consonant
    if @new_word[0] == "q" && @new_word[1] == "u"
      qu = @new_word[0, 2].join("")
      spliced_word = @new_word[2..-1]
      spliced_word << qa + "ay"
    elsif @new_word[0] == "p" && @new_word[1] =="l"
      pl = @new_word[0, 2].join("")
      spliced_word = @new_word[2..-1]
      spliced_word << pl + "ay"
    elsif @new_word[0] == "t" && @new_word[1] =="h"
      th = @new_word[0, 2].join("")
      spliced_word = @new_word[2..-1]
      spliced_word << th + "ay"
    elsif @new_word[0] == "s" && @new_word[1] =="p" && @new_word[2] == "r"
      spr = @new_word[0, 3].join("")
      spliced_word = @new_word[3..-1]
      spliced_word << spr + "ay"
    elsif @new_word[0] == "p" && @new_word[1] =="r"
      pr = @new_word[0, 2].join("")
      spliced_word = @new_word[2..-1]
      spliced_word << pr + "ay"
    elsif @new_word[0] == "w" && @new_word[1] =="h"
      wh = @new_word[0, 2].join("")
      spliced_word = @new_word[2..-1]
      spliced_word << wh + "ay"
    elsif @new_word[0] == "s" && @new_word[1] =="k"
      sk = @new_word[0, 2].join("")
      spliced_word = @new_word[2..-1]
      spliced_word << sk + "ay"
    elsif (@new_word[0] == "s" || @new_word[0] == "S") && @new_word[1] =="t" && @new_word[2] == "r"
      str = @new_word[0, 3].join("")
      spliced_word = @new_word[3..-1]
      spliced_word << str + "ay"
    else
      first_letter = @new_word[0]
      spliced_word = @new_word[1..-1]
      spliced_word << first_letter + "ay"
    end
  end

end
