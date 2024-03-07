module ApplicationHelper
  def format_date(date)
    date.strftime("%-d").to_i.ordinalize + ' ' + date.strftime("%b")
  end
end
