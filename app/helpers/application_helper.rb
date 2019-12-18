module ApplicationHelper
  def number_to_currency_id(number)
    number_to_currency(number, :unit => "Rp ", :separator => ",", :delimiter => ".")
  end

  def any_user_signed_in?
    user_signed_in? || stock_signed_in? || team_signed_in?
  end
end
