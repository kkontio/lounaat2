# encoding: UTF-8
class Date
  def wday_fi
    weekdays = %w(maanantai tiistai keskiviikko torstai perjantai lauantai sunnuntai)
    weekdays[self.wday - 1]
  end

  def month_fi
    months = %w(tammikuu helmikuu maaliskuu huhtikuu toukokuu kesäkuu heinäkuu elokuu syyskuu lokakuu marraskuu joulukuu)
    months[self.month - 1]
  end
end