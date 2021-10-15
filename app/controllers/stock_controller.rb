class StockController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do | format |
          format.js { render partial: 'shared/result'}
        end
      else
        respond_to do | format |
          flash.now[:alert] = 'Please enter a valid stock symbol to lookup!'
          format.js { render partial: 'shared/result'}
        end
      end
    else
      respond_to do | format |
        flash.now[:alert] = 'Please enter a stock symbol to lookup!'
        format.js { render partial: 'shared/result'}
      end
    end
  end
end
  