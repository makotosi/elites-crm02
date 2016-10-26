class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_customers, only: [:edit, :update, :show, :destroy]

  def index
    @q = Customer.search(params[:q])
    @customers = @q.result(distinct: true).page(params[:page]) 
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @customer.update
      redirect_to @customer
    else
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @customer.comments
  end

  def destroy
    @customer.destroy
    redirect_to root_path
  end

  private
  def customer_params
    params.require(:customer).permit(
      :family_name,
      :given_name,
      :email,
      :campany_id,
      :post_id
    )
  end

  def find_customers
    @customer = Customer.find(params[:id])
  end

end
