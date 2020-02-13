# frozen_string_literal: true
class PayoutsController < ApplicationController
  http_basic_authenticate_with name: Rails.application.credentials.username,
                               password: Rails.application.credentials.password,
                               only: :index

  # GET /payouts
  def index
    @payouts = Payout.all
  end

  # GET /payouts/1
  def show
    @payout = Payout.find(params[:id])
  end

  # Показать баланс
  def balance
    @balance = Hash.from_xml(Winpay.new(nil).balance.body)['response']['balance']
  end

  # GET /payouts/new
  def new
    @payout = Payout.new
  end

  # POST /payouts
  def create
    @payout = Payout.new(payout_params)

    if @payout.save && @payout.payout
      redirect_to @payout, notice: 'Создан запрос на выплату.'
    else
      render :new
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def payout_params
    params.require(:payout).permit(:amount, :phone, :client, :receiver_fio)
  end
end
