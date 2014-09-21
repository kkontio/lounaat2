# encoding: UTF-8

# Class with some utility methods to strip annoying junk from lunch item descriptions.
class LunchItemCleanser

  # Public: Cleanse given lunch description string.
  #
  # s - String to cleanse.
  #
  # Return the cleansed string.
  def self.cleanse(s)
    s = strip_junk(s)
    s = beautify_allergies(s)
    beautify_prices(s)
  end

  private

  # Private: Strip extra whitespace and leading dashes from the string given. Also capitalizes the string.
  #
  # s - String to strip junk from.
  #
  # Returns string with less junk.
  def self.strip_junk(s)
    s = s.gsub("\u00a0", ' ').strip
    s = s.gsub(/[[:space:]]+/, ' ').strip
    s = Unicode::downcase(s)

    while s[0] == '-'
      s[0] = ''
    end

    s[0] = Unicode::capitalize(s[0])

    return s
  end

  # Private: Try to normalize allergy acronym representation in lunch description string given.
  #
  # s - String to process.
  #
  # Returns string with nicer allergy acronyms.
  def self.beautify_allergies(s)
    if s.empty?
      return
    end

    partitions = s.partition(/\(\s*(vl|[lg])\s*((\/|,)\s*(vl|[lg]))*\s*\)/i)
    partitions[2] = beautify_allergies(partitions[2])

    unless partitions[1].empty?
      partitions[1] = partitions[1].gsub(/[[:space:]]/, '') + ' '
      partitions[1] = Unicode::upcase(partitions[1])
    end

    return partitions.join
  end

  # Private: Try to make prices look nicer in the lunch description string.
  #
  # s - String to process.
  #
  # Returns string with nicer price representation.
  def self.beautify_prices(s)
    if s.empty?
      return
    end

    partitions = s.partition(/\d{1,2},\d{1,2}\s*[e€]/i)
    partitions[2] = beautify_prices(partitions[2])

    unless partitions[1].empty?
      partitions[1] = partitions[1].gsub(/[[:space:]]/, '').gsub(/e/, '€') + ' '
    end

    return partitions.join
  end
end
