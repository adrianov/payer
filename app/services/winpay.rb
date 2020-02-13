# Веб-сервис WinPay
class Winpay
  @payout = nil
  attr_reader :response

  # Проверить баланс
  def self.balance
    dt = dt_format(DateTime.now)
    @response = RestClient.post method_url('balance'),
                    DT: dt,
                    HASH: hash([dt])
  end

  def initialize(payout)
    @payout = payout
  end

  # Создать запрос на выплату
  def payout

  end

  # Запрос статуса выплаты
  def check

  end

  private

  # Получить URL метода API для REST-клиента
  def self.method_url(method)
    "#{url_system}/partner/#{service_id}/#{method}"
  end

  def self.service_id
    Rails.application.credentials.winpay[:service_id]
  end

  def self.url_system
    Rails.application.credentials.winpay[:url_system]
  end

  def self.secret_key
    Rails.application.credentials.winpay[:secret_key]
  end

  # Формат: YYYY-MM-DD HH:MM:SS — напр. '2014-01-31 17:29:34'
  def self.dt_format(dt)
    dt.to_s(:db)
  end

  # Хэш-функция для подписи запросов
  def self.hash(fields)
    Digest::MD5.hexdigest fields.join + secret_key
  end

end
