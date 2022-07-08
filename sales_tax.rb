  # Cart class to store a list of all products added
  class Cart
    attr_reader :list, :total_price
    def initialize
      @list = []
      @total_price = 0
    end

    def get_product_details
      add_item = true
      while add_item
        puts 'Name of the product: '
        product = gets.chomp
        puts 'Imported?: '
        imported = gets.chomp
        puts 'Exempted from sales tax? '
        sales_tax_exempted = gets.chomp
        puts 'Price: '
        price = gets.chomp.to_f
        list << Product.new(product, price, sales_tax_exempted, imported)
        @total_price += list.last.price_with_taxes

        puts 'Do you want to add more items to your list(y/n): '
        add_item = gets.chomp == 'y'
      end
    end
  
    def show_list
      puts 'PRODUCT'.ljust(15) + '|' + 'PRICE'.ljust(7) + '|' + 'SALES TAX'.ljust(11) + '|' + 'IMPORT DUTY'.ljust(12) + '|TOTAL PRICE'
      list.each do |item|
        puts "#{item.product.ljust(15)}|#{item.price.to_s.ljust(7)}|#{item.sales_tax.to_s.ljust(11)}|#{item.import_duty.to_s.ljust(12)}|#{item.price_with_taxes}"
      end
      puts "GRAND TOTAL = #{total_price}".rjust(54)
    end
  end
  
  # Product class to handle individual product
  class Product
    YES_REGEXP = /y|yes/i.freeze
    attr_reader :product, :price, :sales_tax, :import_duty
    def initialize(product, price, sales_tax_exempted, imported)
      @product = product
      @price = price
      @sales_tax = calc_sales_tax(sales_tax_exempted, price)
      @import_duty = calc_import_duty(imported, price)
    end

    def price_with_taxes
      price + @sales_tax + @import_duty
    end

    private

    def calc_sales_tax(sales_tax_exempted, price)
      (YES_REGEXP.match? sales_tax_exempted) ? 0 : price * 0.1
    end

    def calc_import_duty(imported, price)
      (YES_REGEXP.match? imported) ? 0.05 * price : 0
    end
  end
  
  my_cart = Cart.new
  my_cart.get_product_details
  my_cart.show_list
