class TransactionsController < ApplicationController
  before_action :check_role
  def credits
    @credits = @current_logged_user.credits    
  end

  def debits
    @debits = @current_logged_user.debits    
  end

  def index
  end

  def users
    @transaction = @current_logged_user.credits.new
  end

  def teams
    @transaction = @current_logged_user.credits.new
  end

  def stocks
    @transaction = @current_logged_user.credits.new
  end
  
  def withdraws
    @withdraws = @current_logged_user.withdraws    
  end

  def withdrawals
    @transaction = @current_logged_user.withdraws.new
  end

  def withdraw
    @transaction = @current_logged_user.withdraw(transaction_params[:amount])
    if @transaction.save
      redirect_to withdraws_transactions_path
    else
      render "withdrawals"
    end
  end

  def deposits
    @deposits = @current_logged_user.deposits    
  end

  def deposit
    @transaction = @current_logged_user.deposits.new
  end

  def topup
    @transaction = @current_logged_user.deposit(transaction_params[:amount])
    if @transaction.save
      redirect_to deposits_transactions_path
    else
      render "deposit"
    end
  end

  def withdraw
    @transaction = @current_logged_user.withdraw(transaction_params[:amount])
    if @transaction.save
      redirect_to withdraws_transactions_path
    else
      render "withdrawals"
    end
  end
  

  def create
    @transaction = @current_logged_user.transfer(targetable(transaction_params[:targetable_type], transaction_params[:targetable_id]), transaction_params[:amount])
    if @transaction.save
      redirect_to credits_transactions_path
    else
      render "#{transaction_params[:targetable_type].to_s.downcase}s"
    end
  end

  private
  def transaction_params
    params.require(:transaction).permit(:targetable_id, :amount, :targetable_type)
  end

  def targetable(targetable_type, id)
    eval("#{targetable_type}.find(#{id})")
  end
end
