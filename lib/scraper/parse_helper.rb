class ParseHelper
  # Unfortunately the date string in the html does not contain year information.
  # So we'll try to do some contextual deducting whether the given date
  # actually refers this year or the previous one.
  def self.parse_date(date_string)
    d = Date::strptime(/\d{1,2}\.\d{1,2}\./.match(date_string).to_s + Time.now.year.to_s, '%d.%m.%Y')

    # If it's December and the date seems to be in January it's probably referring the next years January
    if d.month == 1 && Time.now.month == 12
      return d.next_year
      # However if it's January and the date is in December it is very likely to refer last year
    elsif d.month == 12 && Time.now.month == 1
      return d.prev_year
      # Otherwise we assume the date actually refers the current calendar year
    else
      return d
    end
  end

  def self.cleanse(s)
    s = strip_junk(s)
    s = beautify_allergies(s)
    beautify_prices(s)
  end

  private

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
end
