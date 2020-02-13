# Веб-сервис WinPay
class Winpay
  @payout = nil
  attr_reader :response

  # Проверить баланс
  def balance
    dt = dt_format(DateTime.now)
    call_api 'balance', DT: dt
  end

  def initialize(payout)
    @payout = payout
  end

  # Создать запрос на выплату
  def payout
    dt = dt_format(@payout.dt)
    call_api 'payout',
             ID: @payout.id,
             DT: dt,
             AMOUNT: @payout.amount,
             PHONE: @payout.phone,
             CLIENT: @payout.client,
             DESTINATION: @payout.destination,
             RECEIVER_FIO: @payout.receiver_fio
  end

  # Запрос статуса выплаты
  def check

  end

  private

  # Получить URL метода API для REST-клиента
  def method_url(method)
    "#{url_system}/partner/#{service_id}/#{method}"
  end

  # Вызвать API через REST-клиент и сохранить ответ
  def call_api(method, payload)
    hash_value = case method
                 when 'balance'
                   hash([payload[:DT]])
                 when 'payout'
                   hash([
                          payload[:ID],
                          payload[:DT],
                          payload[:AMOUNT],
                          payload[:PHONE],
                          payload[:CLIENT],
                          payload[:DESTINATION],
                        ])
                 end

    payload[:HASH] = hash_value

    @response = RestClient.post method_url(method), payload
  end

  def service_id
    Rails.application.credentials.winpay[:service_id]
  end

  def url_system
    Rails.application.credentials.winpay[:url_system]
  end

  def secret_key
    Rails.application.credentials.winpay[:secret_key]
  end

  # Формат: YYYY-MM-DD HH:MM:SS — напр. '2014-01-31 17:29:34'
  def dt_format(dt)
    dt.to_s(:db)
  end

  # Хэш-функция для подписи запросов
  def hash(fields)
    Digest::MD5.hexdigest fields.join + secret_key
  end
end
