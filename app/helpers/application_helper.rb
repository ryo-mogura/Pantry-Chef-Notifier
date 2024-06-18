# frozen_string_literal: true

module ApplicationHelper
  def devise_mapping
    Devise.mappings[:user]
  end
  def resource_class
    devise_mapping.to
  end

  def resource_name
    devise_mapping.name
  end
end
