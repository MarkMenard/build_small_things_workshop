# BEFORE

class Product

  def calculate_price (customer, customer_catalog, discount_policy)
    if customer_catalog.has_product?(self)
      price = base_price > customer_catalog.price_for_product(self) ? customer_catalog.price_for_product(self) : base_price
    end

    if discount_policy.applies_to_product?(self) && discount_policy.applies_to_customer(customer)
      price = price - discount_policy.get_discount(self, customer)
    end

    price
  end

end

# AFTER

class Product

  def calculate_price (customer, customer_catalog, discount_policy)
    PriceCalculator.new(self, customer, customer_catalog, discount_policy).calculate_price
  end

end


PriceCalculator = Struct.new(:product, :customer, :customer_catalog, :discount_policy) do

  def calulate_price
    if customer_catalog.has_product?(product)
      price = base_price > customer_catalog.price_for_product(product) ? customer_catalog.price_for_product(product) : base_price
    end

    if discount_policy.applies_to_product?(product) && discount_policy.applies_to_customer(customer)
      price = price - discount_policy.get_discount(product, customer)
    end

    price
  end

end