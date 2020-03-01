module TimeDate

  def todays_date_ddmmyy
    now = Time.now.to_a
    day = now[3].to_s
    if now[4].to_s.size < 2
      month = "0" + now[4].to_s
    else
      month = now[4].to_s
    end
    year_end = now[5].to_s[2..3]

    (day + month + year_end).to_i
  end
end
