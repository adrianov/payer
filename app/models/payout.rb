# Запрос на выплату
class Payout < ApplicationRecord
  before_validation(on: :create) do
    self.dt = DateTime.now unless attribute_present?(:dt)

    # направление выплаты: банковская карта
    self.destination = 1 unless attribute_present?(:destination)
  end

  strip_attributes

  validates :amount, numericality: { greater_than: 0 }, format: { with: /\A\d+(?:\.\d{0,2})?\z/ },  presence: true
  validates :phone, length: 10..12, presence: true

  # номер банковской карты
  validates :client, length: 16..20, numericality: true, presence: true

  validates :receiver_fio, presence: true

  # Произвести запрос на выплату
  def payout
    winpay.payout
    update!(response_payout: winpay.response.body)
  end

  # Проверить статус выплаты
  def check
    @result = winpay.check
    update!(response_check: winpay.response.body)
  end

  private

  # доступ к API Winpay
  def winpay
    @winpay ||= Winpay.new(self)
  end
end
