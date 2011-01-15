Admin::PaymentsController.class_eval do
  alias old_fire fire
  
  def fire
    load_object
    if event = params[:e] 
      if @payment.payment_source
        return old_fire 
      else  
        #Assume payment:check  TODO check this
        if event == "pay" #only respond to action we stubbed in Payment_decorator
          if @payment.state == "checkout" #and only for new paymnets
            @payment.pay
            redirect_to collection_path
          end
        end
      end
    end
  end
end

