Payment.class_eval do

  #used to alias, but that extra call pushes my stack over the limit   
  #alias old_actions actions
  
  def actions
    ret = [] 
    if payment_source and payment_source.respond_to? :actions
      ret = payment_source.actions.select { |action| !payment_source.respond_to?("can_#{action}?") or payment_source.send("can_#{action}?", self) }
    else
      ret << "pay"  if payment_source == nil and state != "completed" 
    end
    ret
  end
  
  def pay
    started_processing
    complete
  end
  
end
