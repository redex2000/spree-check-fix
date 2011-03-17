Admin::PaymentsController.class_eval do
  alias old_fire fire
  
  def fire
    load_object
    if event = params[:e]         #only respond to action we stubbed in Payment_decorator
      if @payment.payment_method.type == "PaymentMethod::Check" and event == "pay" 
        # checkout means new from admin side, pending means new on user side
        if @payment.state == "checkout" or @payment.state == "pending"
          @payment.pay
          @payment.order.update!
          @payment.order.save
          redirect_to collection_path
        end
      else
        return old_fire
      end
    end
  end
end

