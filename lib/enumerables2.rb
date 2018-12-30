require 'byebug'

# EASY

# Define a method that returns the sum of all the elements in its argument (an
# array of numbers).
def array_sum(arr)
  arr.reduce(0, &:+)
end

# Define a method that returns a boolean indicating whether substring is a
# substring of each string in the long_strings array.
# Hint: you may want a sub_tring? helper method
def in_all_strings?(long_strings, substring)
  long_strings.all? { |string| string.include?(substring)}
end

# Define a method that accepts a string of lower case words (no punctuation) and
# returns an array of letters that occur more than once, sorted alphabetically.
def non_unique_letters(string)
  stripped_str = string.split.sort.join
  seen = []
  str = stripped_str.chars.reduce("") do |acc,chr|
    if seen.include?(chr) && !acc.include?(chr)
      acc << chr
    else
      seen << chr
      acc
    end
  end
  str.chars
end

# Define a method that returns an array of the longest two words (in order) in
# the method's argument. Ignore punctuation!
def longest_two_words(string)
  sorted = string.split.sort {|a,b| a.length <=> b.length}
  sorted[-2, 2]
end

# MEDIUM

# Define a method that takes a string of lower-case letters and returns an array
# of all the letters that do not occur in the method's argument.
def missing_letters(string)
  ("a".."z").reject {|letter| string.include?(letter)}
end

# Define a method that accepts two years and returns an array of the years
# within that range (inclusive) that have no repeated digits. Hint: helper
# method?
def no_repeat_years(first_yr, last_yr)
  (first_yr..last_yr).select {|year| not_repeat_year?(year)}
end

def not_repeat_year?(year)
  digits = year.to_s.chars
  digits.none? {|digit| digits.count(digit) > 1}
end

# HARD

# Define a method that, given an array of songs at the top of the charts,
# returns the songs that only stayed on the chart for a week at a time. Each
# element corresponds to a song at the top of the charts for one particular
# week. Songs CAN reappear on the chart, but if they don't appear in consecutive
# weeks, they're "one-week wonders." Suggested strategy: find the songs that
# appear multiple times in a row and remove them. You may wish to write a helper
# method no_repeats?
def one_week_wonders(songs)
  songs.uniq.select {|song| no_repeats?(song, songs)}
end

def no_repeats?(song_name, songs)
  songs.each_with_index do |song, idx|
    if song == song_name && song == songs[idx + 1]
      return false
    end
  end
  return true
end

# Define a method that, given a string of words, returns the word that has the
# letter "c" closest to the end of it. If there's a tie, return the earlier
# word. Ignore punctuation. If there's no "c", return an empty string. You may
# wish to write the helper methods c_distance and remove_punctuation.

def for_cs_sake(string)
  #debugger
  words = remove_punctuation(string).split.select {|word| word.include?("C") || word.include?("c")}
  if words.length == 0
    return ""
  else
    sorted = words.sort{|a,b| c_distance(a) <=> c_distance(b) }
    return sorted[0]
  end
end


def c_distance(word)
  word.reverse.index("c")
end

def remove_punctuation(string)
  letters = [" "] + ("a".."z").to_a + ("A".."Z").to_a
  no_punc = string.chars.select {|char| letters.include?(char)}
  no_punc.join
end

# Define a method that, given an array of numbers, returns a nested array of
# two-element arrays that each contain the start and end indices of whenever a
# number appears multiple times in a row. repeated_number_ranges([1, 1, 2]) =>
# [[0, 1]] repeated_number_ranges([1, 2, 3, 3, 4, 4, 4]) => [[2, 3], [4, 6]]

def repeated_number_ranges(arr)
  repeated_num_ranges = []
  s_idx = nil

  arr.each_with_index do |num, idx|
    if num == arr[idx + 1]
      s_idx = idx unless s_idx
    elsif s_idx
      repeated_num_ranges << [s_idx, idx]
      s_idx = nil
    end
  end

  return repeated_num_ranges
end
