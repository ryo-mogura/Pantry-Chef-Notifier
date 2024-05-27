class FoodsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @foods = current_user.foods
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def destroy
  end
end
