Update
=============
Obsolete as of spree 0.5.2, DO NOT USE with that or later versions

The following fix is still needed in 0.5.2 though

Admin::PaymentsController.class_eval do
  
  alias :old_fire  :fire
  
  def fire
    old_fire
    @payment.save
  end

end


SpreeCheckFix
=============

This adds a little "pay" button for checks in the list of payment, in the Admin/Order/Payments list
The be precise for payments with PaymentMethod::Check


Install
=======

Install in the usual way by adding gem to your Gemfile

  gem 'spree_check_fix',  :git => 'git://github.com/dancinglightning/spree-check-fix.git'
  
and run bundle install

There are no migrations or view changes

Hack!
====

Be aware that this is a HACK . It looks like Checks got forgotten in a rewrite of payments almost a year ago.

The architecture may now require a new class (equivalent to CreditCard) to set as Payment's source , but I have too little understanding to make such a larger change.

So this hack adds a pay action to Payment and a handles it in the PaymentController, both by monkey patching. You've been warned.

On the bright side, this works for me. We use only PaymentMethod::Check and get our payments to completed state with this.

Extension
========

If you need finer grained control, or cancellations, it should be easy to extend this now, just add to the actions and implement them in Payment_decorator 

Copyright (c) 2011 [Torsten Rüger], released under the New BSD License
