# Запрос на выплату
class Payout < ApplicationRecord
  before_validation(on: :create) do
    self.dt = DateTime.now unless attribute_present?(:dt)

    # направление выплаты: банковская карта
    self.destination = 1 unless attribute_present?(:destination)
  end

  validates :amount, numericality: { greater_than: 0 }, format: { with: /\A\d+(?:\.\d{2})?\z/ },  presence: true
  validates :phone, length: 10..12, presence: true

  # номер банковской карты
  validates :client, length: 16..20, presence: true

  validates :receiver_fio, presence: true
end
