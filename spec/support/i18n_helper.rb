# wrappers for I18n.translate() for lazy guys
module I18nHelper
  def t(key, options = {})
    I18n.translate(key, options)
  end

  def submit_create
    "helpers.submit.create"
  end

  def model_deck_ru
    "activerecord.models.deck.one"
  end

  def model_card_ru
    "activerecord.models.deck.one"
  end

end

RSpec.configure do |c|
  c.include I18nHelper
end
