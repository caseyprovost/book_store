class ProductPropertiesController < ApplicationController
  def index
    product_properties = ProductPropertyResource.all(params)
    respond_with(product_properties)
  end

  def show
    product_property = ProductPropertyResource.find(params)
    respond_with(product_property)
  end

  def create
    product_property = ProductPropertyResource.build(params)

    if product_property.save
      render jsonapi: product_property, status: 201
    else
      render jsonapi_errors: product_property
    end
  end

  def update
    product_property = ProductPropertyResource.find(params)

    if product_property.update_attributes
      render jsonapi: product_property
    else
      render jsonapi_errors: product_property
    end
  end

  def destroy
    product_property = ProductPropertyResource.find(params)

    if product_property.destroy
      render jsonapi: {meta: {}}, status: 200
    else
      render jsonapi_errors: product_property
    end
  end
end
