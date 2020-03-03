module Timeable

  def todays_date_ddmmyy
    now = Time.now.to_a
    day = now[3].to_s
    day = "0" + day if day.size < 2
    month = now[4].to_s
    month = "0" + month if month.size < 2

    year_end = now[5].to_s[2..3]
    (day + month + year_end)
  end
end
