 class ChargesController < ApplicationController

  def new
    @amount = 15_00
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user}",
      amount: @amount
    }
  end

  

  def downgrade1
    if current_user.premium?
    current_user.update_attribute(:role, 'standard')
    flash[:success] = "You have been downgraded to standard."
    redirect_to root_url
    else
      false
    end
   
  end

  def create
    @amount = 15_00

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )
if current_user.standard?
    current_user.update_attribute(:role, 'premium')
    flash[:success] = "Your payment has been receieved. Thank you!"
    redirect_to root_url
  else
    false
  end

  rescue Stripe::CardError => e
    current_user.update_attribute(:role, 'standard')
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end

