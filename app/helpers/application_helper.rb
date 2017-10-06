module ApplicationHelper
  def any_card?(card)
    card.instance_of?(Card)
  end
end
