module InPlaceEditing
  def self.included(base)
    base.extend(ClassMethods)
  end

  # Example:
  #
  #   # Controller
  #   class BlogController < ApplicationController
  #     in_place_edit_for :post, :title
  #   end
  #
  #   # View
  #   <%= in_place_editor_field :post, 'title' %>
  #
  module ClassMethods
    def in_place_edit_for(object, attribute, options = {})
      define_method("set_#{object}_#{attribute}") do
        @item = object.to_s.camelize.constantize.find(params[:id])
        if @item.update_attributes({attribute.to_sym => params[:value]})
	    render :text => @item.send(attribute).to_s
	else
	    render :text => "<span style='color:red;'>#{@item.errors.on(attribute.to_sym)}</span>"
	end
      end
    end
  end
end
