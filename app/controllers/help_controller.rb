class HelpController < ApplicationController

  # HELP CUSTOMERS
  def new_customer
    render template: "help/customers/new"
  end

  def edit_customer
    render template: "help/customers/edit"
  end

  def show_customer
    render template: "help/customers/show"
  end

  def index_customers
    render template: "help/customers/index"
  end


  # HELP BOX MOVEMENTS
  def new_box_movement
    render template: "help/box_movements/new"
  end

  def edit_box_movement
    render template: "help/box_movements/edit"
  end

  def show_box_movement
    render template: "help/box_movements/show"
  end

  def index_box_movements
    render template: "help/box_movements/index"
  end

  # HELP VEHICLES
  def new_vehicle
    render template: "help/vehicles/new"
  end

  def edit_vehicle
    render template: "help/vehicles/edit"
  end

  def show_vehicle
    render template: "help/vehicles/show"
  end

  def index_vehicles
    render template: "help/vehicles/index"
  end

  # HELP WORK ORDERS
  def new_work_order
    render template: "help/work_orders/new"
  end

  def edit_work_order
    render template: "help/work_orders/edit"
  end

  def show_work_order
    render template: "help/work_orders/show"
  end

  def index_work_orders
    render template: "help/work_orders/index"
  end

  def print_work_order
    render template: "help/work_orders/print"
  end

  def budget_work_order
    render template: "help/work_orders/budget"
  end

  def print_budget_work_order
    render template: "help/work_orders/print_budget"
  end

  def deliver_work_order
    render template: "help/work_orders/deliver"
  end




  # HELP SETTINGS
  def show_iva
    render template: "help/settings/iva/show"
  end

  def edit_iva
    render template: "help/settings/iva/edit"
  end

  def new_user
    render template: "help/settings/users/new"
  end

  def edit_user
    render template: "help/settings/users/edit"
  end

  def show_user
    render template: "help/settings/users/show"
  end

  def index_users
    render template: "help/settings/users/index"
  end

  def new_car_brand
    render template: "help/settings/car_brands/new"
  end

  def edit_car_brand
    render template: "help/settings/car_brands/edit"
  end

  def show_car_brand
    render template: "help/settings/car_brands/show"
  end

  def index_car_brands
    render template: "help/settings/car_brands/index"
  end

end
