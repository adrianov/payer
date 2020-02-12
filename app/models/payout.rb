# Запрос на выплату
class Payout < ApplicationRecord
  before_validation(on: :create) do
    self.dt = DateTime.now unless attribute_present?(:dt)

    # направление выплаты: банковская карта
    self.destination = 1 unless attribute_present?(:destination)
  end
end
